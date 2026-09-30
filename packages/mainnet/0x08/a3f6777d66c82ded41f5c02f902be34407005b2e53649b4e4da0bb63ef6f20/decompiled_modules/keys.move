module 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::keys {
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

