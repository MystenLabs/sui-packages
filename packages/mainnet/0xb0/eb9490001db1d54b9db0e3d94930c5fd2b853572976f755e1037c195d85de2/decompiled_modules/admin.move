module 0xb0eb9490001db1d54b9db0e3d94930c5fd2b853572976f755e1037c195d85de2::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun destroy_admin_cap(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    entry fun uniadmin_mint_admin_cap(arg0: &0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

