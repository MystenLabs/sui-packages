module 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::enter_market {
    struct ObligationCreatedEvent has copy, drop {
        sender: address,
        market_type: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        obligation_admin_cap: 0x2::object::ID,
    }

    public entry fun enter_market<T0>(arg0: &mut 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::market::Market<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = enter_market_return<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::obligation::ObligationOwnerCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun enter_market_return<T0>(arg0: &mut 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::market::Market<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::obligation::ObligationOwnerCap {
        let (v0, v1) = 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::obligation::new<T0>(0x2::object::id<0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::market::Market<T0>>(arg0), arg1);
        let v2 = v1;
        0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::market::handle_new_obligation<T0>(arg0, v0);
        let v3 = ObligationCreatedEvent{
            sender               : 0x2::tx_context::sender(arg1),
            market_type          : 0x1::type_name::get<T0>(),
            obligation           : 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::obligation::id(&v2),
            obligation_admin_cap : 0x2::object::id<0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::obligation::ObligationOwnerCap>(&v2),
        };
        0x2::event::emit<ObligationCreatedEvent>(v3);
        v2
    }

    // decompiled from Move bytecode v6
}

