module 0x6eb0205627621a882b9e478b3103a961d5e249e10fef550dc8a9032ce86c0a61::bet_manager {
    public fun black() : u8 {
        1
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
        if (arg1 == 0 || arg1 == 1 || arg1 == 3 || arg1 == 4 || arg1 == 8 || arg1 == 9) {
            return mul(arg0, 1000000000)
        };
        if (arg1 == 5 || arg1 == 6 || arg1 == 7 || arg1 == 10 || arg1 == 11 || arg1 == 12) {
            return mul(arg0, 2000000000)
        };
        assert!(arg1 == 2, 0);
        mul(arg0, 35000000000)
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
        if (arg1 == 0 || arg1 == 37) {
            return false
        };
        if (arg0 == 3) {
            return arg1 % 2 == 0
        };
        if (arg0 == 4) {
            return arg1 % 2 == 1
        };
        if (arg0 == 0) {
            return arg1 == 1 || arg1 == 3 || arg1 == 5 || arg1 == 7 || arg1 == 9 || arg1 == 12 || arg1 == 14 || arg1 == 16 || arg1 == 18 || arg1 == 19 || arg1 == 21 || arg1 == 23 || arg1 == 25 || arg1 == 27 || arg1 == 30 || arg1 == 32 || arg1 == 34 || arg1 == 36
        };
        if (arg0 == 1) {
            return arg1 == 2 || arg1 == 4 || arg1 == 6 || arg1 == 8 || arg1 == 10 || arg1 == 11 || arg1 == 13 || arg1 == 15 || arg1 == 17 || arg1 == 20 || arg1 == 22 || arg1 == 24 || arg1 == 26 || arg1 == 28 || arg1 == 29 || arg1 == 31 || arg1 == 33 || arg1 == 35
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
        false
    }

    // decompiled from Move bytecode v6
}

