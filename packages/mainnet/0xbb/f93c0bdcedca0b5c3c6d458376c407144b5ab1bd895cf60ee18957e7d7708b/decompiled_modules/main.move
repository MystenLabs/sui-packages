module 0xbbf93c0bdcedca0b5c3c6d458376c407144b5ab1bd895cf60ee18957e7d7708b::main {
    struct UpgradedEvent has copy, drop {
        prev_version: u64,
        new_version: u64,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        version: u64,
        is_active: bool,
        vesca_key: 0x1::option::Option<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>,
        flash_loan_fee: u64,
        new_pool_index: u64,
        obligation_key_exist: bool,
    }

    struct PoolData<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        pool_index: u64,
        last_position_index: u64,
        collateral_coin_balance: 0x2::balance::Balance<T0>,
        borrow_coin_balance: 0x2::balance::Balance<T1>,
        borrow_weight: u64,
        collateral_amount: u128,
        borrow_amount: u128,
        market_coin_balance: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>,
        surplus_coin_a: 0x2::balance::Balance<T2>,
    }

    public entry fun add_pool<T0, T1, T2>(arg0: &0xbbf93c0bdcedca0b5c3c6d458376c407144b5ab1bd895cf60ee18957e7d7708b::ownership::OwnerCap, arg1: &mut GlobalConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        let v0 = arg1.new_pool_index;
        let v1 = PoolData<T0, T1, T2>{
            id                      : 0x2::object::new(arg3),
            pool_index              : v0,
            last_position_index     : 0,
            collateral_coin_balance : 0x2::balance::zero<T0>(),
            borrow_coin_balance     : 0x2::balance::zero<T1>(),
            borrow_weight           : arg2,
            collateral_amount       : 0,
            borrow_amount           : 0,
            market_coin_balance     : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(),
            surplus_coin_a          : 0x2::balance::zero<T2>(),
        };
        arg1.new_pool_index = v0 + 1;
        0x2::transfer::share_object<PoolData<T0, T1, T2>>(v1);
    }

    fun assert_active(arg0: &GlobalConfig) {
        assert!(arg0.is_active, 100);
    }

    fun assert_obligation(arg0: &GlobalConfig) {
        assert!(arg0.obligation_key_exist, 101);
    }

    fun assert_version(arg0: &GlobalConfig) {
        assert!(arg0.version == 1, 1);
    }

    fun get_next_position_index<T0, T1, T2>(arg0: &mut PoolData<T0, T1, T2>) : u64 {
        arg0.last_position_index = arg0.last_position_index + 1;
        arg0.last_position_index
    }

    fun get_scallop_market_debt_amount<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) : u64 {
        let (v0, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg0, 0x1::type_name::get<T0>());
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                   : 0x2::object::new(arg0),
            version              : 1,
            is_active            : false,
            vesca_key            : 0x1::option::none<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(),
            flash_loan_fee       : 6,
            new_pool_index       : 0,
            obligation_key_exist : false,
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    public entry fun open_position<T0, T1, T2>(arg0: &mut GlobalConfig, arg1: &mut PoolData<T0, T1, T2>, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg8: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg13: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg14: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg15: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::config::VeScaProtocolConfig, arg16: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury::VeScaTreasury, arg17: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaTable, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert_version(arg0);
        assert_obligation(arg0);
        let v0 = 0x2::object::id<PoolData<T0, T1, T2>>(arg1);
        let v1 = get_next_position_index<T0, T1, T2>(arg1);
        let v2 = 0xbbf93c0bdcedca0b5c3c6d458376c407144b5ab1bd895cf60ee18957e7d7708b::position::new<T0, T1, T2>(v0, v1, arg2, arg3, 0x2::balance::zero<T1>(), 0, 0, arg19);
        0xbbf93c0bdcedca0b5c3c6d458376c407144b5ab1bd895cf60ee18957e7d7708b::borrow_incentive::unstake_scallop_obligation(arg9, arg10, arg11, arg7, arg6, arg18, arg19);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::deposit_collateral::deposit_collateral<T0>(arg12, arg6, arg13, arg4, arg19);
        assert!(arg1.borrow_weight < 10000, 103);
        let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow::borrow<T1>(arg12, arg6, arg7, arg13, arg5, 0xbbf93c0bdcedca0b5c3c6d458376c407144b5ab1bd895cf60ee18957e7d7708b::math::mul_div(0x2::coin::value<T0>(&arg4), arg1.borrow_weight, 10000), arg14, arg18, arg19);
        if (0x1::option::is_some<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&arg0.vesca_key)) {
            0xbbf93c0bdcedca0b5c3c6d458376c407144b5ab1bd895cf60ee18957e7d7708b::borrow_incentive::stake_with_ve_sca(arg9, arg10, arg11, arg7, arg6, arg8, arg15, arg16, arg17, 0x1::option::borrow<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&arg0.vesca_key), arg18, arg19);
        } else {
            0xbbf93c0bdcedca0b5c3c6d458376c407144b5ab1bd895cf60ee18957e7d7708b::borrow_incentive::stake_scallop_obligation(arg9, arg10, arg11, arg7, arg6, arg8, arg18, arg19);
        };
        let v4 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T1>(arg12, arg13, v3, arg18, arg19);
        let v5 = if (arg1.collateral_amount == 0) {
            (0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&v4) as u128)
        } else {
            arg1.collateral_amount * (0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&v4) as u128) / (0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg1.market_coin_balance) as u128)
        };
        let v6 = if (arg1.borrow_amount == 0) {
            (0x2::coin::value<T1>(&v3) as u128)
        } else {
            arg1.borrow_amount * (0x2::coin::value<T1>(&v3) as u128) / (get_scallop_market_debt_amount<T1>(arg6) as u128)
        };
        0xbbf93c0bdcedca0b5c3c6d458376c407144b5ab1bd895cf60ee18957e7d7708b::position::increase_position_pool_share<T0, T1, T2>(&mut v2, v5);
        0xbbf93c0bdcedca0b5c3c6d458376c407144b5ab1bd895cf60ee18957e7d7708b::position::increase_position_debt_share<T0, T1, T2>(&mut v2, v6);
        arg1.collateral_amount = arg1.collateral_amount + v5;
        arg1.borrow_amount = arg1.borrow_amount + v6;
        0x2::coin::put<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut arg1.market_coin_balance, v4);
        0x2::transfer::public_transfer<0xbbf93c0bdcedca0b5c3c6d458376c407144b5ab1bd895cf60ee18957e7d7708b::position::Position<T0, T1, T2>>(v2, 0x2::tx_context::sender(arg19));
    }

    public entry fun open_sc_obligation(arg0: &0xbbf93c0bdcedca0b5c3c6d458376c407144b5ab1bd895cf60ee18957e7d7708b::ownership::OwnerCap, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: address, arg3: &mut GlobalConfig, arg4: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg5: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg6: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg3.obligation_key_exist, 102);
        0xbbf93c0bdcedca0b5c3c6d458376c407144b5ab1bd895cf60ee18957e7d7708b::obligation::open_obligation(arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9);
        arg3.obligation_key_exist = true;
    }

    public entry fun remove_liquidity<T0, T1, T2>(arg0: &mut GlobalConfig, arg1: &mut PoolData<T0, T1, T2>, arg2: &mut 0xbbf93c0bdcedca0b5c3c6d458376c407144b5ab1bd895cf60ee18957e7d7708b::position::Position<T0, T1, T2>, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg6: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::config::VeScaProtocolConfig, arg14: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury::VeScaTreasury, arg15: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaTable, arg16: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg17: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg18: bool, arg19: u128, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert_version(arg0);
        assert_obligation(arg0);
        let v0 = 0xbbf93c0bdcedca0b5c3c6d458376c407144b5ab1bd895cf60ee18957e7d7708b::position::get_position_pool_share<T0, T1, T2>(arg2);
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T1>(arg6, arg7, 0x2::coin::take<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut arg1.market_coin_balance, (((0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg1.market_coin_balance) as u128) * v0 / arg1.collateral_amount) as u64), arg21), arg20, arg21);
        let v2 = 0x2::coin::value<T1>(&v1);
        0xbbf93c0bdcedca0b5c3c6d458376c407144b5ab1bd895cf60ee18957e7d7708b::borrow_incentive::unstake_scallop_obligation(arg10, arg11, arg12, arg4, arg3, arg20, arg21);
        let v3 = 0xbbf93c0bdcedca0b5c3c6d458376c407144b5ab1bd895cf60ee18957e7d7708b::position::get_position_debt_share<T0, T1, T2>(arg2);
        let v4 = (get_scallop_market_debt_amount<T1>(arg3) as u128) * v3 / arg1.borrow_amount;
        let v5 = if ((v4 as u64) > v2) {
            (v4 as u64) - v2
        } else {
            0
        };
        let (v6, v7) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T1>(arg6, arg7, v5, arg21);
        let v8 = v6;
        assert!(v5 == 0x2::coin::value<T1>(&v8), 104);
        0x2::coin::join<T1>(&mut v1, v8);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::repay::repay<T1>(arg6, arg3, arg7, v1, arg20, arg21);
        let v9 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::withdraw_collateral::withdraw_collateral<T0>(arg6, arg3, arg4, arg7, arg8, 0xbbf93c0bdcedca0b5c3c6d458376c407144b5ab1bd895cf60ee18957e7d7708b::position::get_position_collateral_coin_balance<T0, T1, T2>(arg2), arg9, arg20, arg21);
        if (0x1::option::is_some<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&arg0.vesca_key)) {
            0xbbf93c0bdcedca0b5c3c6d458376c407144b5ab1bd895cf60ee18957e7d7708b::borrow_incentive::stake_with_ve_sca(arg10, arg11, arg12, arg4, arg3, arg5, arg13, arg14, arg15, 0x1::option::borrow<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&arg0.vesca_key), arg20, arg21);
        } else {
            0xbbf93c0bdcedca0b5c3c6d458376c407144b5ab1bd895cf60ee18957e7d7708b::borrow_incentive::stake_scallop_obligation(arg10, arg11, arg12, arg4, arg3, arg5, arg20, arg21);
        };
        if (v5 > 0) {
            let v10 = false;
            let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg17, arg18, v10, 0xbbf93c0bdcedca0b5c3c6d458376c407144b5ab1bd895cf60ee18957e7d7708b::math::mul_div(v5, arg0.flash_loan_fee, 10000));
            let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v11);
            let (v13, v14) = 0xbbf93c0bdcedca0b5c3c6d458376c407144b5ab1bd895cf60ee18957e7d7708b::swap::swap<T0, T1>(arg16, arg17, 0x2::coin::split<T0>(&mut v9, v12, arg21), 0x2::coin::zero<T1>(arg21), arg18, v10, v12, arg19, arg20, arg21);
            0x2::coin::join<T0>(&mut v9, v13);
            0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::repay_flash_loan<T1>(arg6, arg7, v14, v7, arg21);
        } else {
            0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::repay_flash_loan<T1>(arg6, arg7, 0x2::coin::zero<T1>(arg21), v7, arg21);
        };
        0xbbf93c0bdcedca0b5c3c6d458376c407144b5ab1bd895cf60ee18957e7d7708b::position::decrease_position_pool_share<T0, T1, T2>(arg2, v0);
        0xbbf93c0bdcedca0b5c3c6d458376c407144b5ab1bd895cf60ee18957e7d7708b::position::decrease_position_debt_share<T0, T1, T2>(arg2, v3);
        arg1.collateral_amount = arg1.collateral_amount - v0;
        arg1.borrow_amount = arg1.borrow_amount - v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v9, 0x2::tx_context::sender(arg21));
    }

    public entry fun update_active_status(arg0: &0xbbf93c0bdcedca0b5c3c6d458376c407144b5ab1bd895cf60ee18957e7d7708b::ownership::OwnerCap, arg1: &mut GlobalConfig, arg2: bool) {
        assert_version(arg1);
        arg1.is_active = arg2;
    }

    public entry fun upgrade(arg0: &0xbbf93c0bdcedca0b5c3c6d458376c407144b5ab1bd895cf60ee18957e7d7708b::ownership::OwnerCap, arg1: &mut GlobalConfig) {
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

