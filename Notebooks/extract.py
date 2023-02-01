import numpy as np
import pandas as pd

class ExtractData:

    def extract_mass_spectrum(self, output_file):
        """
        Parameters
        ----------

        output_file : str
            path of the spectrZ3_P2.dat file
        """
        spect_info = []
        with open(output_file, 'r') as f:
            lines = f.readlines()
            get_data = False
            
            for line in lines:
                line = line.strip()
                if line.startswith('BLOCK MASS'):
                    get_data = True
                    continue
                if not get_data:
                    continue
                if line == '':
                    continue
                if line.startswith('#'):
                    continue
                data = line.split()
                try:
                    comment_index = line.index('#')
                    comment = line[comment_index:].strip("#").strip()
                    spect_info.append([int(data[0]), float(data[1]), comment])
                except ValueError:
                    break

        df = pd.DataFrame(spect_info, columns=['PDG Code', 'Mass', 'Particle Name'])
        return df

    def extract_mixing(self, output_file, col:list, row:list, block_name='BLOCK NMHMIX',
                         mixing="# 3*3 Higgs mixing"):
        """
        Parameters
        ----------
        output_file : str
            path of the spectrZ3_P2.dat file

        col : list
            list of the column names, like: ['h1', 'h2', 'h3']

        row : list
            list of the row names, like: ['h1', 'h2', 'h3']

        block_name : str
            block name of the mixing matrix, default is 'BLOCK NMHMIX'

        mixing : str
            mixing matrix name, default is "# 3*3 Higgs mixing"

        Returns
        -------
        df : pandas.DataFrame
            DataFrame of the mixing matrix
        """
        nmhmix_info = []
        matrix_shape = [len(row),len(col)]
        with open(output_file, 'r') as f:
            lines = f.readlines()
            get_data = False

        for line in lines:
            line = line.strip()
            if line==mixing or line==block_name:
                get_data = True
                continue
            if not get_data:
                continue
            if line == '':
                continue
            if line.startswith('#'):
                continue
            data = line.split()
            try:
                comment = line.split('#')[-1].strip()
                nmhmix_info.append([ int(data[0]), int(data[1]), float(data[2]), comment])
            except ValueError:
                break

        df = pd.DataFrame(nmhmix_info, columns=["Row", "Col", 'Percent', 'Comment'])
        df = df.drop(['Row',"Col"], axis=1)
        arr = (np.array(df['Percent']).reshape(matrix_shape)**2)*100
        df = pd.DataFrame(arr, columns=col, index=row)
        return df

    def change_parameters(self, input_file, parameter, value):
        """
        Parameters
        ----------
        input_file : str
            path of the input file, like: inpZ3_P1.dat file

        parameter : str
            parameter to be changed, like: TANB at MZ, LAMBDA, KAPPA (If =/= 0)

        value : float
            value of the parameter to be changed

        Returns
        -------
            Changes the parameter in the input file

        """

        # read the file content which needs to be modified
        with open(input_file, 'r') as f:
            file_content = f.readlines()

        # variable to store all the lines for modified file
        all_lines = ""

        for line in file_content:
            
            # check if the line contains the parameter
            if parameter in [word.strip() for word in line.split("#")]:

                # tan_beta line
                if parameter == "TANB at MZ":
                    line = f"        3	{value}		# TANB at MZ\n"

                # lambda line
                elif parameter == "LAMBDA":
                    line = f"	61	{value}		# LAMBDA\n"

                # KAPPA line
                elif parameter == "KAPPA (If =/= 0)":
                    line = f"	62	{value}		# KAPPA (If =/= 0)\n"


            all_lines += line

        # write the modified content to the file
        with open(input_file, "w") as f:
            f.writelines(all_lines)

