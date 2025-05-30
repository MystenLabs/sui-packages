module 0x951812ec01eaebbefd9a9b44bf709d775160cc4c03d687132859a3c173f0faff::market_factory {
    struct MarketCreatedEvent has copy, drop {
        market_id: 0x1::string::String,
        factory_config_id: 0x2::object::ID,
        pt_id: 0x2::object::ID,
        expiry: u64,
        scalar_root: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign,
        initial_anchor: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign,
        ln_fee_rate_root: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64,
        market_cap: u64,
    }

    fun calc_market_id<T0: drop>(arg0: &0x951812ec01eaebbefd9a9b44bf709d775160cc4c03d687132859a3c173f0faff::py::PyState<T0>, arg1: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign, arg2: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign, arg3: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign) : 0x1::string::String {
        let v0 = 0x2::object::id<0x951812ec01eaebbefd9a9b44bf709d775160cc4c03d687132859a3c173f0faff::py::PyState<T0>>(arg0);
        let v1 = 0x2::object::id_to_bytes(&v0);
        let v2 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::get_raw_value(arg1);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u128>(&v2));
        let v3 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::get_raw_value(arg2);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u128>(&v3));
        let v4 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::get_raw_value(arg3);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u128>(&v4));
        0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::utils::vector_to_hex_string(0x1::hash::sha2_256(v1))
    }

    fun create_new_market_internal<T0: drop>(arg0: &0x951812ec01eaebbefd9a9b44bf709d775160cc4c03d687132859a3c173f0faff::py::PyState<T0>, arg1: &mut 0x951812ec01eaebbefd9a9b44bf709d775160cc4c03d687132859a3c173f0faff::market_global::MarketFactoryConfig, arg2: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign, arg3: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign, arg4: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x951812ec01eaebbefd9a9b44bf709d775160cc4c03d687132859a3c173f0faff::py::py_state_expiry<T0>(arg0);
        assert!(v0 > 0x2::clock::timestamp_ms(arg6), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_pt_expired());
        assert!(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::less_or_equal(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::create_from_raw_value(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::get_raw_value(arg4), true), 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::math_fixed64_with_sign::ln(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::create_from_rational(105, 100, true))), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_ln_fee_rate_too_high());
        assert!(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::greater_or_equal(arg3, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::one()), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_initial_anchor_too_low());
        assert!(!0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::is_zero(arg2), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_scalar_root_is_zero());
        let v1 = calc_market_id<T0>(arg0, arg2, arg3, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::create_from_raw_value(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::get_raw_value(arg4), true));
        assert!(!0x951812ec01eaebbefd9a9b44bf709d775160cc4c03d687132859a3c173f0faff::market_global::contains(arg1, v1), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_exists());
        0x951812ec01eaebbefd9a9b44bf709d775160cc4c03d687132859a3c173f0faff::market::create<T0>(arg0, arg2, arg3, arg4, arg5, arg7);
        0x951812ec01eaebbefd9a9b44bf709d775160cc4c03d687132859a3c173f0faff::market_global::add(arg1, v1);
        let v2 = MarketCreatedEvent{
            market_id         : v1,
            factory_config_id : 0x2::object::id<0x951812ec01eaebbefd9a9b44bf709d775160cc4c03d687132859a3c173f0faff::market_global::MarketFactoryConfig>(arg1),
            pt_id             : 0x2::object::id<0x951812ec01eaebbefd9a9b44bf709d775160cc4c03d687132859a3c173f0faff::py::PyState<T0>>(arg0),
            expiry            : v0,
            scalar_root       : arg2,
            initial_anchor    : arg3,
            ln_fee_rate_root  : arg4,
            market_cap        : arg5,
        };
        0x2::event::emit<MarketCreatedEvent>(v2);
    }

    public fun create_new_market_with_raw_values<T0: drop>(arg0: &0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::Version, arg1: &0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::acl::ACL, arg2: &0x951812ec01eaebbefd9a9b44bf709d775160cc4c03d687132859a3c173f0faff::py::PyState<T0>, arg3: &mut 0x951812ec01eaebbefd9a9b44bf709d775160cc4c03d687132859a3c173f0faff::market_global::MarketFactoryConfig, arg4: u128, arg5: bool, arg6: u128, arg7: bool, arg8: u128, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::assert_current_version(arg0);
        if (!0x951812ec01eaebbefd9a9b44bf709d775160cc4c03d687132859a3c173f0faff::market_global::is_market_permissionless(arg3)) {
            assert!(0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::acl::has_role(arg1, 0x2::tx_context::sender(arg11), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::acl::create_market_role()), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::create_market_invalid_sender());
        };
        create_new_market_internal<T0>(arg2, arg3, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::create_from_raw_value(arg4, arg5), 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::create_from_raw_value(arg6, arg7), 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_raw_value(arg8), arg9, arg10, arg11);
    }

    // decompiled from Move bytecode v6
}

