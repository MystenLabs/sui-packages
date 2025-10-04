module 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::enter_market {
    struct ObligationCreatedEvent has copy, drop {
        sender: address,
        market_type: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        obligation_admin_cap: 0x2::object::ID,
    }

    public entry fun enter_market<T0>(arg0: &mut 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::market::Market<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = enter_market_return<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::ObligationOwnerCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun enter_market_return<T0>(arg0: &mut 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::market::Market<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::ObligationOwnerCap {
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::market::ensure_version_matches<T0>(arg0);
        let (v0, v1) = 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::new<T0>(0x2::object::id<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::market::Market<T0>>(arg0), arg1);
        let v2 = v1;
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::market::handle_new_obligation<T0>(arg0, v0);
        let v3 = ObligationCreatedEvent{
            sender               : 0x2::tx_context::sender(arg1),
            market_type          : 0x1::type_name::get<T0>(),
            obligation           : 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::id(&v2),
            obligation_admin_cap : 0x2::object::id<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::ObligationOwnerCap>(&v2),
        };
        0x2::event::emit<ObligationCreatedEvent>(v3);
        v2
    }

    // decompiled from Move bytecode v6
}

