module 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::main {
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

    struct RemoveLiquidityInternalStartEvent has copy, drop {
        position_id: 0x2::object::ID,
        remove_deposit_share: u128,
        remove_debt_share: u128,
        remove_lend_share: u128,
        remove_debt_amount: u64,
        remove_lend_amount: u64,
        remove_deposit_amount: u64,
        old_total_deposit_share: u128,
        old_total_debt_share: u128,
        old_total_lend_share: u128,
        old_total_deposit_amount: u64,
        old_total_debt_amount: u64,
        old_total_lend_amount: u64,
    }

    struct RemoveLiquidityInternalEndEvent has copy, drop {
        farm_id: 0x2::object::ID,
        withdraw_coin_amount: u64,
        excess_redeem_coin_amount: u64,
        new_total_deposit_share: u128,
        new_total_debt_share: u128,
        new_total_lend_share: u128,
        new_total_lend_amount: u64,
        new_total_debt_amount: u64,
        new_total_deposit_amount: u64,
    }

    struct CompoundBorrowRewardStartEvent has copy, drop {
        caller: address,
        farm_id: 0x2::object::ID,
        reward_coin: 0x1::type_name::TypeName,
        reward_amount: u64,
    }

    struct CompoundBorrowRewardEndEvent has copy, drop {
        caller: address,
        farm_id: 0x2::object::ID,
        repay_coin: 0x1::type_name::TypeName,
        repay_amount: u64,
    }

    struct FlashSwapEvent has copy, drop {
        caller: address,
        farm_id: 0x2::object::ID,
        debt_coin_type: 0x1::type_name::TypeName,
        deposit_coin_type: 0x1::type_name::TypeName,
        flash_swap_borrow_amount: u64,
        flash_swap_repay_amount: u64,
    }

    struct CompoundHotPotato has drop {
        farm_id: 0x2::object::ID,
        caller: address,
    }

    struct RemovePositionEvent has copy, drop {
        caller: address,
        farm_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        debt_coin_type: 0x1::type_name::TypeName,
        deposit_coin_type: 0x1::type_name::TypeName,
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

    public(friend) fun add_farm<T0, T1>(arg0: u64, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg3: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg4: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 <= 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::global_config::max_percent(), 103);
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

    public(friend) fun add_liquidity<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: &mut 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::position::Position, arg2: 0x2::coin::Coin<T0>, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg6: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg7: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg8: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg9: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberTable, arg10: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberWhitelist, arg11: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg12: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg13: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::unstake_v2(arg6, arg7, arg8, &arg0.obligation_key, arg4, arg9, arg10, arg14, arg15);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::safe_get_collateral_amount<T0>(arg4);
        let v2 = 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::safe_mul_div(arg0.total_deposit_share, (v0 as u128), (v1 as u128));
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::deposit_collateral::deposit_collateral<T0>(arg11, arg4, arg12, arg2, arg15);
        assert!(arg0.collateral_weight < 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::global_config::max_percent(), 103);
        let v3 = 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::mul_div_u64(v0, arg0.collateral_weight, 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::global_config::max_percent());
        let v4 = 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::safe_get_debt_amount<T1>(arg4);
        let v5 = 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::safe_mul_div(arg0.total_debt_share, (v3 as u128), (v4 as u128));
        let v6 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow::borrow<T1>(arg11, arg4, &arg0.obligation_key, arg12, arg3, v3, arg13, arg14, arg15);
        let v7 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T1>(arg11, arg12, v6, arg14, arg15);
        let v8 = 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg0.scoin_balance);
        let v9 = 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::safe_mul_div(arg0.total_lend_share, (0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&v7) as u128), (v8 as u128));
        0x2::coin::put<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut arg0.scoin_balance, v7);
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::stake(arg6, arg7, arg8, &arg0.obligation_key, arg4, arg5, arg14, arg15);
        0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::position::increase_deposit_share(arg1, v2);
        0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::position::increase_debt_share(arg1, v5);
        0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::position::increase_lend_share(arg1, v9);
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
            borrow_fee               : 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::safe_get_debt_amount<T1>(arg4) - v4 + 0x2::coin::value<T1>(&v6),
            old_total_lend_amount    : v8,
            old_total_debt_amount    : v4,
            old_total_deposit_amount : v1,
            new_total_lend_amount    : 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg0.scoin_balance),
            new_total_debt_amount    : 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::safe_get_debt_amount<T1>(arg4),
            new_total_deposit_amount : 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::safe_get_collateral_amount<T0>(arg4),
        };
        0x2::event::emit<AddLiquidityEvent>(v10);
    }

    public(friend) fun compound_borrow_reward_end<T0, T1>(arg0: &Farm<T0, T1>, arg1: CompoundHotPotato, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg8: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg9: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg10: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::config::VeScaProtocolConfig, arg11: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury::VeScaTreasury, arg12: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaTable, arg13: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey, arg14: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberTable, arg15: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberWhitelist, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.farm_id == 0x2::object::id<Farm<T0, T1>>(arg0), 115);
        assert!(arg1.caller == 0x2::tx_context::sender(arg17), 116);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::repay::repay<T1>(arg5, arg3, arg6, arg2, arg16, arg17);
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::stake_with_ve_sca_v2(arg7, arg8, arg9, &arg0.obligation_key, arg3, arg4, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
        let v0 = CompoundBorrowRewardEndEvent{
            caller       : 0x2::tx_context::sender(arg17),
            farm_id      : 0x2::object::id<Farm<T0, T1>>(arg0),
            repay_coin   : 0x1::type_name::with_defining_ids<T1>(),
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
            reward_coin   : 0x1::type_name::with_defining_ids<T2>(),
            reward_amount : 0x2::coin::value<T2>(&v0),
        };
        0x2::event::emit<CompoundBorrowRewardStartEvent>(v2);
        (v0, v1)
    }

    public fun info<T0, T1>(arg0: &Farm<T0, T1>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : (u64, u128, u128, u128, u64, u64, u64, u64, u64) {
        let v0 = 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg0.scoin_balance);
        (arg0.collateral_weight, arg0.total_deposit_share, arg0.total_debt_share, arg0.total_lend_share, 0x2::bag::length(&arg0.rewards), 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::safe_get_collateral_amount<T0>(arg1), 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::safe_get_debt_amount<T1>(arg1), v0, 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::compute_underlying_amount<T1>(arg2, v0))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::global_config::new(3000, 500, @0x5b3587896d2340e5741424d891a61dc4ce7e18e3c48a10b5ca78eabccb2769f5, 9000, arg0);
    }

    public(friend) fun open_position<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg5: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg6: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg7: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg8: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberTable, arg9: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberWhitelist, arg10: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg11: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg12: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::position::Position {
        let v0 = 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::position::new(0x2::object::id<Farm<T0, T1>>(arg0), 0, 0, 0, arg14);
        let v1 = &mut v0;
        add_liquidity<T0, T1>(arg0, v1, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        v0
    }

    public(friend) fun redeem_borrow_incentive_rewards_internal<T0, T1, T2>(arg0: &Farm<T0, T1>, arg1: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg2: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg3: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::redeem_rewards<T2>(arg1, arg2, arg3, &arg0.obligation_key, arg4, arg5, arg6)
    }

    public(friend) fun remove_liquidity_flashswap<T0, T1, T2, T3>(arg0: &mut Farm<T0, T1>, arg1: u128, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: u128, arg5: &mut 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::position::Position, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg8: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg9: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg10: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg11: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg12: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg13: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg14: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg15: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberTable, arg16: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberWhitelist, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2, v3) = remove_liquidity_internal_start<T0, T1>(arg0, arg5, arg1, arg9, arg6);
        if (v1 > v3) {
            let v6 = 0x1::type_name::with_defining_ids<T2>() == 0x1::type_name::with_defining_ids<T0>();
            let v7 = v1 - v3;
            let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg2, arg3, v6, false, v7, arg4, arg17);
            let v11 = v10;
            let v12 = v9;
            let v13 = v8;
            let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v11);
            let v15 = FlashSwapEvent{
                caller                   : 0x2::tx_context::sender(arg18),
                farm_id                  : 0x2::object::id<Farm<T0, T1>>(arg0),
                debt_coin_type           : 0x1::type_name::with_defining_ids<T1>(),
                deposit_coin_type        : 0x1::type_name::with_defining_ids<T0>(),
                flash_swap_borrow_amount : v7,
                flash_swap_repay_amount  : v14,
            };
            0x2::event::emit<FlashSwapEvent>(v15);
            if (v6) {
                let v16 = 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::change_coin_type<T3, T1>(0x2::coin::from_balance<T3>(v12, arg18), arg18);
                let (v17, v18) = remove_liquidity_internal_end<T0, T1>(arg0, v0, v1, v2, v3, v16, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
                let v19 = v18;
                let v20 = v17;
                assert!(0x2::coin::value<T1>(&v19) == 0, 123);
                0x2::balance::join<T2>(&mut v13, 0x2::coin::into_balance<T2>(0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::change_coin_type<T0, T2>(0x2::coin::split<T0>(&mut v20, v14, arg18), arg18)));
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg2, arg3, v13, 0x2::balance::zero<T3>(), v11);
                (v20, v19)
            } else {
                let v21 = 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::change_coin_type<T2, T1>(0x2::coin::from_balance<T2>(v13, arg18), arg18);
                let (v22, v23) = remove_liquidity_internal_end<T0, T1>(arg0, v0, v1, v2, v3, v21, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
                let v24 = v23;
                let v25 = v22;
                assert!(0x2::coin::value<T1>(&v24) == 0, 123);
                0x2::balance::join<T3>(&mut v12, 0x2::coin::into_balance<T3>(0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::change_coin_type<T0, T3>(0x2::coin::split<T0>(&mut v25, v14, arg18), arg18)));
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg2, arg3, 0x2::balance::zero<T2>(), v12, v11);
                (v25, v24)
            }
        } else {
            let v26 = 0x2::coin::zero<T1>(arg18);
            remove_liquidity_internal_end<T0, T1>(arg0, v0, v1, v2, v3, v26, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18)
        }
    }

    public(friend) fun remove_liquidity_internal_end<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg8: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg9: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg10: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg11: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg12: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg13: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg14: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg15: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberTable, arg16: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberWhitelist, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T1>(arg8, arg9, 0x2::coin::take<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut arg0.scoin_balance, arg3, arg18), arg17, arg18);
        let v1 = 0x2::coin::value<T1>(&v0);
        assert!(v1 == arg4, 124);
        let (v2, v3) = if (v1 >= arg2) {
            assert!(0x2::coin::value<T1>(&arg5) == 0, 121);
            (0x2::coin::split<T1>(&mut v0, arg2, arg18), v0)
        } else {
            assert!(0x2::coin::value<T1>(&arg5) == arg2 - v1, 122);
            (v0, 0x2::coin::zero<T1>(arg18))
        };
        let v4 = v3;
        let v5 = v2;
        0x2::coin::join<T1>(&mut v5, arg5);
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::unstake_v2(arg12, arg13, arg14, &arg0.obligation_key, arg6, arg15, arg16, arg17, arg18);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::repay::repay<T1>(arg8, arg6, arg9, v5, arg17, arg18);
        let v6 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::withdraw_collateral::withdraw_collateral<T0>(arg8, arg6, &arg0.obligation_key, arg9, arg10, arg1, arg11, arg17, arg18);
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::stake(arg12, arg13, arg14, &arg0.obligation_key, arg6, arg7, arg17, arg18);
        let v7 = RemoveLiquidityInternalEndEvent{
            farm_id                   : 0x2::object::id<Farm<T0, T1>>(arg0),
            withdraw_coin_amount      : 0x2::coin::value<T0>(&v6),
            excess_redeem_coin_amount : 0x2::coin::value<T1>(&v4),
            new_total_deposit_share   : arg0.total_deposit_share,
            new_total_debt_share      : arg0.total_debt_share,
            new_total_lend_share      : arg0.total_lend_share,
            new_total_lend_amount     : 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg0.scoin_balance),
            new_total_debt_amount     : 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::safe_get_debt_amount<T1>(arg6),
            new_total_deposit_amount  : 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::safe_get_collateral_amount<T0>(arg6),
        };
        0x2::event::emit<RemoveLiquidityInternalEndEvent>(v7);
        (v6, v4)
    }

    fun remove_liquidity_internal_start<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: &mut 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::position::Position, arg2: u128, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) : (u64, u64, u64, u64) {
        let (_, v1, v2, v3) = 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::position::info(arg1);
        assert!(v1 >= arg2, 109);
        let v4 = 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::mul_div(v2, arg2, v1);
        let v5 = 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::mul_div(v3, arg2, v1);
        let v6 = 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::safe_get_collateral_amount<T0>(arg4);
        let v7 = 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::to_u64(0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::mul_div((v6 as u128), arg2, arg0.total_deposit_share));
        let v8 = 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::safe_get_debt_amount<T1>(arg4);
        let v9 = 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::to_u64(0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::mul_div((v8 as u128), v4, arg0.total_debt_share));
        let v10 = 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg0.scoin_balance);
        let v11 = 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::to_u64(0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::mul_div((v10 as u128), v5, arg0.total_lend_share));
        0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::position::decrease_deposit_share(arg1, arg2);
        0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::position::decrease_debt_share(arg1, v4);
        0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::position::decrease_lend_share(arg1, v5);
        arg0.total_deposit_share = arg0.total_deposit_share - arg2;
        arg0.total_debt_share = arg0.total_debt_share - v4;
        arg0.total_lend_share = arg0.total_lend_share - v5;
        let v12 = RemoveLiquidityInternalStartEvent{
            position_id              : 0x2::object::id<0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::position::Position>(arg1),
            remove_deposit_share     : arg2,
            remove_debt_share        : v4,
            remove_lend_share        : v5,
            remove_debt_amount       : v9,
            remove_lend_amount       : v11,
            remove_deposit_amount    : v7,
            old_total_deposit_share  : arg0.total_deposit_share,
            old_total_debt_share     : arg0.total_debt_share,
            old_total_lend_share     : arg0.total_lend_share,
            old_total_deposit_amount : v6,
            old_total_debt_amount    : v8,
            old_total_lend_amount    : v10,
        };
        0x2::event::emit<RemoveLiquidityInternalStartEvent>(v12);
        (v7, v9, v11, 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::utils::compute_underlying_amount<T1>(arg3, v11))
    }

    public(friend) fun remove_position<T0, T1>(arg0: &Farm<T0, T1>, arg1: 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::position::Position, arg2: &0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::position::info(&arg1);
        assert!(v0 == 0x2::object::id<Farm<T0, T1>>(arg0), 120);
        assert!(v1 == 0, 117);
        assert!(v2 == 0, 118);
        assert!(v3 == 0, 119);
        let v4 = RemovePositionEvent{
            caller            : 0x2::tx_context::sender(arg2),
            farm_id           : 0x2::object::id<Farm<T0, T1>>(arg0),
            position_id       : 0x2::object::id<0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::position::Position>(&arg1),
            debt_coin_type    : 0x1::type_name::with_defining_ids<T1>(),
            deposit_coin_type : 0x1::type_name::with_defining_ids<T0>(),
        };
        0x2::event::emit<RemovePositionEvent>(v4);
        0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::position::destroy(arg1);
    }

    public(friend) fun set_collateral_weight<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: u64) {
        assert!(arg1 <= 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::global_config::max_percent(), 103);
        arg0.collateral_weight = arg1;
    }

    // decompiled from Move bytecode v6
}

