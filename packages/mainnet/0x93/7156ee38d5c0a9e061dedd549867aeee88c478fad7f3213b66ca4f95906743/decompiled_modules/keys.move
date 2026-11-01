module 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::keys {
    struct VaultKey has copy, drop, store {
        pos0: u64,
    }

    struct PositionKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    public(friend) fun position_key(arg0: 0x2::object::ID) : PositionKey {
        PositionKey{pos0: arg0}
    }

    public(friend) fun vault_key(arg0: u64) : VaultKey {
        VaultKey{pos0: arg0}
    }

    // decompiled from Move bytecode v7
}

