module 0x81ce93535c2412a4a987944e9f9578e0caf937d21dcf8c071e3d612b5149003c::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 10) {
            let v1 = AdminCap{id: 0x2::object::new(arg0)};
            0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

