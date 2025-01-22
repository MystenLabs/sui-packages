module 0x9fa42aa6f73652e3123701705731873bee2fc407b05777b96583bfa389277053::bet_manager {
    public fun black() : u8 {
        1
    }

    public fun corner_10_11_13_14() : u8 {
        94
    }

    public fun corner_11_12_14_15() : u8 {
        95
    }

    public fun corner_13_14_16_17() : u8 {
        96
    }

    public fun corner_14_15_17_18() : u8 {
        97
    }

    public fun corner_16_17_19_20() : u8 {
        98
    }

    public fun corner_17_18_20_21() : u8 {
        99
    }

    public fun corner_19_20_22_23() : u8 {
        100
    }

    public fun corner_1_2_4_5() : u8 {
        88
    }

    public fun corner_20_21_23_24() : u8 {
        101
    }

    public fun corner_22_23_25_26() : u8 {
        102
    }

    public fun corner_23_24_26_27() : u8 {
        103
    }

    public fun corner_25_26_28_29() : u8 {
        104
    }

    public fun corner_26_27_29_30() : u8 {
        105
    }

    public fun corner_28_29_31_32() : u8 {
        106
    }

    public fun corner_29_30_32_33() : u8 {
        107
    }

    public fun corner_2_3_5_6() : u8 {
        89
    }

    public fun corner_31_32_34_35() : u8 {
        108
    }

    public fun corner_32_33_35_36() : u8 {
        109
    }

    public fun corner_4_5_7_8() : u8 {
        90
    }

    public fun corner_5_6_8_9() : u8 {
        91
    }

    public fun corner_7_8_10_11() : u8 {
        92
    }

    public fun corner_8_9_11_12() : u8 {
        93
    }

    public fun double_street_0_00_1_2_3() : u8 {
        121
    }

    public fun double_street_10_11_12_13_14_15() : u8 {
        113
    }

    public fun double_street_13_14_15_16_17_18() : u8 {
        114
    }

    public fun double_street_16_17_18_19_20_21() : u8 {
        115
    }

    public fun double_street_19_20_21_22_23_24() : u8 {
        116
    }

    public fun double_street_1_2_3_4_5_6() : u8 {
        110
    }

    public fun double_street_22_23_24_25_26_27() : u8 {
        117
    }

    public fun double_street_25_26_27_28_29_30() : u8 {
        118
    }

    public fun double_street_28_29_30_31_32_33() : u8 {
        119
    }

    public fun double_street_31_32_33_34_35_36() : u8 {
        120
    }

    public fun double_street_4_5_6_7_8_9() : u8 {
        111
    }

    public fun double_street_7_8_9_10_11_12() : u8 {
        112
    }

    public fun even() : u8 {
        3
    }

    public fun first_column() : u8 {
        10
    }

    public fun first_eighteen() : u8 {
        8
    }

    public fun first_twelve() : u8 {
        5
    }

    public fun get_bet_payout(arg0: u64, arg1: u8) : u64 {
        let v0 = if (arg1 == 0) {
            true
        } else if (arg1 == 1) {
            true
        } else if (arg1 == 3) {
            true
        } else if (arg1 == 4) {
            true
        } else if (arg1 == 8) {
            true
        } else {
            arg1 == 9
        };
        if (v0) {
            return mul(arg0, 1000000000)
        };
        let v1 = if (arg1 == 5) {
            true
        } else if (arg1 == 6) {
            true
        } else if (arg1 == 7) {
            true
        } else if (arg1 == 10) {
            true
        } else if (arg1 == 11) {
            true
        } else {
            arg1 == 12
        };
        if (v1) {
            return mul(arg0, 2000000000)
        };
        if (arg1 == 2) {
            return mul(arg0, 35000000000)
        };
        if (arg1 >= 13 && arg1 <= 72) {
            return mul(arg0, 17000000000)
        };
        if (arg1 >= 73 && arg1 <= 87) {
            return mul(arg0, 11000000000)
        };
        if (arg1 >= 88 && arg1 <= 109) {
            return mul(arg0, 8000000000)
        };
        if (arg1 >= 110 && arg1 <= 120) {
            return mul(arg0, 5000000000)
        };
        assert!(arg1 == 121, 0);
        mul(arg0, 6200000000)
    }

    fun mul(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000) as u64)
    }

    public fun number() : u8 {
        2
    }

    public fun odd() : u8 {
        4
    }

    public fun red() : u8 {
        0
    }

    public fun second_column() : u8 {
        11
    }

    public fun second_eighteen() : u8 {
        9
    }

    public fun second_twelve() : u8 {
        6
    }

    public fun split_00_2_3() : u8 {
        74
    }

    public fun split_00_3() : u8 {
        15
    }

    public fun split_0_00() : u8 {
        13
    }

    public fun split_0_00_2() : u8 {
        73
    }

    public fun split_0_1() : u8 {
        14
    }

    public fun split_0_1_2() : u8 {
        75
    }

    public fun split_10_11() : u8 {
        22
    }

    public fun split_10_13() : u8 {
        49
    }

    public fun split_11_12() : u8 {
        23
    }

    public fun split_11_14() : u8 {
        50
    }

    public fun split_12_15() : u8 {
        51
    }

    public fun split_13_14() : u8 {
        24
    }

    public fun split_13_16() : u8 {
        52
    }

    public fun split_14_15() : u8 {
        25
    }

    public fun split_14_17() : u8 {
        53
    }

    public fun split_15_18() : u8 {
        54
    }

    public fun split_16_17() : u8 {
        26
    }

    public fun split_16_19() : u8 {
        55
    }

    public fun split_17_18() : u8 {
        27
    }

    public fun split_17_20() : u8 {
        56
    }

    public fun split_18_21() : u8 {
        57
    }

    public fun split_19_20() : u8 {
        28
    }

    public fun split_19_22() : u8 {
        58
    }

    public fun split_1_2() : u8 {
        16
    }

    public fun split_1_4() : u8 {
        40
    }

    public fun split_20_21() : u8 {
        29
    }

    public fun split_20_23() : u8 {
        59
    }

    public fun split_21_24() : u8 {
        60
    }

    public fun split_22_23() : u8 {
        30
    }

    public fun split_22_25() : u8 {
        61
    }

    public fun split_23_24() : u8 {
        31
    }

    public fun split_23_26() : u8 {
        62
    }

    public fun split_24_27() : u8 {
        63
    }

    public fun split_25_26() : u8 {
        32
    }

    public fun split_25_28() : u8 {
        64
    }

    public fun split_26_27() : u8 {
        33
    }

    public fun split_26_29() : u8 {
        65
    }

    public fun split_27_30() : u8 {
        66
    }

    public fun split_28_29() : u8 {
        34
    }

    public fun split_28_31() : u8 {
        67
    }

    public fun split_29_30() : u8 {
        35
    }

    public fun split_29_32() : u8 {
        68
    }

    public fun split_2_3() : u8 {
        17
    }

    public fun split_2_5() : u8 {
        41
    }

    public fun split_30_33() : u8 {
        69
    }

    public fun split_31_32() : u8 {
        36
    }

    public fun split_31_34() : u8 {
        70
    }

    public fun split_32_33() : u8 {
        37
    }

    public fun split_32_35() : u8 {
        71
    }

    public fun split_33_36() : u8 {
        72
    }

    public fun split_34_35() : u8 {
        38
    }

    public fun split_35_36() : u8 {
        39
    }

    public fun split_3_6() : u8 {
        42
    }

    public fun split_4_5() : u8 {
        18
    }

    public fun split_4_7() : u8 {
        43
    }

    public fun split_5_6() : u8 {
        19
    }

    public fun split_5_8() : u8 {
        44
    }

    public fun split_6_9() : u8 {
        45
    }

    public fun split_7_10() : u8 {
        46
    }

    public fun split_7_8() : u8 {
        20
    }

    public fun split_8_11() : u8 {
        47
    }

    public fun split_8_9() : u8 {
        21
    }

    public fun split_9_12() : u8 {
        48
    }

    public fun street_10_11_12() : u8 {
        79
    }

    public fun street_13_14_15() : u8 {
        80
    }

    public fun street_16_17_18() : u8 {
        81
    }

    public fun street_19_20_21() : u8 {
        82
    }

    public fun street_1_2_3() : u8 {
        76
    }

    public fun street_22_23_24() : u8 {
        83
    }

    public fun street_25_26_27() : u8 {
        84
    }

    public fun street_28_29_30() : u8 {
        85
    }

    public fun street_31_32_33() : u8 {
        86
    }

    public fun street_34_35_36() : u8 {
        87
    }

    public fun street_4_5_6() : u8 {
        77
    }

    public fun street_7_8_9() : u8 {
        78
    }

    public fun third_column() : u8 {
        12
    }

    public fun third_twelve() : u8 {
        7
    }

    public fun won_bet(arg0: u8, arg1: u64, arg2: 0x1::option::Option<u64>) : bool {
        if (arg0 == 2) {
            return 0x1::option::contains<u64>(&arg2, &arg1)
        };
        if (arg0 == 3) {
            if (arg1 == 0 || arg1 == 37) {
                return false
            };
            return arg1 % 2 == 0
        };
        if (arg0 == 4) {
            if (arg1 == 0 || arg1 == 37) {
                return false
            };
            return arg1 % 2 == 1
        };
        if (arg0 == 0) {
            return if (arg1 == 1) {
                true
            } else if (arg1 == 3) {
                true
            } else if (arg1 == 5) {
                true
            } else if (arg1 == 7) {
                true
            } else if (arg1 == 9) {
                true
            } else if (arg1 == 12) {
                true
            } else if (arg1 == 14) {
                true
            } else if (arg1 == 16) {
                true
            } else if (arg1 == 18) {
                true
            } else if (arg1 == 19) {
                true
            } else if (arg1 == 21) {
                true
            } else if (arg1 == 23) {
                true
            } else if (arg1 == 25) {
                true
            } else if (arg1 == 27) {
                true
            } else if (arg1 == 30) {
                true
            } else if (arg1 == 32) {
                true
            } else if (arg1 == 34) {
                true
            } else {
                arg1 == 36
            }
        };
        if (arg0 == 1) {
            return if (arg1 == 2) {
                true
            } else if (arg1 == 4) {
                true
            } else if (arg1 == 6) {
                true
            } else if (arg1 == 8) {
                true
            } else if (arg1 == 10) {
                true
            } else if (arg1 == 11) {
                true
            } else if (arg1 == 13) {
                true
            } else if (arg1 == 15) {
                true
            } else if (arg1 == 17) {
                true
            } else if (arg1 == 20) {
                true
            } else if (arg1 == 22) {
                true
            } else if (arg1 == 24) {
                true
            } else if (arg1 == 26) {
                true
            } else if (arg1 == 28) {
                true
            } else if (arg1 == 29) {
                true
            } else if (arg1 == 31) {
                true
            } else if (arg1 == 33) {
                true
            } else {
                arg1 == 35
            }
        };
        if (arg0 == 8) {
            return arg1 >= 1 && arg1 <= 18
        };
        if (arg0 == 9) {
            return arg1 >= 19 && arg1 <= 36
        };
        if (arg0 == 5) {
            return arg1 >= 1 && arg1 <= 12
        };
        if (arg0 == 6) {
            return arg1 >= 13 && arg1 <= 24
        };
        if (arg0 == 7) {
            return arg1 >= 25 && arg1 <= 36
        };
        if (arg0 == 10) {
            return (arg1 + 2) % 3 == 0
        };
        if (arg0 == 11) {
            return (arg1 + 1) % 3 == 0
        };
        if (arg0 == 12) {
            return arg1 % 3 == 0
        };
        if (arg0 == 13) {
            return arg1 == 0 || arg1 == 37
        };
        if (arg0 == 14) {
            return arg1 == 0 || arg1 == 1
        };
        if (arg0 == 15) {
            return arg1 == 37 || arg1 == 3
        };
        if (arg0 == 16) {
            return arg1 == 1 || arg1 == 2
        };
        if (arg0 == 17) {
            return arg1 == 2 || arg1 == 3
        };
        if (arg0 == 18) {
            return arg1 == 4 || arg1 == 5
        };
        if (arg0 == 19) {
            return arg1 == 5 || arg1 == 6
        };
        if (arg0 == 20) {
            return arg1 == 7 || arg1 == 8
        };
        if (arg0 == 21) {
            return arg1 == 8 || arg1 == 9
        };
        if (arg0 == 22) {
            return arg1 == 10 || arg1 == 11
        };
        if (arg0 == 23) {
            return arg1 == 11 || arg1 == 12
        };
        if (arg0 == 24) {
            return arg1 == 13 || arg1 == 14
        };
        if (arg0 == 25) {
            return arg1 == 14 || arg1 == 15
        };
        if (arg0 == 26) {
            return arg1 == 16 || arg1 == 17
        };
        if (arg0 == 27) {
            return arg1 == 17 || arg1 == 18
        };
        if (arg0 == 28) {
            return arg1 == 19 || arg1 == 20
        };
        if (arg0 == 29) {
            return arg1 == 20 || arg1 == 21
        };
        if (arg0 == 30) {
            return arg1 == 22 || arg1 == 23
        };
        if (arg0 == 31) {
            return arg1 == 23 || arg1 == 24
        };
        if (arg0 == 32) {
            return arg1 == 25 || arg1 == 26
        };
        if (arg0 == 33) {
            return arg1 == 26 || arg1 == 27
        };
        if (arg0 == 34) {
            return arg1 == 28 || arg1 == 29
        };
        if (arg0 == 35) {
            return arg1 == 29 || arg1 == 30
        };
        if (arg0 == 36) {
            return arg1 == 31 || arg1 == 32
        };
        if (arg0 == 37) {
            return arg1 == 32 || arg1 == 33
        };
        if (arg0 == 38) {
            return arg1 == 34 || arg1 == 35
        };
        if (arg0 == 39) {
            return arg1 == 35 || arg1 == 36
        };
        if (arg0 == 40) {
            return arg1 == 1 || arg1 == 4
        };
        if (arg0 == 41) {
            return arg1 == 2 || arg1 == 5
        };
        if (arg0 == 42) {
            return arg1 == 3 || arg1 == 6
        };
        if (arg0 == 43) {
            return arg1 == 4 || arg1 == 7
        };
        if (arg0 == 44) {
            return arg1 == 5 || arg1 == 8
        };
        if (arg0 == 45) {
            return arg1 == 6 || arg1 == 9
        };
        if (arg0 == 46) {
            return arg1 == 7 || arg1 == 10
        };
        if (arg0 == 47) {
            return arg1 == 8 || arg1 == 11
        };
        if (arg0 == 48) {
            return arg1 == 9 || arg1 == 12
        };
        if (arg0 == 49) {
            return arg1 == 10 || arg1 == 13
        };
        if (arg0 == 50) {
            return arg1 == 11 || arg1 == 14
        };
        if (arg0 == 51) {
            return arg1 == 12 || arg1 == 15
        };
        if (arg0 == 52) {
            return arg1 == 13 || arg1 == 16
        };
        if (arg0 == 53) {
            return arg1 == 14 || arg1 == 17
        };
        if (arg0 == 54) {
            return arg1 == 15 || arg1 == 18
        };
        if (arg0 == 55) {
            return arg1 == 16 || arg1 == 19
        };
        if (arg0 == 56) {
            return arg1 == 17 || arg1 == 20
        };
        if (arg0 == 57) {
            return arg1 == 18 || arg1 == 21
        };
        if (arg0 == 58) {
            return arg1 == 19 || arg1 == 22
        };
        if (arg0 == 59) {
            return arg1 == 20 || arg1 == 23
        };
        if (arg0 == 60) {
            return arg1 == 21 || arg1 == 24
        };
        if (arg0 == 61) {
            return arg1 == 22 || arg1 == 25
        };
        if (arg0 == 62) {
            return arg1 == 23 || arg1 == 26
        };
        if (arg0 == 63) {
            return arg1 == 24 || arg1 == 27
        };
        if (arg0 == 64) {
            return arg1 == 25 || arg1 == 28
        };
        if (arg0 == 65) {
            return arg1 == 26 || arg1 == 29
        };
        if (arg0 == 66) {
            return arg1 == 27 || arg1 == 30
        };
        if (arg0 == 67) {
            return arg1 == 28 || arg1 == 31
        };
        if (arg0 == 68) {
            return arg1 == 29 || arg1 == 32
        };
        if (arg0 == 69) {
            return arg1 == 30 || arg1 == 33
        };
        if (arg0 == 70) {
            return arg1 == 31 || arg1 == 34
        };
        if (arg0 == 71) {
            return arg1 == 32 || arg1 == 35
        };
        if (arg0 == 72) {
            return arg1 == 33 || arg1 == 36
        };
        if (arg0 == 73) {
            let v2 = vector[0, 37, 2];
            return 0x1::vector::contains<u64>(&v2, &arg1)
        };
        if (arg0 == 74) {
            let v3 = vector[37, 2, 3];
            return 0x1::vector::contains<u64>(&v3, &arg1)
        };
        if (arg0 == 75) {
            let v4 = vector[0, 1, 2];
            return 0x1::vector::contains<u64>(&v4, &arg1)
        };
        if (arg0 == 76) {
            let v5 = vector[1, 2, 3];
            return 0x1::vector::contains<u64>(&v5, &arg1)
        };
        if (arg0 == 77) {
            let v6 = vector[4, 5, 6];
            return 0x1::vector::contains<u64>(&v6, &arg1)
        };
        if (arg0 == 78) {
            let v7 = vector[7, 8, 9];
            return 0x1::vector::contains<u64>(&v7, &arg1)
        };
        if (arg0 == 79) {
            let v8 = vector[10, 11, 12];
            return 0x1::vector::contains<u64>(&v8, &arg1)
        };
        if (arg0 == 80) {
            let v9 = vector[13, 14, 15];
            return 0x1::vector::contains<u64>(&v9, &arg1)
        };
        if (arg0 == 81) {
            let v10 = vector[16, 17, 18];
            return 0x1::vector::contains<u64>(&v10, &arg1)
        };
        if (arg0 == 82) {
            let v11 = vector[19, 20, 21];
            return 0x1::vector::contains<u64>(&v11, &arg1)
        };
        if (arg0 == 83) {
            let v12 = vector[22, 23, 24];
            return 0x1::vector::contains<u64>(&v12, &arg1)
        };
        if (arg0 == 84) {
            let v13 = vector[25, 26, 27];
            return 0x1::vector::contains<u64>(&v13, &arg1)
        };
        if (arg0 == 85) {
            let v14 = vector[28, 29, 30];
            return 0x1::vector::contains<u64>(&v14, &arg1)
        };
        if (arg0 == 86) {
            let v15 = vector[31, 32, 33];
            return 0x1::vector::contains<u64>(&v15, &arg1)
        };
        if (arg0 == 87) {
            let v16 = vector[34, 35, 36];
            return 0x1::vector::contains<u64>(&v16, &arg1)
        };
        if (arg0 == 88) {
            let v17 = vector[1, 2, 4, 5];
            return 0x1::vector::contains<u64>(&v17, &arg1)
        };
        if (arg0 == 89) {
            let v18 = vector[2, 3, 5, 6];
            return 0x1::vector::contains<u64>(&v18, &arg1)
        };
        if (arg0 == 90) {
            let v19 = vector[4, 5, 7, 8];
            return 0x1::vector::contains<u64>(&v19, &arg1)
        };
        if (arg0 == 91) {
            let v20 = vector[5, 6, 8, 9];
            return 0x1::vector::contains<u64>(&v20, &arg1)
        };
        if (arg0 == 92) {
            let v21 = vector[7, 8, 10, 11];
            return 0x1::vector::contains<u64>(&v21, &arg1)
        };
        if (arg0 == 93) {
            let v22 = vector[8, 9, 11, 12];
            return 0x1::vector::contains<u64>(&v22, &arg1)
        };
        if (arg0 == 94) {
            let v23 = vector[10, 11, 13, 14];
            return 0x1::vector::contains<u64>(&v23, &arg1)
        };
        if (arg0 == 95) {
            let v24 = vector[11, 12, 14, 15];
            return 0x1::vector::contains<u64>(&v24, &arg1)
        };
        if (arg0 == 96) {
            let v25 = vector[13, 14, 16, 17];
            return 0x1::vector::contains<u64>(&v25, &arg1)
        };
        if (arg0 == 97) {
            let v26 = vector[14, 15, 17, 18];
            return 0x1::vector::contains<u64>(&v26, &arg1)
        };
        if (arg0 == 98) {
            let v27 = vector[16, 17, 19, 20];
            return 0x1::vector::contains<u64>(&v27, &arg1)
        };
        if (arg0 == 99) {
            let v28 = vector[17, 18, 20, 21];
            return 0x1::vector::contains<u64>(&v28, &arg1)
        };
        if (arg0 == 100) {
            let v29 = vector[19, 20, 22, 23];
            return 0x1::vector::contains<u64>(&v29, &arg1)
        };
        if (arg0 == 101) {
            let v30 = vector[20, 21, 23, 24];
            return 0x1::vector::contains<u64>(&v30, &arg1)
        };
        if (arg0 == 102) {
            let v31 = vector[22, 23, 25, 26];
            return 0x1::vector::contains<u64>(&v31, &arg1)
        };
        if (arg0 == 103) {
            let v32 = vector[23, 24, 26, 27];
            return 0x1::vector::contains<u64>(&v32, &arg1)
        };
        if (arg0 == 104) {
            let v33 = vector[25, 26, 28, 29];
            return 0x1::vector::contains<u64>(&v33, &arg1)
        };
        if (arg0 == 105) {
            let v34 = vector[26, 27, 29, 30];
            return 0x1::vector::contains<u64>(&v34, &arg1)
        };
        if (arg0 == 106) {
            let v35 = vector[28, 29, 31, 32];
            return 0x1::vector::contains<u64>(&v35, &arg1)
        };
        if (arg0 == 107) {
            let v36 = vector[29, 30, 32, 33];
            return 0x1::vector::contains<u64>(&v36, &arg1)
        };
        if (arg0 == 108) {
            let v37 = vector[31, 32, 34, 35];
            return 0x1::vector::contains<u64>(&v37, &arg1)
        };
        if (arg0 == 109) {
            let v38 = vector[32, 33, 35, 36];
            return 0x1::vector::contains<u64>(&v38, &arg1)
        };
        if (arg0 == 121) {
            let v39 = vector[0, 37, 1, 2, 3];
            return 0x1::vector::contains<u64>(&v39, &arg1)
        };
        if (arg0 == 110) {
            let v40 = vector[1, 2, 3, 4, 5, 6];
            return 0x1::vector::contains<u64>(&v40, &arg1)
        };
        if (arg0 == 111) {
            let v41 = vector[4, 5, 6, 7, 8, 9];
            return 0x1::vector::contains<u64>(&v41, &arg1)
        };
        if (arg0 == 112) {
            let v42 = vector[7, 8, 9, 10, 11, 12];
            return 0x1::vector::contains<u64>(&v42, &arg1)
        };
        if (arg0 == 113) {
            let v43 = vector[10, 11, 12, 13, 14, 15];
            return 0x1::vector::contains<u64>(&v43, &arg1)
        };
        if (arg0 == 114) {
            let v44 = vector[13, 14, 15, 16, 17, 18];
            return 0x1::vector::contains<u64>(&v44, &arg1)
        };
        if (arg0 == 115) {
            let v45 = vector[16, 17, 18, 19, 20, 21];
            return 0x1::vector::contains<u64>(&v45, &arg1)
        };
        if (arg0 == 116) {
            let v46 = vector[19, 20, 21, 22, 23, 24];
            return 0x1::vector::contains<u64>(&v46, &arg1)
        };
        if (arg0 == 117) {
            let v47 = vector[22, 23, 24, 25, 26, 27];
            return 0x1::vector::contains<u64>(&v47, &arg1)
        };
        if (arg0 == 118) {
            let v48 = vector[25, 26, 27, 28, 29, 30];
            return 0x1::vector::contains<u64>(&v48, &arg1)
        };
        if (arg0 == 119) {
            let v49 = vector[28, 29, 30, 31, 32, 33];
            return 0x1::vector::contains<u64>(&v49, &arg1)
        };
        if (arg0 == 120) {
            let v50 = vector[31, 32, 33, 34, 35, 36];
            return 0x1::vector::contains<u64>(&v50, &arg1)
        };
        false
    }

    // decompiled from Move bytecode v6
}

