module 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::main {
    struct CreateFarmEvent has copy, drop {
        caller: address,
        farm_id: 0x2::object::ID,
    }

    struct AddLiquidityEvent has copy, drop {
        caller: address,
        farm_id: 0x2::object::ID,
        deposit_amount: u64,
        old_total_deposit_share: u128,
        old_total_debt_share: u128,
        old_total_lend_share: u128,
        new_total_deposit_share: u128,
        new_total_debt_share: u128,
        new_total_lend_share: u128,
        borrow_fee: u64,
        old_total_lend_amount: u64,
        old_total_debt_amount: u64,
        old_total_deposit_amount: u64,
        new_total_lend_amount: u64,
        new_total_debt_amount: u64,
        new_total_deposit_amount: u64,
    }

    struct RemoveLiquidityEvent has copy, drop {
        caller: address,
        farm_id: 0x2::object::ID,
        withdraw_coin_amount: u64,
        redeem_coin_amount: u64,
        old_total_deposit_share: u128,
        old_total_debt_share: u128,
        old_total_lend_share: u128,
        new_total_deposit_share: u128,
        new_total_debt_share: u128,
        new_total_lend_share: u128,
        old_total_lend_amount: u64,
        old_total_debt_amount: u64,
        old_total_deposit_amount: u64,
        new_total_lend_amount: u64,
        new_total_debt_amount: u64,
        new_total_deposit_amount: u64,
    }

    struct CompoundBorrowRewardStartEvent has copy, drop {
        caller: address,
        farm_id: 0x2::object::ID,
        reward_coin: 0x1::string::String,
        reward_amount: u64,
    }

    struct CompoundBorrowRewardEndEvent has copy, drop {
        caller: address,
        farm_id: 0x2::object::ID,
        repay_coin: 0x1::string::String,
        repay_amount: u64,
    }

    struct CompoundHotPotato has drop {
        farm_id: 0x2::object::ID,
        caller: address,
    }

    struct ShortfallEvent has copy, drop {
        caller: address,
        farm_id: 0x2::object::ID,
        debt_shortfall: u64,
        collateral_reduction: u64,
        redeem_coin_amount: u64,
        debt_amount: u64,
        base_collateral_needed: u64,
        fee_amount: u64,
        total_collateral_needed: u64,
    }

    struct LiquidateEvent has copy, drop {
        caller: address,
        farm_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        debt_coin_type: 0x1::ascii::String,
        deposit_coin_type: 0x1::ascii::String,
        health_ratio: u64,
        liquidation_threshold: u64,
        debt_amount: u64,
        deposit_amount: u64,
        liquidation_fee_deposit_amount: u64,
        liquidation_fee_debt_amount: u64,
    }

    struct RemovePositionEvent has copy, drop {
        caller: address,
        farm_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        debt_coin_type: 0x1::ascii::String,
        deposit_coin_type: 0x1::ascii::String,
    }

    struct Farm<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        collateral_weight: u64,
        total_deposit_share: u128,
        total_debt_share: u128,
        total_lend_share: u128,
        scoin_balance: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>,
        obligation_key: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey,
        rewards: 0x2::bag::Bag,
    }

    public fun info<T0, T1>(arg0: &Farm<T0, T1>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) : (u64, u128, u128, u128, u64, u64, u64, u64, u64) {
        (arg0.collateral_weight, arg0.total_deposit_share, arg0.total_debt_share, arg0.total_lend_share, 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg0.scoin_balance), 0x2::bag::length(&arg0.rewards), 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::safe_get_collateral_amount<T0>(arg1), 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::safe_get_debt_amount<T1>(arg1), 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg0.scoin_balance))
    }

    public(friend) fun add_farm<T0, T1>(arg0: u64, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg3: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg4: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 <= 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::max_percent(), 103);
        let (v0, v1, v2) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::open_obligation(arg1, arg7);
        let v3 = v1;
        let v4 = v0;
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::stake(arg2, arg3, arg4, &v3, &mut v4, arg5, arg6, arg7);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::return_obligation(arg1, v4, v2);
        let v5 = Farm<T0, T1>{
            id                  : 0x2::object::new(arg7),
            collateral_weight   : arg0,
            total_deposit_share : 0,
            total_debt_share    : 0,
            total_lend_share    : 0,
            scoin_balance       : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(),
            obligation_key      : v3,
            rewards             : 0x2::bag::new(arg7),
        };
        0x2::transfer::public_share_object<Farm<T0, T1>>(v5);
        let v6 = CreateFarmEvent{
            caller  : 0x2::tx_context::sender(arg7),
            farm_id : 0x2::object::id<Farm<T0, T1>>(&v5),
        };
        0x2::event::emit<CreateFarmEvent>(v6);
    }

    public(friend) fun add_liquidity<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: &mut 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::position::Position, arg2: 0x2::coin::Coin<T0>, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg6: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg7: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg8: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg9: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberTable, arg10: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberWhitelist, arg11: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg12: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg13: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::unstake_v2(arg6, arg7, arg8, &arg0.obligation_key, arg4, arg9, arg10, arg14, arg15);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::safe_get_collateral_amount<T0>(arg4);
        let v2 = 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::safe_mul_div(arg0.total_deposit_share, (v0 as u128), (v1 as u128));
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::deposit_collateral::deposit_collateral<T0>(arg11, arg4, arg12, arg2, arg15);
        assert!(arg0.collateral_weight < 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::max_percent(), 103);
        let v3 = 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::mul_div_u64(v0, arg0.collateral_weight, 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::max_percent());
        let v4 = 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::safe_get_debt_amount<T1>(arg4);
        let v5 = 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::safe_mul_div(arg0.total_debt_share, (v3 as u128), (v4 as u128));
        let v6 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow::borrow<T1>(arg11, arg4, &arg0.obligation_key, arg12, arg3, v3, arg13, arg14, arg15);
        let v7 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T1>(arg11, arg12, v6, arg14, arg15);
        let v8 = 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg0.scoin_balance);
        let v9 = 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::safe_mul_div(arg0.total_lend_share, (0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&v7) as u128), (v8 as u128));
        0x2::coin::put<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut arg0.scoin_balance, v7);
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::stake(arg6, arg7, arg8, &arg0.obligation_key, arg4, arg5, arg14, arg15);
        0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::position::increase_deposit_share(arg1, v2);
        0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::position::increase_debt_share(arg1, v5);
        0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::position::increase_lend_share(arg1, v9);
        arg0.total_deposit_share = arg0.total_deposit_share + v2;
        arg0.total_debt_share = arg0.total_debt_share + v5;
        arg0.total_lend_share = arg0.total_lend_share + v9;
        let v10 = AddLiquidityEvent{
            caller                   : 0x2::tx_context::sender(arg15),
            farm_id                  : 0x2::object::id<Farm<T0, T1>>(arg0),
            deposit_amount           : v0,
            old_total_deposit_share  : arg0.total_deposit_share,
            old_total_debt_share     : arg0.total_debt_share,
            old_total_lend_share     : arg0.total_lend_share,
            new_total_deposit_share  : arg0.total_deposit_share,
            new_total_debt_share     : arg0.total_debt_share,
            new_total_lend_share     : arg0.total_lend_share,
            borrow_fee               : 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::safe_get_debt_amount<T1>(arg4) - v4 + 0x2::coin::value<T1>(&v6),
            old_total_lend_amount    : v8,
            old_total_debt_amount    : v4,
            old_total_deposit_amount : v1,
            new_total_lend_amount    : 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg0.scoin_balance),
            new_total_debt_amount    : 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::safe_get_debt_amount<T1>(arg4),
            new_total_deposit_amount : 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::safe_get_collateral_amount<T0>(arg4),
        };
        0x2::event::emit<AddLiquidityEvent>(v10);
    }

    fun calculate_collateral_for_debt_shortfall<T0, T1>(arg0: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg1: u64, arg2: &0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: address, arg5: 0x2::object::ID, arg6: u64, arg7: u64) : u64 {
        let v0 = 0x1::fixed_point32::multiply_u64(arg1, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::price::get_price(arg0, 0x1::type_name::get<T1>(), arg3), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::price::get_price(arg0, 0x1::type_name::get<T0>(), arg3)));
        let (_, _, _, v4, _, _) = 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::info(arg2);
        let v7 = 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::mul_div((v0 as u128), (v4 as u128), 10000);
        let v8 = v0 + 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::to_u64(v7);
        let v9 = ShortfallEvent{
            caller                  : arg4,
            farm_id                 : arg5,
            debt_shortfall          : arg1,
            collateral_reduction    : v8,
            redeem_coin_amount      : arg6,
            debt_amount             : arg7,
            base_collateral_needed  : v0,
            fee_amount              : 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::to_u64(v7),
            total_collateral_needed : v8,
        };
        0x2::event::emit<ShortfallEvent>(v9);
        v8
    }

    public(friend) fun compound_borrow_reward_end<T0, T1>(arg0: &Farm<T0, T1>, arg1: CompoundHotPotato, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg8: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg9: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg10: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::config::VeScaProtocolConfig, arg11: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury::VeScaTreasury, arg12: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaTable, arg13: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey, arg14: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberTable, arg15: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberWhitelist, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.farm_id == 0x2::object::id<Farm<T0, T1>>(arg0), 115);
        assert!(arg1.caller == 0x2::tx_context::sender(arg17), 116);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::repay::repay<T1>(arg5, arg3, arg6, arg2, arg16, arg17);
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::stake_with_ve_sca_v2(arg7, arg8, arg9, &arg0.obligation_key, arg3, arg4, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
        let v0 = CompoundBorrowRewardEndEvent{
            caller       : 0x2::tx_context::sender(arg17),
            farm_id      : 0x2::object::id<Farm<T0, T1>>(arg0),
            repay_coin   : 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::get_type_name_str<T1>(),
            repay_amount : 0x2::coin::value<T1>(&arg2),
        };
        0x2::event::emit<CompoundBorrowRewardEndEvent>(v0);
    }

    public(friend) fun compound_borrow_reward_start<T0, T1, T2>(arg0: &Farm<T0, T1>, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg3: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg4: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg5: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberTable, arg6: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberWhitelist, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, CompoundHotPotato) {
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::unstake_v2(arg2, arg3, arg4, &arg0.obligation_key, arg1, arg5, arg6, arg7, arg8);
        let v0 = 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::redeem_rewards<T2>(arg2, arg3, arg4, &arg0.obligation_key, arg1, arg7, arg8);
        let v1 = CompoundHotPotato{
            farm_id : 0x2::object::id<Farm<T0, T1>>(arg0),
            caller  : 0x2::tx_context::sender(arg8),
        };
        let v2 = CompoundBorrowRewardStartEvent{
            caller        : 0x2::tx_context::sender(arg8),
            farm_id       : 0x2::object::id<Farm<T0, T1>>(arg0),
            reward_coin   : 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::get_type_name_str<T2>(),
            reward_amount : 0x2::coin::value<T2>(&v0),
        };
        0x2::event::emit<CompoundBorrowRewardStartEvent>(v2);
        (v0, v1)
    }

    public fun get_borrow_incentive_reward<T0, T1>(arg0: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) : u64 {
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::points(0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::pool_point(0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::account_pool_record(0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::incentive_account(arg0, arg1), 0x1::type_name::with_defining_ids<T0>()), 0x1::type_name::with_defining_ids<T1>()))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::new(3000, 500, @0x5b3587896d2340e5741424d891a61dc4ce7e18e3c48a10b5ca78eabccb2769f5, 9000, arg0);
    }

    public(friend) fun liquidate<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: &mut 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::position::Position, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg9: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg11: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberTable, arg12: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberWhitelist, arg13: &0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::GlobalConfig, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::get_liquidation_threshold(arg13);
        let (_, v2, v3, _) = 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::position::info(arg1);
        let v5 = 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::to_u64(0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::mul_div((0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::safe_get_debt_amount<T1>(arg2) as u128), v3, arg0.total_debt_share));
        let v6 = 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::to_u64(0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::mul_div((0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::safe_get_collateral_amount<T0>(arg2) as u128), v2, arg0.total_deposit_share));
        let v7 = 0x1::fixed_point32::multiply_u64(v6, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::price::get_price(arg7, 0x1::type_name::get<T0>(), arg14));
        let v8 = if (v7 == 0) {
            0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::max_percent()
        } else {
            0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::mul_div_u64(0x1::fixed_point32::multiply_u64(v5, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::price::get_price(arg7, 0x1::type_name::get<T1>(), arg14)), 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::max_percent(), v7)
        };
        assert!(v8 >= v0, 112);
        let (v9, v10) = remove_all_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        let v11 = v10;
        let v12 = v9;
        let v13 = 0x2::coin::value<T0>(&v12);
        let v14 = 0x2::coin::value<T1>(&v11);
        let v15 = 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::get_liquidation_fee_wallet(arg13);
        if (v13 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v12, v15);
        } else {
            0x2::coin::destroy_zero<T0>(v12);
        };
        if (v14 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v11, v15);
        } else {
            0x2::coin::destroy_zero<T1>(v11);
        };
        let v16 = LiquidateEvent{
            caller                         : 0x2::tx_context::sender(arg15),
            farm_id                        : 0x2::object::id<Farm<T0, T1>>(arg0),
            position_id                    : 0x2::object::id<0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::position::Position>(arg1),
            debt_coin_type                 : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            deposit_coin_type              : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            health_ratio                   : v8,
            liquidation_threshold          : v0,
            debt_amount                    : v5,
            deposit_amount                 : v6,
            liquidation_fee_deposit_amount : v13,
            liquidation_fee_debt_amount    : v14,
        };
        0x2::event::emit<LiquidateEvent>(v16);
    }

    public(friend) fun open_position<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg5: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg6: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg7: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg8: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberTable, arg9: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberWhitelist, arg10: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg11: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg12: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::position::Position {
        let v0 = 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::position::new(0x2::object::id<Farm<T0, T1>>(arg0), 0, 0, 0, arg14);
        let v1 = &mut v0;
        add_liquidity<T0, T1>(arg0, v1, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        v0
    }

    public fun redeem_borrow_incentive_rewards_debug<T0, T1, T2>(arg0: &Farm<T0, T1>, arg1: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg2: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg3: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::redeem_rewards<T2>(arg1, arg2, arg3, &arg0.obligation_key, arg4, arg5, arg6), 0x2::tx_context::sender(arg6));
    }

    public(friend) fun remove_all_liquidity<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: &mut 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::position::Position, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg9: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg11: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberTable, arg12: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberWhitelist, arg13: &0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::GlobalConfig, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::position::deposit_share(arg1);
        remove_liquidity<T0, T1>(arg0, v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    }

    public(friend) fun remove_liquidity<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: u128, arg2: &mut 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::position::Position, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberTable, arg13: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberWhitelist, arg14: &0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::GlobalConfig, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (_, v1, v2, v3) = 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::position::info(arg2);
        assert!(v1 >= arg1, 109);
        let v4 = 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::mul_div(v2, arg1, v1);
        let v5 = 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::mul_div(v3, arg1, v1);
        let v6 = 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg0.scoin_balance);
        let v7 = 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::safe_get_debt_amount<T1>(arg3);
        let v8 = 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::to_u64(0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::mul_div((v7 as u128), v4, arg0.total_debt_share));
        let v9 = 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::safe_get_collateral_amount<T0>(arg3);
        let v10 = 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::to_u64(0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::mul_div((v9 as u128), arg1, arg0.total_deposit_share));
        let v11 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T1>(arg5, arg6, 0x2::coin::take<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut arg0.scoin_balance, 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::to_u64(0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::mul_div((v6 as u128), v5, arg0.total_lend_share)), arg16), arg15, arg16);
        let v12 = 0x2::coin::value<T1>(&v11);
        let (v13, v14, v15) = if (v12 >= v8) {
            (0x2::coin::split<T1>(&mut v11, v8, arg16), v10, v11)
        } else {
            let v16 = calculate_collateral_for_debt_shortfall<T0, T1>(arg8, v8 - v12, arg14, arg15, 0x2::tx_context::sender(arg16), 0x2::object::id<Farm<T0, T1>>(arg0), v12, v8);
            assert!(v16 <= v10, 111);
            (v11, v10 - v16, 0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg16))
        };
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::unstake_v2(arg9, arg10, arg11, &arg0.obligation_key, arg3, arg12, arg13, arg15, arg16);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::repay::repay<T1>(arg5, arg3, arg6, v13, arg15, arg16);
        let v17 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::withdraw_collateral::withdraw_collateral<T0>(arg5, arg3, &arg0.obligation_key, arg6, arg7, v14, arg8, arg15, arg16);
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::stake(arg9, arg10, arg11, &arg0.obligation_key, arg3, arg4, arg15, arg16);
        0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::position::decrease_deposit_share(arg2, arg1);
        0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::position::decrease_debt_share(arg2, v4);
        0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::position::decrease_lend_share(arg2, v5);
        arg0.total_deposit_share = arg0.total_deposit_share - arg1;
        arg0.total_debt_share = arg0.total_debt_share - v4;
        arg0.total_lend_share = arg0.total_lend_share - v5;
        let v18 = RemoveLiquidityEvent{
            caller                   : 0x2::tx_context::sender(arg16),
            farm_id                  : 0x2::object::id<Farm<T0, T1>>(arg0),
            withdraw_coin_amount     : 0x2::coin::value<T0>(&v17),
            redeem_coin_amount       : v12,
            old_total_deposit_share  : arg0.total_deposit_share,
            old_total_debt_share     : arg0.total_debt_share,
            old_total_lend_share     : arg0.total_lend_share,
            new_total_deposit_share  : arg0.total_deposit_share,
            new_total_debt_share     : arg0.total_debt_share,
            new_total_lend_share     : arg0.total_lend_share,
            old_total_lend_amount    : v6,
            old_total_debt_amount    : v7,
            old_total_deposit_amount : v9,
            new_total_lend_amount    : 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg0.scoin_balance),
            new_total_debt_amount    : 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::safe_get_debt_amount<T1>(arg3),
            new_total_deposit_amount : 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::safe_get_collateral_amount<T0>(arg3),
        };
        0x2::event::emit<RemoveLiquidityEvent>(v18);
        (v17, v15)
    }

    public(friend) fun remove_position<T0, T1>(arg0: &Farm<T0, T1>, arg1: 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::position::Position, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: &0x2::tx_context::TxContext) {
        let (_, v1, v2, v3) = 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::position::info(&arg1);
        assert!(v1 == 0, 117);
        assert!(v2 == 0, 118);
        assert!(v3 == 0, 119);
        assert!(0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::safe_get_collateral_amount<T0>(arg2) == 0, 120);
        assert!(0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::utils::safe_get_debt_amount<T1>(arg2) == 0, 121);
        let v4 = RemovePositionEvent{
            caller            : 0x2::tx_context::sender(arg3),
            farm_id           : 0x2::object::id<Farm<T0, T1>>(arg0),
            position_id       : 0x2::object::id<0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::position::Position>(&arg1),
            debt_coin_type    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            deposit_coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
        };
        0x2::event::emit<RemovePositionEvent>(v4);
        0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::position::destroy(arg1);
    }

    public(friend) fun set_collateral_weight<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: u64) {
        assert!(arg1 <= 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::max_percent(), 103);
        arg0.collateral_weight = arg1;
    }

    // decompiled from Move bytecode v6
}

