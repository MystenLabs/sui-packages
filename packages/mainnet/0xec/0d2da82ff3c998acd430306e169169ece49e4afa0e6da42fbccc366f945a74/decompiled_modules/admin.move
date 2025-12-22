module 0xec0d2da82ff3c998acd430306e169169ece49e4afa0e6da42fbccc366f945a74::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun create_keeper_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = KeeperCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<KeeperCap>(v0, arg1);
    }

    public entry fun delete_keeper_cap(arg0: &AdminCap, arg1: KeeperCap) {
        let KeeperCap { id: v0 } = arg1;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = KeeperCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<KeeperCap>(v2, v0);
    }

    public entry fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::public_transfer<AdminCap>(arg0, arg1);
    }

    public entry fun transfer_keeper_cap(arg0: KeeperCap, arg1: address) {
        0x2::transfer::public_transfer<KeeperCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

