LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY RoutingUnit IS
    GENERIC (
        X : unsigned(1 DOWNTO 0) := "00";
        Y : unsigned(1 DOWNTO 0) := "00"
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
    SIGNAL UXT, UYT : unsigned(1 DOWNTO 0);
BEGIN
    UXT <= unsigned(DataIn(15 DOWNTO 14));
    UYT <= unsigned(DataIn(13 DOWNTO 14));

    IF UXT = X AND UYT = Y THEN

        DataOutPE <= DataIn;
        EnableOutPE <= '1';

    ELSE

        IF UXT = X THEN

            IF UYT < Y THEN
                DataOutD <= DataIn;
                EnableOutD <= '1';
            ELSE
                DataOutU <= DataIn;
                EnableOutU <= '1';
            END IF;

        ELSIF UXT < X THEN
            DataOutL <= DataIn;
            EnableOutL <= '1';
        ELSE
            DataOutR <= DataIn;
            EnableOutR <= '1';
        END IF;

    END IF;

END Struct;