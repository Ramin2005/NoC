LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY RoutingUnit IS
    GENERIC (
        X : INTEGER := 0;
        Y : INTEGER := 0
    );
    PORT (
        DataIn : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        DataOutU : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        EnableOutU : OUT STD_LOGIC;
        DataOutD : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        EnableOutD : OUT STD_LOGIC;
        DataOutL : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        EnableOutL : OUT STD_LOGIC;
        DataOutR : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        EnableOutR : OUT STD_LOGIC;
        DataOutPE : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        EnableOutPE : OUT STD_LOGIC
    );
END ENTITY RoutingUnit;

ARCHITECTURE Struct OF RoutingUnit IS
    SIGNAL XTarget, YTarget : INTEGER;
BEGIN
    YTarget <= to_integer(unsigned(DataIn(15 DOWNTO 14)));
    XTarget <= to_integer(unsigned(DataIn(13 DOWNTO 12)));

    PROCESS (DataIn, XTarget, YTarget)
    BEGIN

        DataOutU <= (OTHERS => '0');
        EnableOutU <= '0';
        DataOutD <= (OTHERS => '0');
        EnableOutD <= '0';
        DataOutL <= (OTHERS => '0');
        EnableOutL <= '0';
        DataOutR <= (OTHERS => '0');
        EnableOutR <= '0';
        DataOutPe <= (OTHERS => '0');
        EnableOutPE <= '0';

        IF XTarget = X AND YTarget = Y THEN

            DataOutPE <= DataIn;
            EnableOutPE <= '1';

        ELSE

            IF XTarget = X THEN

                IF YTarget < Y THEN
                    DataOutD <= DataIn;
                    EnableOutD <= '1';
                ELSE
                    DataOutU <= DataIn;
                    EnableOutU <= '1';
                END IF;

            ELSIF XTarget < X THEN
                DataOutL <= DataIn;
                EnableOutL <= '1';
            ELSE
                DataOutR <= DataIn;
                EnableOutR <= '1';
            END IF;

        END IF;
    END PROCESS;
END Struct;
