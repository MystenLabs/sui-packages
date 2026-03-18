module 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::enter_market {
    struct ObligationCreatedEvent has copy, drop {
        sender: address,
        market_type: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        emode_group: u8,
        obligation_admin_cap: 0x2::object::ID,
    }

    public fun enter_market<T0>(arg0: &0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::ProtocolApp, arg1: &mut 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::market::Market<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = enter_market_return<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::obligation::ObligationOwnerCap>(v0, 0x2::tx_context::sender(arg2));
    }

    fun enter_market_inner<T0>(arg0: &0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::ProtocolApp, arg1: &mut 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::market::Market<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::obligation::ObligationOwnerCap {
        0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::ensure_version_matches(arg0);
        0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::validate_market<T0>(arg0, arg1);
        0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::market::assert_emode_group_exists<T0>(arg1, arg2);
        assert!(!0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::market::has_circuit_break_triggered<T0>(arg1), 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::error::market_under_circuit_break());
        let (v0, v1) = 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::obligation::new<T0>(0x2::object::id<0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::market::Market<T0>>(arg1), arg2, arg3);
        let v2 = v1;
        0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::market::handle_new_obligation<T0>(arg1, v0);
        let v3 = ObligationCreatedEvent{
            sender               : 0x2::tx_context::sender(arg3),
            market_type          : 0x1::type_name::with_defining_ids<T0>(),
            obligation           : 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::obligation::id(&v2),
            emode_group          : arg2,
            obligation_admin_cap : 0x2::object::id<0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::obligation::ObligationOwnerCap>(&v2),
        };
        0x2::event::emit<ObligationCreatedEvent>(v3);
        v2
    }

    public fun enter_market_return<T0>(arg0: &0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::ProtocolApp, arg1: &mut 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::market::Market<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::obligation::ObligationOwnerCap {
        enter_market_inner<T0>(arg0, arg1, 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::market::lending_default_emode_group(), arg2)
    }

    public fun enter_market_with_emode<T0>(arg0: &0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::ProtocolApp, arg1: &0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::PackageCallerCap, arg2: &mut 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::market::Market<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) : 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::obligation::ObligationOwnerCap {
        0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::ensure_has_permission(arg0, 0x2::object::id<0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::PackageCallerCap>(arg1), 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::whitelist_admin::enter_market_with_emode());
        enter_market_inner<T0>(arg0, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

