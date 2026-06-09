module 0xe89d24ea9fda4df41d619088fbd68219568c6965b8e9ac8a67c6bef84e43275d::lsd_hawal {
    public fun swap(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: &mut 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg3: 0x2::object::ID, arg4: bool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4, 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::errors::not_support_b2a());
        swap_a2b(arg0, arg1, arg2, arg3, arg5, arg6);
    }

    fun swap_a2b(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: &mut 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::take_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg0, arg4);
        if (0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v0) == 0) {
            0x2::balance::destroy_zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v0);
            return
        };
        0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>(arg0, 0x2::coin::into_balance<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>(0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::request_stake_coin(arg1, arg2, 0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v0, arg5), arg3, arg5)));
    }

    // decompiled from Move bytecode v7
}

