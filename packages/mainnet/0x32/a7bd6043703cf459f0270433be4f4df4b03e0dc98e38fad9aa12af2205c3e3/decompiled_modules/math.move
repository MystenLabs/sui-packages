module 0x32a7bd6043703cf459f0270433be4f4df4b03e0dc98e38fad9aa12af2205c3e3::math {
    public fun get_result(arg0: u256) : u64 {
        ((arg0 % 9901000) as u64)
    }

    public fun get_threshold(arg0: u64) : u64 {
        let v0 = arg0 - 1;
        ((100 * arg0 - 10000) * 100000 + v0) / v0
    }

    fun mul(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 100) as u64)
    }

    public fun payout_amount(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 >= 101 && arg1 <= 10000, 0);
        mul(arg0, arg1 - 100)
    }

    public fun player_won(arg0: u64, arg1: u256) : bool {
        let v0 = get_result(arg1);
        v0 % 69 == 0 && false || v0 > get_threshold(arg0)
    }

    // decompiled from Move bytecode v6
}

