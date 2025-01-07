module 0xce24c9c975deff0818397f3b8c5c14bf80b1ace126698fc49a821bf57c2e903f::init {
    public fun initialize<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : 0xce24c9c975deff0818397f3b8c5c14bf80b1ace126698fc49a821bf57c2e903f::vault::OwnerKey {
        0xce24c9c975deff0818397f3b8c5c14bf80b1ace126698fc49a821bf57c2e903f::vault::initialize<T0, T1>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

