module 0xf52d83e020a3a01c0812efb53648779564bb9cb47b06ae48c81efdf582d00857::hawal {
    public fun stake(arg0: &0x91dd844df4f20026f6c6a4c44d0c87a960316e2e3f8c8a0e55e1532a05a86ab2::router::HopReceipt, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg3: &mut 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL> {
        0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::request_stake_coin(arg2, arg3, arg1, arg4, arg5)
    }

    // decompiled from Move bytecode v7
}

