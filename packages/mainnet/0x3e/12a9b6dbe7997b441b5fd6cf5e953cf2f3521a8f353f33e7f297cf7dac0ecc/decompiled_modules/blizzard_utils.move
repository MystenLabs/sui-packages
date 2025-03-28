module 0x3e12a9b6dbe7997b441b5fd6cf5e953cf2f3521a8f353f33e7f297cf7dac0ecc::blizzard_utils {
    public fun vector_transfer_staked_wal(arg0: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg1: vector<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x1::vector::reverse<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&arg1)) {
            let v1 = 0x1::vector::pop_back<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut arg1);
            if (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::can_withdraw_staked_wal_early(arg0, &v1)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::withdraw_stake(arg0, v1, arg3), arg2);
            } else {
                0x2::transfer::public_transfer<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v1, arg2);
            };
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(arg1);
    }

    // decompiled from Move bytecode v6
}

