module 0xff8d1159067bda88cd15bd881e7c3e1bad7fd1d1d21d6f530e8bbe59e020b7e4::capability {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    entry fun drop_admin_cap(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun mint_admin_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<AdminCap>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

