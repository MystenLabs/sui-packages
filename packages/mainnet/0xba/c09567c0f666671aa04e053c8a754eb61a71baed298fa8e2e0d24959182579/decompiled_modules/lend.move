module 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::lend {
    struct DepositEvent has copy, drop {
        market_id: 0x2::object::ID,
        depositor: address,
        deposit_amount: u64,
        market_coin_amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        market_id: 0x2::object::ID,
        withdrawer: address,
        market_coin_amount: u64,
        underlying_amount: u64,
    }

    public fun report_unreadable<T0, T1: store>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::PositionKey, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::object::ID> {
        assert!(!0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::is_current_version(arg2), 801);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::report_unreadable<T0, T1, 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation::ScallopWitness>(0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation::witness(), 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::version::current_version(), arg0, arg1, arg3, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::reason_version_mismatch(), arg4, arg5)
    }

    public fun clear_version_sighting<T0>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::PositionKey) {
        assert!(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::is_current_version(arg2), 802);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::clear_unreadable_sighting<T0, 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation::ScallopWitness>(0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation::witness(), 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::version::current_version(), arg0, arg1, arg3);
    }

    public fun compute_underlying_value<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let (v0, v1, v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg0)), 0x1::type_name::get<T0>()));
        if (v3 == 0) {
            return arg1
        };
        (((arg1 as u128) * ((v0 + v1 - v2) as u128) / (v3 as u128)) as u64)
    }

    public fun deposit<T0, T1>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 > 0, 800);
        let v0 = 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation::open_move<T0>(arg0, arg1, arg4, arg2, arg3, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::move_enter(), 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::role_flag_lend());
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T1>(arg5, arg6, 0x2::coin::from_balance<T1>(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::take<T0, T1, 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation::ScallopWitness>(0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation::witness(), arg1, &mut v0, arg7), arg9), arg8, arg9);
        let v2 = DepositEvent{
            market_id          : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg6),
            depositor          : 0x2::tx_context::sender(arg9),
            deposit_amount     : arg7,
            market_coin_amount : 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&v1),
        };
        0x2::event::emit<DepositEvent>(v2);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::put_position<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>, T1, 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation::ScallopWitness>(0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation::witness(), arg1, arg3, &mut v0, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(v1));
        0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation::settle<T0>(arg1, arg3, v0, arg6);
    }

    public fun reattach_pocket<T0, T1>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::QuoteBook, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_yield_balance<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(arg1);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::assert_bound_venue(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_venue<T0>(arg1), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg5));
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::reattach_pocket_yield<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>, 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation::ScallopWitness>(0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation::witness(), 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::version::current_version(), arg0, arg1, arg2, arg3, v0, supply_reading<T1>(arg4, arg5, v0, arg6), 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(), arg6, arg7);
    }

    fun redeem_coins<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg0, arg1, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg2, arg4), arg3, arg4);
        let v1 = WithdrawEvent{
            market_id          : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg1),
            withdrawer         : 0x2::tx_context::sender(arg4),
            market_coin_amount : 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg2),
            underlying_amount  : 0x2::coin::value<T0>(&v0),
        };
        0x2::event::emit<WithdrawEvent>(v1);
        0x2::coin::into_balance<T0>(v0)
    }

    public fun redeem_pocket<T0, T1>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 800);
        let (v0, v1) = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::begin_unwind<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>, 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation::ScallopWitness>(0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation::witness(), 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::version::current_version(), arg0, arg1, arg4, arg5);
        let v2 = v1;
        let v3 = v0;
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::assert_bound_venue(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_venue<T0>(arg0), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg3));
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::add_unwind_proceeds<T0, T1, 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation::ScallopWitness>(0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation::witness(), 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::version::current_version(), arg0, arg1, &mut v2, 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&v3), 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_yield_balance<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(arg0), redeem_coins<T1>(arg2, arg3, v3, arg5, arg6));
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::end_unwind<T0>(arg0, v2);
    }

    public fun refresh_supply<T0, T1>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::yield_balance<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>, T1>(arg0, 0x2::object::id<0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo>(arg1));
        let v1 = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::position_key_yield(0x2::object::id<0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo>(arg1), 0x1::type_name::with_defining_ids<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(), 0x1::type_name::with_defining_ids<T1>());
        if (0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::has_position_record<T0>(arg0, v1)) {
            0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::assert_bound_venue(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::position_venue<T0>(arg0, v1), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg3));
        };
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::report_yield_value<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>, T1, 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation::ScallopWitness>(0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation::witness(), 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::version::current_version(), arg0, arg1, v0, supply_reading<T1>(arg2, arg3, v0, arg4), 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(), arg4, arg5);
    }

    fun supply_reading<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: u64, arg3: &0x2::clock::Clock) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation::accrue_interest_for_market(arg0, arg1, arg3);
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0, 0x1::type_name::with_defining_ids<T0>(), compute_underlying_value<T0>(arg1, arg2));
        v0
    }

    public fun withdraw<T0, T1>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 > 0, 800);
        let v0 = 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation::open_move<T0>(arg0, arg1, arg4, arg2, arg3, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::move_exit(), 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::role_flag_lend());
        let v1 = redeem_coins<T1>(arg5, arg6, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::take_position<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>, T1, 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation::ScallopWitness>(0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation::witness(), arg1, &mut v0, arg7), arg8, arg9);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::put<T0, T1, 0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation::ScallopWitness>(0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation::witness(), arg1, &mut v0, v1);
        0xbac09567c0f666671aa04e053c8a754eb61a71baed298fa8e2e0d24959182579::obligation::settle<T0>(arg1, arg3, v0, arg6);
    }

    // decompiled from Move bytecode v7
}

