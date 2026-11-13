module 0xb88f5376ed53b43325eeb4747030fedc65de945017a935316c51de9cdaad942d::reader {
    public fun current(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking) : (u64, u64, u64, u64, bool, bool, u64, bool) {
        current_for_direction(arg0, arg1, arg2, false)
    }

    public fun current_for_direction(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg3: bool) : (u64, u64, u64, u64, bool, bool, u64, bool) {
        let v0 = 0xb88f5376ed53b43325eeb4747030fedc65de945017a935316c51de9cdaad942d::cursor::new(0x1::bcs::to_bytes<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking>(arg2));
        0xb88f5376ed53b43325eeb4747030fedc65de945017a935316c51de9cdaad942d::cursor::skip(&mut v0, 40);
        0xb88f5376ed53b43325eeb4747030fedc65de945017a935316c51de9cdaad942d::cursor::skip(&mut v0, 16);
        0xb88f5376ed53b43325eeb4747030fedc65de945017a935316c51de9cdaad942d::cursor::skip(&mut v0, 220);
        let v1 = if (arg3) {
            0
        } else {
            0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::get_total_instant_unstake_wal(arg0, arg1, arg2)
        };
        (0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::get_total_wal(arg2), 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::get_hawal_supply(arg2), 0xb88f5376ed53b43325eeb4747030fedc65de945017a935316c51de9cdaad942d::cursor::read_u64(&mut v0), v1, 0xb88f5376ed53b43325eeb4747030fedc65de945017a935316c51de9cdaad942d::cursor::boolean(&mut v0), 0xb88f5376ed53b43325eeb4747030fedc65de945017a935316c51de9cdaad942d::cursor::boolean(&mut v0), 0xb88f5376ed53b43325eeb4747030fedc65de945017a935316c51de9cdaad942d::cursor::length(&mut v0), 0xb88f5376ed53b43325eeb4747030fedc65de945017a935316c51de9cdaad942d::cursor::read_u64(&mut v0) == 0)
    }

    public fun current_for_direction_unless_selected(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg3: bool, arg4: &vector<bool>) : (u64, u64, u64, u64, bool, bool, u64, bool) {
        let v0 = true;
        if (0x1::vector::contains<bool>(arg4, &v0)) {
            return (1, 1, 1, 1, false, false, 1, false)
        };
        current_for_direction(arg0, arg1, arg2, arg3)
    }

    public fun current_unless_selected(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg3: &vector<bool>) : (u64, u64, u64, u64, bool, bool, u64, bool) {
        let v0 = true;
        if (0x1::vector::contains<bool>(arg3, &v0)) {
            return (1, 1, 1, 1, false, false, 1, false)
        };
        current(arg0, arg1, arg2)
    }

    public fun instant_capacity_if(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg3: bool) : u64 {
        if (!arg3) {
            return 0
        };
        0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::get_total_instant_unstake_wal(arg0, arg1, arg2)
    }

    public fun staking_bcs(arg0: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking) : vector<u8> {
        0x1::bcs::to_bytes<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking>(arg0)
    }

    // decompiled from Move bytecode v7
}

