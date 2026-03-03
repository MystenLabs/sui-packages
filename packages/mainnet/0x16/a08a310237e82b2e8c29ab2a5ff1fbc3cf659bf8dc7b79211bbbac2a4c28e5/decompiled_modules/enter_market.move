module 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::enter_market {
    struct ObligationCreatedEvent has copy, drop {
        sender: address,
        market_type: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        emode_group: u8,
        obligation_admin_cap: 0x2::object::ID,
    }

    public fun enter_market<T0>(arg0: &0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::app::ProtocolApp, arg1: &mut 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::market::Market<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = enter_market_return<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::obligation::ObligationOwnerCap>(v0, 0x2::tx_context::sender(arg2));
    }

    fun enter_market_inner<T0>(arg0: &0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::app::ProtocolApp, arg1: &mut 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::market::Market<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::obligation::ObligationOwnerCap {
        0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::app::ensure_version_matches(arg0);
        0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::app::validate_market<T0>(arg0, arg1);
        0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::market::assert_emode_group_exists<T0>(arg1, arg2);
        assert!(!0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::market::has_circuit_break_triggered<T0>(arg1), 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::error::market_under_circuit_break());
        let (v0, v1) = 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::obligation::new<T0>(0x2::object::id<0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::market::Market<T0>>(arg1), arg2, arg3);
        let v2 = v1;
        0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::market::handle_new_obligation<T0>(arg1, v0);
        let v3 = ObligationCreatedEvent{
            sender               : 0x2::tx_context::sender(arg3),
            market_type          : 0x1::type_name::with_defining_ids<T0>(),
            obligation           : 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::obligation::id(&v2),
            emode_group          : arg2,
            obligation_admin_cap : 0x2::object::id<0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::obligation::ObligationOwnerCap>(&v2),
        };
        0x2::event::emit<ObligationCreatedEvent>(v3);
        v2
    }

    public fun enter_market_return<T0>(arg0: &0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::app::ProtocolApp, arg1: &mut 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::market::Market<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::obligation::ObligationOwnerCap {
        enter_market_inner<T0>(arg0, arg1, 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::market::lending_default_emode_group(), arg2)
    }

    public fun enter_market_with_emode<T0>(arg0: &0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::app::ProtocolApp, arg1: &0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::app::PackageCallerCap, arg2: &mut 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::market::Market<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) : 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::obligation::ObligationOwnerCap {
        0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::app::ensure_has_permission(arg0, 0x2::object::id<0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::app::PackageCallerCap>(arg1), 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::whitelist_admin::enter_market_with_emode());
        enter_market_inner<T0>(arg0, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

