module 0x6e93b2b74ccaba6db4579d56ae77be10ae8ea3d75f60f360d51847f2dfb9e0d1::wal_exg_rate {
    public fun get_exhange_rate(arg0: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking) {
        abort 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::get_exchange_rate(arg0)
    }

    public fun get_wal_to_hawal(arg0: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg1: u64) {
        abort 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::get_hawal_by_wal(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

