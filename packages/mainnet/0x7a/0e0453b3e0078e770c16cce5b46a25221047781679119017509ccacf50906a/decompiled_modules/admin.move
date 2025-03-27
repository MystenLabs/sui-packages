module 0x7a0e0453b3e0078e770c16cce5b46a25221047781679119017509ccacf50906a::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = 0x2::tx_context::sender(arg0);
        0x2::transfer::transfer<AdminCap>(v0, v1);
        0x7a0e0453b3e0078e770c16cce5b46a25221047781679119017509ccacf50906a::events::emit_admin_cap_transfer_event(v1);
    }

    entry fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
        0x7a0e0453b3e0078e770c16cce5b46a25221047781679119017509ccacf50906a::events::emit_admin_cap_transfer_event(arg1);
    }

    // decompiled from Move bytecode v6
}

