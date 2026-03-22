module 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::emode_admin {
    struct NewEModeGroupEvent has copy, drop {
        market: 0x1::type_name::TypeName,
        emode_group_id: u8,
        oracle_base_token: u8,
        time: u64,
        operator: address,
    }

    struct EModeUpdated<T0> has copy, drop {
        who: address,
        what: u8,
        market: 0x1::type_name::TypeName,
        asset: 0x1::type_name::TypeName,
        emode_group: u8,
        new: T0,
    }

    public fun create_emode_params(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::AdminCap, arg1: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::limiter::NewLimiter, arg9: 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::limiter::NewLimiter) : 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::emode::NewEMode {
        assert!(arg2 < arg3, 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::error::invalid_params_error());
        assert!(arg3 - arg2 < arg4, 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::error::invalid_params_error());
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ensure_version_matches(arg1);
        assert!(arg3 * (10000 + arg4) / 10000 < 10000, 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::error::invalid_params_error());
        create_emode_params_inner(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    fun create_emode_params_inner(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::limiter::NewLimiter, arg8: 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::limiter::NewLimiter) : 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::emode::NewEMode {
        assert!(arg1 < 10000, 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::error::invalid_params_error());
        assert!(arg2 < 10000, 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::error::invalid_params_error());
        assert!(arg3 < 10000, 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::error::invalid_params_error());
        assert!(arg5 >= 10000, 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::error::invalid_params_error());
        assert!(arg6 < 10000, 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::error::invalid_params_error());
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::emode::new_emode_params(0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::from_quotient(arg1, 10000), 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::from_quotient(arg2, 10000), 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::from_quotient(arg3, 10000), arg4, 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::from_quotient(arg5, 10000), 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::from_quotient(arg6, 10000), arg7, arg8)
    }

    public fun create_limiter(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::AdminCap, arg1: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg2: u64, arg3: u32, arg4: u32) : 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::limiter::NewLimiter {
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ensure_version_matches(arg1);
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::limiter::create_new_limiter_change(arg2, arg3, arg4)
    }

    public fun onboard_asset_to_emode_group<T0, T1>(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::AdminCap, arg1: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg2: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>, arg3: u8, arg4: 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::emode::NewEMode, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::has_circuit_break_triggered<T0>(arg2), 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::error::market_under_circuit_break());
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::validate_market<T0>(arg1, arg2);
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ensure_version_matches(arg1);
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::emode::support_asset<T1>(0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::emode_registry_mut<T0>(arg2), arg3, arg4, arg5);
        let v0 = EModeUpdated<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::emode::NewEMode>{
            who         : 0x2::tx_context::sender(arg5),
            what        : 0,
            market      : 0x1::type_name::with_defining_ids<T0>(),
            asset       : 0x1::type_name::with_defining_ids<T1>(),
            emode_group : arg3,
            new         : arg4,
        };
        0x2::event::emit<EModeUpdated<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::emode::NewEMode>>(v0);
    }

    public fun onboard_new_emode_group<T0>(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::AdminCap, arg1: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg2: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::has_circuit_break_triggered<T0>(arg2), 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::error::market_under_circuit_break());
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::validate_market<T0>(arg1, arg2);
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ensure_version_matches(arg1);
        let v0 = NewEModeGroupEvent{
            market            : 0x1::type_name::with_defining_ids<T0>(),
            emode_group_id    : 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::emode::new_emode_group(0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::emode_registry_mut<T0>(arg2), arg3, arg5),
            oracle_base_token : arg3,
            time              : 0x2::clock::timestamp_ms(arg4) / 1000,
            operator          : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<NewEModeGroupEvent>(v0);
    }

    public fun update_asset_in_emode_group<T0, T1>(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::AdminCap, arg1: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg2: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>, arg3: u8, arg4: 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::emode::NewEMode, arg5: &0x2::tx_context::TxContext) {
        assert!(!0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::has_circuit_break_triggered<T0>(arg2), 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::error::market_under_circuit_break());
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::validate_market<T0>(arg1, arg2);
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ensure_version_matches(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::emode::update(0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::emode::borrow_mut_emode(0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::emode_registry_mut<T0>(arg2), arg3, v0), arg4);
        let v1 = EModeUpdated<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::emode::NewEMode>{
            who         : 0x2::tx_context::sender(arg5),
            what        : 1,
            market      : 0x1::type_name::with_defining_ids<T0>(),
            asset       : v0,
            emode_group : arg3,
            new         : arg4,
        };
        0x2::event::emit<EModeUpdated<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::emode::NewEMode>>(v1);
    }

    // decompiled from Move bytecode v6
}

