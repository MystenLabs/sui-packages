module 0xa2634fb03e317c7e7f59125732d359451af534a8c9a85fa61611c3ef19541293::main {
    struct UpgradedEvent has copy, drop {
        prev_version: u64,
        new_version: u64,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        version: u64,
        is_active: bool,
        scallop_obligation_key: 0x1::option::Option<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>,
        vesca_key: 0x1::option::Option<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>,
        flash_loan_fee: u64,
        new_pool_index: u64,
    }

    struct PoolData<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        pool_index: u64,
        next_position_index: u64,
        collateral_coin_balance: 0x2::balance::Balance<T0>,
        collateral_weight: u64,
        pool_scoin_amount: u128,
        pool_debt_amount: u128,
        market_scoin_balance: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>,
        rewards: 0x2::bag::Bag,
    }

    public entry fun add_pool<T0, T1>(arg0: &0xa2634fb03e317c7e7f59125732d359451af534a8c9a85fa61611c3ef19541293::ownership::OwnerCap, arg1: &mut GlobalConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        let v0 = arg1.new_pool_index;
        let v1 = PoolData<T0, T1>{
            id                      : 0x2::object::new(arg3),
            pool_index              : v0,
            next_position_index     : 0,
            collateral_coin_balance : 0x2::balance::zero<T0>(),
            collateral_weight       : arg2,
            pool_scoin_amount       : 0,
            pool_debt_amount        : 0,
            market_scoin_balance    : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(),
            rewards                 : 0x2::bag::new(arg3),
        };
        arg1.new_pool_index = v0 + 1;
        0x2::transfer::share_object<PoolData<T0, T1>>(v1);
    }

    fun assert_active(arg0: &GlobalConfig) {
        assert!(arg0.is_active, 100);
    }

    fun assert_obligation(arg0: &GlobalConfig) {
        assert!(0x1::option::is_some<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&arg0.scallop_obligation_key), 101);
    }

    fun assert_version(arg0: &GlobalConfig) {
        assert!(arg0.version == 1, 1);
    }

    public entry fun close_position<T0, T1>(arg0: &mut GlobalConfig, arg1: &mut PoolData<T0, T1>, arg2: &mut 0xa2634fb03e317c7e7f59125732d359451af534a8c9a85fa61611c3ef19541293::position::Position<T0, T1>, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::config::VeScaProtocolConfig, arg13: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury::VeScaTreasury, arg14: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaTable, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg17: bool, arg18: u128, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert_version(arg0);
        assert_obligation(arg0);
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T1>(arg5, arg6, 0x2::coin::take<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut arg1.market_scoin_balance, (((0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg1.market_scoin_balance) as u128) * 0xa2634fb03e317c7e7f59125732d359451af534a8c9a85fa61611c3ef19541293::position::get_position_scoin_share_in_pool<T0, T1>(arg2) / arg1.pool_scoin_amount) as u64), arg20), arg19, arg20);
        let v1 = 0x2::coin::value<T1>(&v0);
        0xa2634fb03e317c7e7f59125732d359451af534a8c9a85fa61611c3ef19541293::borrow_incentive::unstake_scallop_obligation(arg9, arg10, arg11, 0x1::option::borrow_mut<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&mut arg0.scallop_obligation_key), arg3, arg19, arg20);
        let v2 = (get_scallop_market_debt_amount<T1>(arg3) as u128) * 0xa2634fb03e317c7e7f59125732d359451af534a8c9a85fa61611c3ef19541293::position::get_position_debt_share<T0, T1>(arg2) / arg1.pool_debt_amount;
        let v3 = if ((v2 as u64) > v1) {
            (v2 as u64) - v1
        } else {
            0
        };
        let (v4, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T1>(arg5, arg6, v3, arg20);
        let v6 = v4;
        assert!(v3 == 0x2::coin::value<T1>(&v6), 104);
        0x2::coin::join<T1>(&mut v0, v6);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::repay::repay<T1>(arg5, arg3, arg6, v0, arg19, arg20);
        if (0x1::option::is_some<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&arg0.vesca_key)) {
            0xa2634fb03e317c7e7f59125732d359451af534a8c9a85fa61611c3ef19541293::borrow_incentive::stake_with_ve_sca(arg9, arg10, arg11, 0x1::option::borrow_mut<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&mut arg0.scallop_obligation_key), arg3, arg4, arg12, arg13, arg14, 0x1::option::borrow<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&arg0.vesca_key), arg19, arg20);
        } else {
            0xa2634fb03e317c7e7f59125732d359451af534a8c9a85fa61611c3ef19541293::borrow_incentive::stake_scallop_obligation(arg9, arg10, arg11, 0x1::option::borrow_mut<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&mut arg0.scallop_obligation_key), arg3, arg4, arg19, arg20);
        };
        assert!(v3 > 0, 100);
        abort 107
    }

    fun get_position_index_in_pool<T0, T1>(arg0: &mut PoolData<T0, T1>) : u64 {
        let v0 = arg0.next_position_index;
        arg0.next_position_index = v0 + 1;
        v0
    }

    fun get_scallop_market_debt_amount<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) : u64 {
        let (v0, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg0, 0x1::type_name::get<T0>());
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                     : 0x2::object::new(arg0),
            version                : 1,
            is_active              : true,
            scallop_obligation_key : 0x1::option::none<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(),
            vesca_key              : 0x1::option::none<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(),
            flash_loan_fee         : 10,
            new_pool_index         : 0,
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    public entry fun open_position<T0, T1>(arg0: &mut GlobalConfig, arg1: &mut PoolData<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg6: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg7: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg8: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg9: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg10: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg11: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg12: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::config::VeScaProtocolConfig, arg13: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury::VeScaTreasury, arg14: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaTable, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert_version(arg0);
        assert_obligation(arg0);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::object::id<PoolData<T0, T1>>(arg1);
        let v2 = get_position_index_in_pool<T0, T1>(arg1);
        let v3 = 0xa2634fb03e317c7e7f59125732d359451af534a8c9a85fa61611c3ef19541293::position::new<T0, T1>(v1, v2, v0, 0, 0, arg16);
        0xa2634fb03e317c7e7f59125732d359451af534a8c9a85fa61611c3ef19541293::borrow_incentive::unstake_scallop_obligation(arg6, arg7, arg8, 0x1::option::borrow_mut<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&mut arg0.scallop_obligation_key), arg4, arg15, arg16);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::deposit_collateral::deposit_collateral<T0>(arg9, arg4, arg10, arg2, arg16);
        assert!(arg1.collateral_weight < 10000, 103);
        let v4 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow::borrow<T1>(arg9, arg4, 0x1::option::borrow_mut<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&mut arg0.scallop_obligation_key), arg10, arg3, 0xa2634fb03e317c7e7f59125732d359451af534a8c9a85fa61611c3ef19541293::math::mul_div(v0, arg1.collateral_weight, 10000), arg11, arg15, arg16);
        if (0x1::option::is_some<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&arg0.vesca_key)) {
            0xa2634fb03e317c7e7f59125732d359451af534a8c9a85fa61611c3ef19541293::borrow_incentive::stake_with_ve_sca(arg6, arg7, arg8, 0x1::option::borrow_mut<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&mut arg0.scallop_obligation_key), arg4, arg5, arg12, arg13, arg14, 0x1::option::borrow<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&arg0.vesca_key), arg15, arg16);
        } else {
            0xa2634fb03e317c7e7f59125732d359451af534a8c9a85fa61611c3ef19541293::borrow_incentive::stake_scallop_obligation(arg6, arg7, arg8, 0x1::option::borrow_mut<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&mut arg0.scallop_obligation_key), arg4, arg5, arg15, arg16);
        };
        let v5 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T1>(arg9, arg10, v4, arg15, arg16);
        let v6 = if (arg1.pool_scoin_amount == 0) {
            (0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&v5) as u128)
        } else {
            arg1.pool_scoin_amount * (0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&v5) as u128) / (0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg1.market_scoin_balance) as u128)
        };
        let v7 = if (arg1.pool_debt_amount == 0) {
            (0x2::coin::value<T1>(&v4) as u128)
        } else {
            arg1.pool_debt_amount * (0x2::coin::value<T1>(&v4) as u128) / (get_scallop_market_debt_amount<T1>(arg4) as u128)
        };
        0xa2634fb03e317c7e7f59125732d359451af534a8c9a85fa61611c3ef19541293::position::increase_position_scoin_share_in_pool<T0, T1>(&mut v3, v6);
        0xa2634fb03e317c7e7f59125732d359451af534a8c9a85fa61611c3ef19541293::position::increase_position_debt_share<T0, T1>(&mut v3, v7);
        arg1.pool_scoin_amount = arg1.pool_scoin_amount + v6;
        arg1.pool_debt_amount = arg1.pool_debt_amount + v7;
        0x2::coin::put<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut arg1.market_scoin_balance, v5);
        0x2::transfer::public_transfer<0xa2634fb03e317c7e7f59125732d359451af534a8c9a85fa61611c3ef19541293::position::Position<T0, T1>>(v3, 0x2::tx_context::sender(arg16));
    }

    public entry fun open_sc_obligation(arg0: &0xa2634fb03e317c7e7f59125732d359451af534a8c9a85fa61611c3ef19541293::ownership::OwnerCap, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut GlobalConfig, arg3: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg4: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg5: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg6: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_version(arg2);
        assert!(0x1::option::is_none<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&arg2.scallop_obligation_key), 102);
        let (v0, v1, v2) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::open_obligation(arg1, arg8);
        let v3 = v0;
        0x1::option::fill<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&mut arg2.scallop_obligation_key, v1);
        0xa2634fb03e317c7e7f59125732d359451af534a8c9a85fa61611c3ef19541293::borrow_incentive::stake_scallop_obligation(arg3, arg4, arg5, 0x1::option::borrow_mut<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&mut arg2.scallop_obligation_key), &mut v3, arg6, arg7, arg8);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::return_obligation(arg1, v3, v2);
    }

    public entry fun update_active_status(arg0: &0xa2634fb03e317c7e7f59125732d359451af534a8c9a85fa61611c3ef19541293::ownership::OwnerCap, arg1: &mut GlobalConfig, arg2: bool) {
        assert_version(arg1);
        arg1.is_active = arg2;
    }

    public entry fun upgrade(arg0: &0xa2634fb03e317c7e7f59125732d359451af534a8c9a85fa61611c3ef19541293::ownership::OwnerCap, arg1: &mut GlobalConfig) {
        assert_active(arg1);
        assert!(arg1.version < 1, 1);
        let v0 = UpgradedEvent{
            prev_version : arg1.version,
            new_version  : 1,
        };
        0x2::event::emit<UpgradedEvent>(v0);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

