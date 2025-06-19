module 0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = 0x2::tx_context::sender(arg0);
        0x2::transfer::transfer<AdminCap>(v0, v1);
        0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::events::emit_admin_cap_transfer_event(v1);
    }

    entry fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
        0xd4a8d4f8bdec13c66d2adbfa7a85dda48d9b32f65a5310c38ca3666a5174ef98::events::emit_admin_cap_transfer_event(arg1);
    }

    // decompiled from Move bytecode v6
}

