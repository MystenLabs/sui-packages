module 0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::caps {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MinterCap has store, key {
        id: 0x2::object::UID,
    }

    struct PackerCap has store, key {
        id: 0x2::object::UID,
    }

    struct PackMinterCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn_minter(arg0: MinterCap) {
        let MinterCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun burn_pack_minter(arg0: PackMinterCap) {
        let PackMinterCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = MinterCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MinterCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = MinterCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MinterCap>(v2, 0x2::tx_context::sender(arg0));
        let v3 = MinterCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MinterCap>(v3, 0x2::tx_context::sender(arg0));
        let v4 = PackerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PackerCap>(v4, 0x2::tx_context::sender(arg0));
        let v5 = PackMinterCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PackMinterCap>(v5, 0x2::tx_context::sender(arg0));
        let v6 = PackMinterCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PackMinterCap>(v6, 0x2::tx_context::sender(arg0));
        let v7 = PackMinterCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PackMinterCap>(v7, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

