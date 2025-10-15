module 0xeaa3b0e17d98132228d4a866448a4502929cf7059414bbcd2a3f1d1b1f8c48e7::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun v(arg0: &AdminCap) : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

