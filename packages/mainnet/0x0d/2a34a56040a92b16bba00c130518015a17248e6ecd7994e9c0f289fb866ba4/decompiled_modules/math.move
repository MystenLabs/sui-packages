module 0x2020d7ebce426aead22a743b8b0f454302be8fb982837e02ef5a75f45466fb9::math {
    public fun bytes_to_u256(arg0: &vector<u8>) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, v1) as u256);
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_result(arg0: u256) : u64 {
        ((arg0 % 9950000) as u64)
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

