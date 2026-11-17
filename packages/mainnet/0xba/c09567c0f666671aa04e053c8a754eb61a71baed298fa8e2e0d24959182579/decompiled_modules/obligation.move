module 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation {
    struct ScallopWitness has drop {
        dummy_field: bool,
    }

    struct ObligationCreatedEvent has copy, drop {
        obligation_id: 0x2::object::ID,
        obligation_key_id: 0x2::object::ID,
        owner: address,
        market_id: 0x2::object::ID,
    }

    struct CollateralDepositedEvent has copy, drop {
        market_id: 0x2::object::ID,
        obligation_id: 0x2::object::ID,
        collateral_amount: u64,
    }

    struct CollateralWithdrawnEvent has copy, drop {
        market_id: 0x2::object::ID,
        obligation_id: 0x2::object::ID,
        collateral_amount: u64,
    }

    struct BorrowEvent has copy, drop {
        market_id: 0x2::object::ID,
        obligation_id: 0x2::object::ID,
        borrow_amount: u64,
        debt_opened: u64,
    }

    struct RepayEvent has copy, drop {
        market_id: 0x2::object::ID,
        obligation_id: 0x2::object::ID,
        repay_amount: u64,
    }

    struct LiquidateEvent has copy, drop {
        market_id: 0x2::object::ID,
        obligation_id: 0x2::object::ID,
        liquidator: address,
        debt_repaid_amount: u64,
        seized_collateral_amount: u64,
    }

    struct GiftSweptEvent has copy, drop {
        strategy_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        amount: u64,
        market_id: 0x2::object::ID,
    }

    public fun borrow<T0, T1>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg10 > 0, 850);
        let v0 = open_move<T0>(arg0, arg1, arg4, arg2, arg3, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::move_enter(), 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::role_flag_borrow());
        let v1 = &mut v0;
        let v2 = lend_key<T0>(arg1, v1, arg6);
        let v3 = 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg6);
        let v4 = 0x1::type_name::get<T1>();
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg11);
        let v5 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow::borrow<T1>(arg5, arg6, &v2, arg7, arg8, arg10, arg9, arg11, arg12);
        assert_health_floor<T0>(arg1, arg2, arg6, arg7, arg8, arg9, arg11, arg4);
        let v6 = current_debt(arg6, v4) - current_debt(arg6, v4);
        let v7 = BorrowEvent{
            market_id     : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg7),
            obligation_id : v3,
            borrow_amount : 0x2::coin::value<T1>(&v5),
            debt_opened   : v6,
        };
        0x2::event::emit<BorrowEvent>(v7);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::return_account<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, ScallopWitness>(witness(), arg1, &mut v0, v2);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::put<T0, T1, ScallopWitness>(witness(), arg1, &mut v0, 0x2::coin::into_balance<T1>(v5));
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::record_debt_opened<T0, T1, ScallopWitness>(witness(), arg1, &mut v0, v3, v6);
        settle<T0>(arg1, arg3, v0, arg7);
    }

    public(friend) fun settle<T0>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg2: 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Ticket, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) {
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::settle<T0, ScallopWitness>(witness(), arg0, arg1, arg2, 0x1::option::some<0x2::object::ID>(0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg3)));
    }

    fun account_coins(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) : vector<0x1::type_name::TypeName> {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg0);
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral_types(arg0);
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v3 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v1);
            if (!0x1::vector::contains<0x1::type_name::TypeName>(&v0, &v3)) {
                0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, v3);
            };
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v1);
        v0
    }

    fun account_collateral(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256> {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral_types(arg0);
        let v1 = &v0;
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            0x1::vector::push_back<u256>(&mut v2, (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral(arg0, *0x1::vector::borrow<0x1::type_name::TypeName>(v1, v3)) as u256));
            v3 = v3 + 1;
        };
        0x2::vec_map::from_keys_values<0x1::type_name::TypeName, u256>(v0, v2)
    }

    public fun accrue_interest_for_market(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0x2::clock::Clock) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg0, arg1, arg2);
    }

    public fun admin_finalize_pocket<T0>(arg0: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg3: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &0x2::clock::Clock) {
        assert_pocket_obligation<T0>(arg2, arg6);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::assert_bound_venue(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_venue<T0>(arg2), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg5));
        let (v0, v1) = read_obligation(arg4, arg5, arg6, arg7);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::admin_finalize_unwind_account<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, ScallopWitness>(arg0, witness(), 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::version::current_version(), arg1, arg2, arg3, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg6), v0, v1, arg7);
    }

    fun assert_health_floor<T0>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig) {
        let v0 = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::counted_account_assets<T0>(arg0, vault_key(arg1));
        assert!(counted_health_bps(arg2, arg3, arg4, arg5, arg6, &v0) >= 0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::lending_min_health_bps(arg7), 854);
    }

    fun assert_pocket_obligation<T0>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) {
        assert!(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_account_subject<T0>(arg0) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg1)), 852);
    }

    fun assert_vault_obligation<T0>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) {
        let v0 = vault_key(arg1);
        assert!(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::has_position_record<T0>(arg0, v0), 852);
        let v1 = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::position_record<T0>(arg0, v0);
        assert!(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::record_subject(&v1) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg2)), 852);
    }

    public fun close_leg<T0>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::UnwindLeg<ScallopWitness, 0x1::type_name::TypeName, u64>, arg6: &0x2::clock::Clock) {
        let v0 = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::unwind_leg_keys<T0, ScallopWitness, 0x1::type_name::TypeName, u64>(&arg5, 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::version::current_version(), arg0);
        assert_pocket_obligation<T0>(arg0, arg1);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::assert_bound_venue(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_venue<T0>(arg0), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg2));
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::close_unwind_leg<T0, ScallopWitness, 0x1::type_name::TypeName, u64>(witness(), 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::version::current_version(), arg0, arg5, prices_for(arg4, &v0), account_coins(arg1), account_collateral(arg1), health_bps(arg1, arg2, arg3, arg4, arg6));
    }

    fun counted_health_bps(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &vector<0x1::type_name::TypeName>) : u64 {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg0);
        let v1 = 0x1::vector::length<0x1::type_name::TypeName>(&v0);
        if (v1 == 0) {
            return 18446744073709551615
        };
        let v2 = 0;
        let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral_types(arg0);
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v3);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(&v3)) {
            let v5 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v3);
            if (0x1::vector::contains<0x1::type_name::TypeName>(arg5, &v5)) {
                v2 = v2 + ((0x1::fixed_point32::get_raw_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::value_calculator::usd_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::price::get_price(arg3, v5, arg4), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral(arg0, v5), 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg2, v5))) as u128) * (0x1::fixed_point32::get_raw_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::risk_model::collateral_factor(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::risk_model(arg1, v5))) as u128) >> 32);
            };
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v3);
        (0x1::u128::min(v2 * 10000 / ((0x1::fixed_point32::get_raw_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4)) as u128) + 3 * (v1 as u128)), 18446744073709551615) as u64)
    }

    public fun create_obligation<T0>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = open_move<T0>(arg0, arg1, arg4, arg2, arg3, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::move_enter(), 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::role_flag_lend());
        let (v1, v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::open_obligation(arg5, arg7);
        let v4 = v2;
        let v5 = v1;
        let v6 = 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(&v5);
        let v7 = ObligationCreatedEvent{
            obligation_id     : v6,
            obligation_key_id : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&v4),
            owner             : 0x2::tx_context::sender(arg7),
            market_id         : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg6),
        };
        0x2::event::emit<ObligationCreatedEvent>(v7);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::return_obligation(arg5, v5, v3);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::store_account<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, ScallopWitness>(witness(), arg1, &mut v0, v4, v6);
        settle<T0>(arg1, arg3, v0, arg6);
        v6
    }

    fun current_debt(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg1: 0x1::type_name::TypeName) : u64 {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg0);
        if (!0x1::vector::contains<0x1::type_name::TypeName>(&v0, &arg1)) {
            return 0
        };
        let (v1, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg0, arg1);
        v1
    }

    public fun deposit_collateral<T0, T1>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 > 0, 850);
        let v0 = open_move<T0>(arg0, arg1, arg4, arg2, arg3, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::move_enter(), 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::role_flag_lend());
        let v1 = &mut v0;
        let v2 = lend_key<T0>(arg1, v1, arg6);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::deposit_collateral::deposit_collateral<T1>(arg5, arg6, arg7, 0x2::coin::from_balance<T1>(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::take<T0, T1, ScallopWitness>(witness(), arg1, &mut v0, arg8), arg9), arg9);
        let v3 = CollateralDepositedEvent{
            market_id         : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg7),
            obligation_id     : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg6),
            collateral_amount : arg8,
        };
        0x2::event::emit<CollateralDepositedEvent>(v3);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::return_account<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, ScallopWitness>(witness(), arg1, &mut v0, v2);
        settle<T0>(arg1, arg3, v0, arg7);
    }

    public fun finalize_pocket<T0>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &0x2::clock::Clock) {
        assert_pocket_obligation<T0>(arg1, arg5);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::assert_bound_venue(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_venue<T0>(arg1), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg4));
        let (v0, v1) = read_obligation(arg3, arg4, arg5, arg6);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::finalize_unwind_account<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, ScallopWitness>(witness(), 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::version::current_version(), arg0, arg1, arg2, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg5), v0, v1, arg6);
    }

    fun health_bps(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = (0x1::fixed_point32::get_raw_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4)) as u128);
        if (v0 == 0) {
            return 18446744073709551615
        };
        (0x1::u128::min((0x1::fixed_point32::get_raw_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4)) as u128) * 10000 / v0, 18446744073709551615) as u64)
    }

    fun is_liquidatable(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: &0x2::clock::Clock) : bool {
        let v0 = 0x1::fixed_point32::get_raw_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4));
        if (v0 == 0) {
            return false
        };
        0x1::fixed_point32::get_raw_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4)) < v0
    }

    fun lend_key<T0>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Ticket, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) : 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey {
        let v0 = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::lend_account<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, ScallopWitness>(witness(), arg0, arg1);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg2, &v0);
        v0
    }

    public fun liquidate<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 850);
        let (v1, v2) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v3 = v2;
        let v4 = v1;
        let v5 = LiquidateEvent{
            market_id                : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg2),
            obligation_id            : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg1),
            liquidator               : 0x2::tx_context::sender(arg7),
            debt_repaid_amount       : v0 - 0x2::coin::value<T0>(&v4),
            seized_collateral_amount : 0x2::coin::value<T1>(&v3),
        };
        0x2::event::emit<LiquidateEvent>(v5);
        (v4, v3)
    }

    entry fun liquidate_entry<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = liquidate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        maybe_transfer_or_destroy<T0>(v0, arg7);
        maybe_transfer_or_destroy<T1>(v1, arg7);
    }

    fun maybe_transfer_or_destroy<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public(friend) fun open_move<T0>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg3: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg4: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg5: u8, arg6: u64) : 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Ticket {
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::open_ticket<T0, ScallopWitness>(witness(), 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::version::current_version(), arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    fun prices_for(arg0: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg1: &vector<0x1::type_name::TypeName>) : vector<u64> {
        let v0 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::prices(arg0);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(arg1)) {
            0x1::vector::push_back<u64>(&mut v1, 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::value(0x2::table::borrow<0x1::type_name::TypeName, 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::PriceFeed>(v0, *0x1::vector::borrow<0x1::type_name::TypeName>(arg1, v2))));
            v2 = v2 + 1;
        };
        v1
    }

    fun read_obligation(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: &0x2::clock::Clock) : (0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg1, arg2, arg3);
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral_types(arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0, v3, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral(arg2, v3));
            v2 = v2 + 1;
        };
        let v4 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v5 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg2);
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x1::type_name::TypeName>(&v5)) {
            let v7 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v5, v6);
            let (v8, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg2, v7);
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v4, v7, v8);
            v6 = v6 + 1;
        };
        (v0, v4)
    }

    public fun reattach_pocket<T0>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::QuoteBook, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_pocket_obligation<T0>(arg1, arg5);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::assert_bound_venue(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_venue<T0>(arg1), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg4));
        let (v0, v1) = read_obligation(arg3, arg4, arg5, arg9);
        assert!(!is_liquidatable(arg5, arg4, arg6, arg7, arg9), 856);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::reattach_pocket_account<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, ScallopWitness>(witness(), 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::version::current_version(), arg0, arg1, arg2, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg5), v0, v1, 0, 1, b"", arg8, arg9, arg10);
    }

    public fun refresh_account<T0>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_vault_obligation<T0>(arg0, arg1, arg4);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::assert_bound_venue(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::position_venue<T0>(arg0, vault_key(arg1)), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg3));
        let (v0, v1) = read_obligation(arg2, arg3, arg4, arg5);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::report_account_value<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, ScallopWitness>(witness(), 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::version::current_version(), arg0, arg1, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg4), v0, v1, 0, 1, b"", arg5, arg6);
    }

    public fun refresh_obligation(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg1, arg2, arg3);
    }

    public fun refresh_pocket<T0>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0x2::clock::Clock) {
        assert_pocket_obligation<T0>(arg0, arg4);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::assert_bound_venue(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_venue<T0>(arg0), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg3));
        let (v0, v1) = read_obligation(arg2, arg3, arg4, arg5);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::report_pocket_account_value<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, ScallopWitness>(witness(), 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::version::current_version(), arg0, arg1, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg4), v0, v1, 0, 1, b"", arg5);
    }

    public fun repay<T0, T1>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 > 0, 850);
        let v0 = open_move<T0>(arg0, arg1, arg4, arg2, arg3, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::move_exit(), 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::role_flag_borrow());
        assert_vault_obligation<T0>(arg1, arg2, arg6);
        let v1 = 0x2::coin::from_balance<T1>(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::take<T0, T1, ScallopWitness>(witness(), arg1, &mut v0, arg8), arg10);
        let v2 = &mut v1;
        let v3 = repay_exact<T1>(arg5, arg6, arg7, v2, arg9, arg10);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::put<T0, T1, ScallopWitness>(witness(), arg1, &mut v0, 0x2::coin::into_balance<T1>(v1));
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::record_debt_repaid<T0, T1, ScallopWitness>(witness(), arg1, &mut v0, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg6), v3, current_debt(arg6, 0x1::type_name::get<T1>()) == 0, arg9);
        settle<T0>(arg1, arg3, v0, arg7);
    }

    fun repay_exact<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &mut 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg2, arg1, arg4);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg1);
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v1, &v0), 851);
        let (v2, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg1, v0);
        let v4 = 0x1::u64::min(v2, 0x2::coin::value<T0>(arg3));
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::repay::repay<T0>(arg0, arg1, arg2, 0x2::coin::split<T0>(arg3, v4, arg5), arg4, arg5);
        let v5 = RepayEvent{
            market_id     : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg2),
            obligation_id : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg1),
            repay_amount  : v4,
        };
        0x2::event::emit<RepayEvent>(v5);
        v4
    }

    public fun repay_pocket<T0, T1>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::borrow_pocket_object<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, ScallopWitness>(witness(), 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::version::current_version(), arg0, arg1, arg8);
        let v2 = v0;
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::assert_bound_venue(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_venue<T0>(arg0), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg4));
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg3, &v2);
        if (current_debt(arg3, 0x1::type_name::get<T1>()) == 0) {
            let v3 = RepayEvent{
                market_id     : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg4),
                obligation_id : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg3),
                repay_amount  : 0,
            };
            0x2::event::emit<RepayEvent>(v3);
            0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::return_pocket_object_debt_cleared<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, T1, ScallopWitness>(witness(), 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::version::current_version(), arg0, arg1, v2, v1);
            return
        };
        assert!(arg7 > 0, 850);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg2, arg4, arg3, arg8);
        assert!(!is_liquidatable(arg3, arg4, arg5, arg6, arg8), 855);
        let (v4, v5) = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::take_escrow_for_repay<T0, T1, ScallopWitness>(witness(), 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::version::current_version(), arg0, arg1, arg7);
        let v6 = 0x2::coin::from_balance<T1>(v4, arg9);
        let v7 = &mut v6;
        let v8 = repay_exact<T1>(arg2, arg3, arg4, v7, arg8, arg9);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::return_pocket_object_after_repay<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, T1, ScallopWitness>(witness(), 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::version::current_version(), arg0, arg1, v2, v1, v5, v8, current_debt(arg3, 0x1::type_name::get<T1>()), 0x2::coin::into_balance<T1>(v6));
    }

    public fun sweep_gift<T0, T1>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(!0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::is_asset_allowed<T0>(arg1, v0), 853);
        let v1 = 0x1::type_name::get<T1>();
        assert!(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::has_coin_x_as_collateral(arg6, v1), 850);
        let v2 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral(arg6, v1);
        let v3 = open_move<T0>(arg0, arg1, arg4, arg2, arg3, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::move_exit(), 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::role_flag_lend());
        let v4 = &mut v3;
        let v5 = lend_key<T0>(arg1, v4, arg6);
        let v6 = withdraw_from<T1>(arg5, arg6, &v5, arg7, arg8, arg9, v2, arg10, arg11);
        assert_health_floor<T0>(arg1, arg2, arg6, arg7, arg8, arg9, arg10, arg4);
        let v7 = GiftSweptEvent{
            strategy_id : 0x2::object::id<0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>>(arg1),
            asset_type  : v0,
            amount      : 0x2::coin::value<T1>(&v6),
            market_id   : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg7),
        };
        0x2::event::emit<GiftSweptEvent>(v7);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::return_account<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, ScallopWitness>(witness(), arg1, &mut v3, v5);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::put_gift<T0, T1, ScallopWitness>(witness(), arg1, arg4, &mut v3, 0x2::coin::into_balance<T1>(v6), arg11);
        settle<T0>(arg1, arg3, v3, arg7);
    }

    fun vault_key(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo) : 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::PositionKey {
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::position_key_account(0x2::object::id<0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo>(arg0), 0x1::type_name::with_defining_ids<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>())
    }

    public fun withdraw_collateral<T0, T1>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg10 > 0, 850);
        let v0 = open_move<T0>(arg0, arg1, arg4, arg2, arg3, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::move_exit(), 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::role_flag_lend());
        let v1 = &mut v0;
        let v2 = lend_key<T0>(arg1, v1, arg6);
        let v3 = withdraw_from<T1>(arg5, arg6, &v2, arg7, arg8, arg9, arg10, arg11, arg12);
        assert_health_floor<T0>(arg1, arg2, arg6, arg7, arg8, arg9, arg11, arg4);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::return_account<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, ScallopWitness>(witness(), arg1, &mut v0, v2);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::put<T0, T1, ScallopWitness>(witness(), arg1, &mut v0, 0x2::coin::into_balance<T1>(v3));
        settle<T0>(arg1, arg3, v0, arg7);
    }

    fun withdraw_from<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::withdraw_collateral::withdraw_collateral<T0>(arg0, arg1, arg2, arg3, arg4, arg6, arg5, arg7, arg8);
        let v1 = CollateralWithdrawnEvent{
            market_id         : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg3),
            obligation_id     : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg1),
            collateral_amount : 0x2::coin::value<T0>(&v0),
        };
        0x2::event::emit<CollateralWithdrawnEvent>(v1);
        v0
    }

    public fun withdraw_pocket<T0, T1>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::UnwindLeg<ScallopWitness, 0x1::type_name::TypeName, u64> {
        assert!(arg7 > 0, 850);
        let (v0, v1) = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::borrow_pocket_object<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, ScallopWitness>(witness(), 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::version::current_version(), arg0, arg1, arg8);
        let v2 = v0;
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::assert_bound_venue(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_venue<T0>(arg0), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg4));
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg3, &v2);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg2, arg4, arg3, arg8);
        let v3 = health_bps(arg3, arg4, arg5, arg6, arg8);
        let v4 = account_coins(arg3);
        let v5 = withdraw_from<T1>(arg2, arg3, &v2, arg4, arg5, arg6, arg7, arg8, arg9);
        let v6 = 0x1::type_name::get<T1>();
        let v7 = if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::has_coin_x_as_collateral(arg3, v6)) {
            0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral(arg3, v6)
        } else {
            0
        };
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::return_pocket_object_after_withdraw<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, T1, ScallopWitness, 0x1::type_name::TypeName, u64>(witness(), 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::version::current_version(), arg0, arg1, v2, v1, v7, 0x2::coin::into_balance<T1>(v5), v3, 0x2::vec_map::from_keys_values<0x1::type_name::TypeName, u64>(v4, prices_for(arg6, &v4)), account_collateral(arg3))
    }

    public(friend) fun witness() : ScallopWitness {
        ScallopWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

