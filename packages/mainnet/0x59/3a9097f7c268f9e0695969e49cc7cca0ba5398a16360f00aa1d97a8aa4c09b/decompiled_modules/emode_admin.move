module 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode_admin {
    struct NewEModeGroupEvent has copy, drop {
        market: 0x1::type_name::TypeName,
        emode_group_id: u8,
        time: u64,
        operator: address,
    }

    struct EModeUpdated<T0> has copy, drop {
        who: address,
        what: u8,
        market: 0x1::type_name::TypeName,
        asset: 0x1::type_name::TypeName,
        new: T0,
    }

    public fun create_emode_params(arg0: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::limiter::NewLimiter, arg8: 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::limiter::NewLimiter) : 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::NewEMode {
        assert!(arg1 < 10000, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::invalid_params_error());
        assert!(arg2 < 10000, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::invalid_params_error());
        assert!(arg3 < 10000, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::invalid_params_error());
        assert!(arg5 >= 10000, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::invalid_params_error());
        assert!(arg6 < 10000, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::invalid_params_error());
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::new_emode_params(0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(arg1, 10000), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(arg2, 10000), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(arg3, 10000), arg4, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(arg5, 10000), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(arg6, 10000), arg7, arg8)
    }

    public fun create_limiter(arg0: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::app::AdminCap, arg1: u64, arg2: u32, arg3: u32) : 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::limiter::NewLimiter {
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::limiter::create_new_limiter_change(arg1, arg2, arg3)
    }

    public fun onboard_asset_to_emode_group<T0, T1>(arg0: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::app::AdminCap, arg1: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::app::ProtocolApp, arg2: &mut 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::Market<T0>, arg3: u8, arg4: 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::NewEMode, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::has_circuit_break_triggered<T0>(arg2), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::market_under_circuit_break());
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::app::validate_market<T0>(arg1, arg2);
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::support_asset<T1>(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::emode_registry_mut<T0>(arg2), arg3, arg4, arg5);
        let v0 = EModeUpdated<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::NewEMode>{
            who    : 0x2::tx_context::sender(arg5),
            what   : 0,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg4,
        };
        0x2::event::emit<EModeUpdated<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::NewEMode>>(v0);
    }

    public fun onboard_new_emode_group<T0>(arg0: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::app::AdminCap, arg1: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::app::ProtocolApp, arg2: &mut 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::has_circuit_break_triggered<T0>(arg2), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::market_under_circuit_break());
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::app::validate_market<T0>(arg1, arg2);
        let v0 = NewEModeGroupEvent{
            market         : 0x1::type_name::get<T0>(),
            emode_group_id : 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::new_emode_group(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::emode_registry_mut<T0>(arg2), arg4),
            time           : 0x2::clock::timestamp_ms(arg3) / 1000,
            operator       : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<NewEModeGroupEvent>(v0);
    }

    public fun update_asset_in_emode_group<T0, T1>(arg0: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::app::AdminCap, arg1: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::app::ProtocolApp, arg2: &mut 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::Market<T0>, arg3: u8, arg4: 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::NewEMode, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::has_circuit_break_triggered<T0>(arg2), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::market_under_circuit_break());
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::app::validate_market<T0>(arg1, arg2);
        let v0 = 0x1::type_name::get<T1>();
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::borrow_mut_emode(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::emode_registry_mut<T0>(arg2), arg3, v0);
        let v1 = EModeUpdated<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::NewEMode>{
            who    : 0x2::tx_context::sender(arg5),
            what   : 0,
            market : 0x1::type_name::get<T0>(),
            asset  : v0,
            new    : arg4,
        };
        0x2::event::emit<EModeUpdated<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::NewEMode>>(v1);
    }

    // decompiled from Move bytecode v6
}

