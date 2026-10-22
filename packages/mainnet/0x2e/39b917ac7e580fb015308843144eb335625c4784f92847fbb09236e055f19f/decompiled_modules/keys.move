module 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::keys {
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

