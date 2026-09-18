module 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::keys {
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

