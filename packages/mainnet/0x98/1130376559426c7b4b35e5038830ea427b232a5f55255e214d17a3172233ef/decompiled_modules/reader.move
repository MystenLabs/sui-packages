module 0x981130376559426c7b4b35e5038830ea427b232a5f55255e214d17a3172233ef::reader {
    public fun current(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking) : (u64, u64, u64, u64, bool, bool, u64, bool) {
        current_for_direction(arg0, arg1, arg2, false)
    }

    public fun current_for_direction(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg3: bool) : (u64, u64, u64, u64, bool, bool, u64, bool) {
        let v0 = 0x1::bcs::to_bytes<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking>(arg2);
        assert!(0x1::vector::length<u8>(&v0) <= 65536, 920);
        let v1 = 0x981130376559426c7b4b35e5038830ea427b232a5f55255e214d17a3172233ef::cursor::new(v0);
        0x981130376559426c7b4b35e5038830ea427b232a5f55255e214d17a3172233ef::cursor::skip(&mut v1, 32);
        let v2 = 0x981130376559426c7b4b35e5038830ea427b232a5f55255e214d17a3172233ef::cursor::read_u64(&mut v1);
        0x981130376559426c7b4b35e5038830ea427b232a5f55255e214d17a3172233ef::cursor::skip(&mut v1, 8);
        0x981130376559426c7b4b35e5038830ea427b232a5f55255e214d17a3172233ef::cursor::skip(&mut v1, 20);
        0x981130376559426c7b4b35e5038830ea427b232a5f55255e214d17a3172233ef::cursor::skip(&mut v1, 112);
        0x981130376559426c7b4b35e5038830ea427b232a5f55255e214d17a3172233ef::cursor::skip(&mut v1, 56);
        let v3 = 0x981130376559426c7b4b35e5038830ea427b232a5f55255e214d17a3172233ef::cursor::read_u64(&mut v1);
        let v4 = 0x981130376559426c7b4b35e5038830ea427b232a5f55255e214d17a3172233ef::cursor::length(&mut v1);
        assert!(v4 <= 1024, 920);
        0x981130376559426c7b4b35e5038830ea427b232a5f55255e214d17a3172233ef::cursor::skip(&mut v1, v4 * 32);
        let v5 = 0x981130376559426c7b4b35e5038830ea427b232a5f55255e214d17a3172233ef::cursor::length(&mut v1);
        assert!(v5 <= 1024, 920);
        0x981130376559426c7b4b35e5038830ea427b232a5f55255e214d17a3172233ef::cursor::skip(&mut v1, v5 * 32);
        0x981130376559426c7b4b35e5038830ea427b232a5f55255e214d17a3172233ef::cursor::skip(&mut v1, 32);
        0x981130376559426c7b4b35e5038830ea427b232a5f55255e214d17a3172233ef::cursor::skip(&mut v1, 8);
        assert!(0x981130376559426c7b4b35e5038830ea427b232a5f55255e214d17a3172233ef::cursor::is_empty(&v1), 920);
        let v6 = 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::get_hawal_supply(arg2);
        let v7 = if (arg3) {
            0
        } else {
            0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::get_total_instant_unstake_wal(arg0, arg1, arg2)
        };
        let v8 = if (0x981130376559426c7b4b35e5038830ea427b232a5f55255e214d17a3172233ef::cursor::read_u64(&mut v1) == 1) {
            if (0x981130376559426c7b4b35e5038830ea427b232a5f55255e214d17a3172233ef::cursor::read_u64(&mut v1) == 0) {
                if (0x981130376559426c7b4b35e5038830ea427b232a5f55255e214d17a3172233ef::cursor::read_u64(&mut v1) <= 10000000) {
                    if (0x981130376559426c7b4b35e5038830ea427b232a5f55255e214d17a3172233ef::cursor::read_u64(&mut v1) <= 10000000) {
                        if (v2 <= 10000000) {
                            if (0x981130376559426c7b4b35e5038830ea427b232a5f55255e214d17a3172233ef::cursor::read_u64(&mut v1) <= 1024) {
                                if (v4 <= v5) {
                                    if (0x981130376559426c7b4b35e5038830ea427b232a5f55255e214d17a3172233ef::cursor::read_u64(&mut v1) == v5) {
                                        if (0x981130376559426c7b4b35e5038830ea427b232a5f55255e214d17a3172233ef::cursor::read_u64(&mut v1) == v3) {
                                            v3 == v6
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
        (0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::get_total_wal(arg2), v6, v2, v7, 0x981130376559426c7b4b35e5038830ea427b232a5f55255e214d17a3172233ef::cursor::boolean(&mut v1), 0x981130376559426c7b4b35e5038830ea427b232a5f55255e214d17a3172233ef::cursor::boolean(&mut v1), v4, v8)
    }

    public fun staking_bcs(arg0: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking) : vector<u8> {
        0x1::bcs::to_bytes<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking>(arg0)
    }

    // decompiled from Move bytecode v7
}

