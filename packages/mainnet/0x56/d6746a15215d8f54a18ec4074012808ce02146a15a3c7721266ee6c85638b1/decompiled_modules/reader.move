module 0x56d6746a15215d8f54a18ec4074012808ce02146a15a3c7721266ee6c85638b1::reader {
    public fun current<T0>(arg0: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg1: &0x2::tx_context::TxContext) : (u64, u64, u64, u64, bool) {
        let v0 = 0x1::bcs::to_bytes<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>>(arg0);
        let v1 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::fee_config<T0>(arg0);
        (0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_sui_supply<T0>(arg0), 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_lst_supply<T0>(arg0), 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::sui_mint_fee_bps(v1), 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::redeem_fee_bps(v1), decode_last_refresh_epoch(&v0) != 0x2::tx_context::epoch(arg1))
    }

    fun decode_last_refresh_epoch(arg0: &vector<u8>) : u64 {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 <= 16384, 1);
        let v1 = 0;
        let v2 = &mut v1;
        skip(v2, 72, v0);
        let v3 = &mut v1;
        assert!(read_uleb128(arg0, v3) == 1, 1);
        let v4 = &mut v1;
        skip(v4, 88, v0);
        let v5 = &mut v1;
        skip(v5, 24, v0);
        let v6 = &mut v1;
        let v7 = read_uleb128(arg0, v6);
        assert!(v7 <= 50, 1);
        let v8 = 0;
        while (v8 < v7) {
            let v9 = &mut v1;
            skip(v9, 64, v0);
            let v10 = &mut v1;
            skip_option(arg0, v10, 72, v0);
            let v11 = &mut v1;
            skip_option(arg0, v11, 80, v0);
            let v12 = &mut v1;
            skip(v12, 64, v0);
            v8 = v8 + 1;
        };
        let v13 = &mut v1;
        skip(v13, 8, v0);
        let v14 = &mut v1;
        read_u64_le(arg0, v14)
    }

    public fun pool_bcs<T0>(arg0: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>) : vector<u8> {
        0x1::bcs::to_bytes<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>>(arg0)
    }

    fun read_at(arg0: &vector<u8>, arg1: u64) : u8 {
        assert!(arg1 < 0x1::vector::length<u8>(arg0), 1);
        *0x1::vector::borrow<u8>(arg0, arg1)
    }

    fun read_u64_le(arg0: &vector<u8>, arg1: &mut u64) : u64 {
        skip(arg1, 8, 0x1::vector::length<u8>(arg0));
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 | (read_at(arg0, *arg1 - 8 + v1) as u64) << ((v1 * 8) as u8);
            v1 = v1 + 1;
        };
        v0
    }

    fun read_u8(arg0: &vector<u8>, arg1: &mut u64) : u8 {
        *arg1 = *arg1 + 1;
        read_at(arg0, *arg1)
    }

    fun read_uleb128(arg0: &vector<u8>, arg1: &mut u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3;
        loop {
            assert!(v2 < 5, 1);
            let v4 = read_u8(arg0, arg1);
            v3 = ((v4 & 127) as u64) << v1;
            v0 = v0 | v3;
            v2 = v2 + 1;
            if (v4 & 128 == 0) {
                break
            };
            v1 = v1 + 7;
        };
        assert!(v2 == 1 || v3 != 0, 1);
        v0
    }

    fun skip(arg0: &mut u64, arg1: u64, arg2: u64) {
        assert!(*arg0 <= arg2 && arg1 <= arg2 - *arg0, 1);
        *arg0 = *arg0 + arg1;
    }

    fun skip_option(arg0: &vector<u8>, arg1: &mut u64, arg2: u64, arg3: u64) {
        let v0 = read_uleb128(arg0, arg1);
        assert!(v0 <= 1, 1);
        if (v0 == 1) {
            skip(arg1, arg2, arg3);
        };
    }

    // decompiled from Move bytecode v7
}

