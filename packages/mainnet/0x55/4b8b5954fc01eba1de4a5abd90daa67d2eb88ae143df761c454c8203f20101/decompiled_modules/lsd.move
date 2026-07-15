module 0x554b8b5954fc01eba1de4a5abd90daa67d2eb88ae143df761c454c8203f20101::lsd {
    public fun swap<T0>(arg0: &mut 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::SwapContext, arg1: &mut 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_protocol::BlizzardStaking<T0>, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg3: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::BlizzardAV, arg4: 0x2::object::ID, arg5: bool, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg5, 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::errors::not_support_b2a());
        swap_a2b<T0>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8);
    }

    fun swap_a2b<T0>(arg0: &mut 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::SwapContext, arg1: &mut 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_protocol::BlizzardStaking<T0>, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg3: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::BlizzardAV, arg4: 0x2::object::ID, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg0, arg5);
        if (0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v0) == 0) {
            0x2::balance::destroy_zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v0);
            return
        };
        let v1 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::get_allowed_versions(arg3);
        0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_protocol::mint<T0>(arg1, arg2, 0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v0, arg7), arg4, &v1, arg7)));
        if (arg6) {
            0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::transfer_remaining_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg0, 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_all_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg0), arg7);
        };
    }

    // decompiled from Move bytecode v7
}

