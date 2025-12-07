module 0x68ca6013f2bf3f0744acb5222206048c4a5cd86374c508e74a7b102c244dfdc8::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct HandlerCap has key {
        id: 0x2::object::UID,
    }

    public fun create_handler_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = HandlerCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<HandlerCap>(v0, arg1);
    }

    public fun del_handler_cap(arg0: HandlerCap) {
        let HandlerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

