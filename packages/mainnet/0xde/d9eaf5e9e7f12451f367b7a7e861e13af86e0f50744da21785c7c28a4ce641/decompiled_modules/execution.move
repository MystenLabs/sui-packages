module 0xded9eaf5e9e7f12451f367b7a7e861e13af86e0f50744da21785c7c28a4ce641::execution {
    public fun maybe_stake(arg0: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg1: &mut 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg2: 0x1::option::Option<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>> {
        if (0x1::option::is_none<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(&arg2)) {
            0x1::option::destroy_none<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(arg2);
            return 0x1::option::none<0x2::coin::Coin<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>>()
        };
        0x1::option::some<0x2::coin::Coin<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>>(0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::request_stake_coin(arg0, arg1, 0x1::option::destroy_some<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(arg2), 0x2::object::id_from_address(@0x0), arg3))
    }

    public fun maybe_unstake(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: &mut 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg3: &0x2::clock::Clock, arg4: 0x1::option::Option<0x2::coin::Coin<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>>, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>> {
        if (0x1::option::is_none<0x2::coin::Coin<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>>(&arg4)) {
            0x1::option::destroy_none<0x2::coin::Coin<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>>(arg4);
            return 0x1::option::none<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>()
        };
        0x1::option::some<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::request_unstake_instant(arg0, arg1, arg2, arg3, 0x1::option::destroy_some<0x2::coin::Coin<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>>(arg4), arg5))
    }

    // decompiled from Move bytecode v7
}

