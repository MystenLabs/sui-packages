module 0xaf05fd9b0a196ee214721b0894f854f6a3c4735a0a6bf3e45f6a827e7766ce37::bet_manager {
    fun mul(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000) as u64)
    }

    public fun payout_amount(arg0: u64, arg1: u8, arg2: u64) : u64 {
        if (arg1 > 9) {
            abort 0
        };
        if (arg1 >= 1 && arg1 <= 6) {
            assert!(arg2 >= 4500, 1);
            return mul(arg0, arg2)
        };
        arg0
    }

    public fun player_won(arg0: u8, arg1: u8) : bool {
        arg0 == 8 && arg1 % 2 == 0 || arg0 == 7 && arg1 % 2 == 1 || arg0 == 0 && arg1 <= 3 || arg0 == 9 && arg1 >= 4 || arg1 == arg0
    }

    // decompiled from Move bytecode v6
}

