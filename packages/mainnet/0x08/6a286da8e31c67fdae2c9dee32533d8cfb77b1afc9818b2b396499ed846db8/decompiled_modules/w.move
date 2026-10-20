module 0x86a286da8e31c67fdae2c9dee32533d8cfb77b1afc9818b2b396499ed846db8::w {
    public fun ba(arg0: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg1: &mut 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg2: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL> {
        assert!(0x2::tx_context::sender(arg3) == @0x57f118d56fe158c8bd5966fd87eb106545fd5628528af42f6a05eebdf9aa3380, 0);
        0x2::coin::into_balance<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>(0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::request_stake_coin(arg0, arg1, 0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg2, arg3), 0x2::object::id_from_address(@0x0), arg3))
    }

    // decompiled from Move bytecode v7
}

