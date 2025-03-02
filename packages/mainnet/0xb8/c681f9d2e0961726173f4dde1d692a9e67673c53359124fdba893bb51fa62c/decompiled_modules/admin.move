module 0xb8c681f9d2e0961726173f4dde1d692a9e67673c53359124fdba893bb51fa62c::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
        admin: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{
            id    : 0x2::object::new(arg0),
            admin : v0,
        };
        0x2::transfer::transfer<AdminCap>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

