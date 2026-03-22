module 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::enter_market {
    struct ObligationCreatedEvent has copy, drop {
        sender: address,
        market_type: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        emode_group: u8,
        obligation_admin_cap: 0x2::object::ID,
    }

    public fun enter_market<T0>(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg1: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = enter_market_return<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::obligation::ObligationOwnerCap>(v0, 0x2::tx_context::sender(arg2));
    }

    fun enter_market_inner<T0>(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg1: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::obligation::ObligationOwnerCap {
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ensure_version_matches(arg0);
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::validate_market<T0>(arg0, arg1);
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::assert_emode_group_exists<T0>(arg1, arg2);
        assert!(!0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::has_circuit_break_triggered<T0>(arg1), 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::error::market_under_circuit_break());
        let (v0, v1) = 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::obligation::new<T0>(0x2::object::id<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>>(arg1), arg2, arg3);
        let v2 = v1;
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::handle_new_obligation<T0>(arg1, v0);
        let v3 = ObligationCreatedEvent{
            sender               : 0x2::tx_context::sender(arg3),
            market_type          : 0x1::type_name::with_defining_ids<T0>(),
            obligation           : 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::obligation::id(&v2),
            emode_group          : arg2,
            obligation_admin_cap : 0x2::object::id<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::obligation::ObligationOwnerCap>(&v2),
        };
        0x2::event::emit<ObligationCreatedEvent>(v3);
        v2
    }

    public fun enter_market_return<T0>(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg1: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::obligation::ObligationOwnerCap {
        enter_market_inner<T0>(arg0, arg1, 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::lending_default_emode_group(), arg2)
    }

    public fun enter_market_with_emode<T0>(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg1: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::PackageCallerCap, arg2: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) : 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::obligation::ObligationOwnerCap {
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ensure_has_permission(arg0, 0x2::object::id<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::PackageCallerCap>(arg1), 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::whitelist_admin::enter_market_with_emode());
        enter_market_inner<T0>(arg0, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

