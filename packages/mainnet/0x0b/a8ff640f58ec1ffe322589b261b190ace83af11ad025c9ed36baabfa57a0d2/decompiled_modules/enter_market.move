module 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::enter_market {
    struct ObligationCreatedEvent has copy, drop {
        sender: address,
        market_type: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        obligation_admin_cap: 0x2::object::ID,
    }

    public entry fun enter_market<T0>(arg0: &mut 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = enter_market_return<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::obligation::ObligationOwnerCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun enter_market_return<T0>(arg0: &mut 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::obligation::ObligationOwnerCap {
        let (v0, v1) = 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::obligation::new<T0>(0x2::object::id<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>>(arg0), arg1);
        let v2 = v1;
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::handle_new_obligation<T0>(arg0, v0);
        let v3 = ObligationCreatedEvent{
            sender               : 0x2::tx_context::sender(arg1),
            market_type          : 0x1::type_name::get<T0>(),
            obligation           : 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::obligation::id(&v2),
            obligation_admin_cap : 0x2::object::id<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::obligation::ObligationOwnerCap>(&v2),
        };
        0x2::event::emit<ObligationCreatedEvent>(v3);
        v2
    }

    // decompiled from Move bytecode v6
}

