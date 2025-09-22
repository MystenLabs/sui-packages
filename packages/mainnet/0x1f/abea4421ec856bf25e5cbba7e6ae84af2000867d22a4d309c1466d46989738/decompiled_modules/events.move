module 0x1fabea4421ec856bf25e5cbba7e6ae84af2000867d22a4d309c1466d46989738::events {
    struct SeedPackMinted has copy, drop {
        seed_pack_id: 0x2::object::ID,
        owner: address,
        pack_type: u8,
    }

    public fun emit_seed_pack_minted(arg0: 0x2::object::ID, arg1: address, arg2: u8) {
        let v0 = SeedPackMinted{
            seed_pack_id : arg0,
            owner        : arg1,
            pack_type    : arg2,
        };
        0x2::event::emit<SeedPackMinted>(v0);
    }

    // decompiled from Move bytecode v6
}

