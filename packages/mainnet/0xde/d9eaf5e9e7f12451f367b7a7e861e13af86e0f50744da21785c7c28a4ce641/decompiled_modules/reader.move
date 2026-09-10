module 0xded9eaf5e9e7f12451f367b7a7e861e13af86e0f50744da21785c7c28a4ce641::reader {
    public fun current(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking) : (u64, u64, u64, u64, bool, bool, u64, bool) {
        let v0 = 0x1::bcs::to_bytes<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking>(arg2);
        assert!(0x1::vector::length<u8>(&v0) <= 65536, 920);
        let v1 = 0x2::bcs::new(v0);
        0x2::bcs::peel_address(&mut v1);
        let v2 = 0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u32(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_address(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_address(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_address(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        let v3 = 0x2::bcs::peel_u64(&mut v1);
        let v4 = 0x2::bcs::peel_vec_length(&mut v1);
        assert!(v4 <= 1024, 920);
        let v5 = 0;
        while (v5 < v4) {
            0x2::bcs::peel_address(&mut v1);
            v5 = v5 + 1;
        };
        let v6 = 0x2::bcs::peel_vec_length(&mut v1);
        assert!(v6 <= 1024, 920);
        v5 = 0;
        while (v5 < v6) {
            0x2::bcs::peel_address(&mut v1);
            v5 = v5 + 1;
        };
        0x2::bcs::peel_address(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        let v7 = 0x2::bcs::into_remainder_bytes(v1);
        assert!(0x1::vector::is_empty<u8>(&v7), 920);
        let v8 = 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::get_hawal_supply(arg2);
        let v9 = if (0x2::bcs::peel_u64(&mut v1) == 1) {
            if (0x2::bcs::peel_u64(&mut v1) == 0) {
                if (0x2::bcs::peel_u64(&mut v1) <= 10000000) {
                    if (0x2::bcs::peel_u64(&mut v1) <= 10000000) {
                        if (v2 <= 10000000) {
                            if (0x2::bcs::peel_u64(&mut v1) <= 1024) {
                                if (v4 <= v6) {
                                    if (0x2::bcs::peel_u64(&mut v1) == v6) {
                                        if (0x2::bcs::peel_u64(&mut v1) == v3) {
                                            v3 == v8
                                        } else {
                                            false
                                        }
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        (0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::get_total_wal(arg2), v8, v2, 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::get_total_instant_unstake_wal(arg0, arg1, arg2), 0x2::bcs::peel_bool(&mut v1), 0x2::bcs::peel_bool(&mut v1), v4, v9)
    }

    public fun staking_bcs(arg0: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking) : vector<u8> {
        0x1::bcs::to_bytes<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking>(arg0)
    }

    // decompiled from Move bytecode v7
}

