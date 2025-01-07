module 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault {
    struct VaultCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct HarvestCap has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        whitelisted_address: address,
    }

    struct Vault<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        vt_treasury_cap: 0x2::coin::TreasuryCap<T2>,
        obligation_key: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey,
        pool_id: 0x2::object::ID,
        target_leverage: u64,
        withdrawal_fees: u64,
        performance_fees: u64,
        deposits_enabled: bool,
        deposit_limit: u64,
        seed_vt: 0x2::balance::Balance<T2>,
        collected_withdrawal_fees: 0x2::balance::Balance<T0>,
        collected_performance_fees: 0x2::balance::Balance<T2>,
        slippage_up: u128,
        slippage_down: u128,
        swap_routes: 0x2::table::Table<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>,
    }

    public(friend) fun add_swap_route<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1, T2>, arg1: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>) {
        let v0 = 0x1::type_name::get<T3>();
        if (0x2::table::contains<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(&arg0.swap_routes, v0)) {
            let v1 = 0x2::table::remove<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(&mut arg0.swap_routes, v0);
            while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v1)) {
                let (_, _) = 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::unwrap(0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut v1));
            };
            0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(v1);
        };
        0x2::table::add<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(&mut arg0.swap_routes, v0, arg1);
    }

    public(friend) fun assert_deposits_enabled<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: u64) {
        assert!(arg0.deposits_enabled && 0x2::balance::value<T2>(&arg0.seed_vt) > 0 && arg1 < arg0.deposit_limit, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::error::deposits_disabled());
    }

    public(friend) fun assert_harvest_cap<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &HarvestCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1, T2>>(arg0), 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::error::invalid_harvest_cap());
        assert!(arg1.whitelisted_address == 0x2::tx_context::sender(arg2), 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::error::sender_not_whitelisted());
    }

    public(friend) fun assert_vault_cap<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &VaultCap) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1, T2>>(arg0), 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::error::invalid_vault_cap());
    }

    public fun assert_vault_obligation<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg1, &arg0.obligation_key);
    }

    public(friend) fun burn_vt<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>) {
        0x2::coin::burn<T2>(&mut arg0.vt_treasury_cap, arg1);
    }

    public(friend) fun collect_fees<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.collected_withdrawal_fees, arg1);
    }

    public(friend) fun collect_performance_fees<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<T2>) {
        0x2::balance::join<T2>(&mut arg0.collected_performance_fees, arg1);
    }

    public(friend) fun deposit<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: u64, arg8: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg9: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg11: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_vault_obligation<T0, T1, T2>(arg0, arg3);
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::unstake(arg8, arg9, arg10, &arg0.obligation_key, arg3, arg12, arg13);
        let v0 = get_adjusted_borrow_amount(arg7, *0x2::dynamic_field::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::uid(arg4), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market_dynamic_keys::borrow_fee_key(0x1::type_name::get<T1>())));
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::deposit_collateral::deposit_collateral<T0>(arg2, arg3, arg4, arg1, arg13);
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow::borrow<T1>(arg2, arg3, &arg0.obligation_key, arg4, arg5, v0 + v0 / 10000, arg6, arg12, arg13);
        if (0x2::coin::value<T1>(&v1) > arg7) {
            0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::repay::repay<T1>(arg2, arg3, arg4, 0x2::coin::split<T1>(&mut v1, 0x2::coin::value<T1>(&v1) - arg7, arg13), arg12, arg13);
        };
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::stake(arg8, arg9, arg10, &arg0.obligation_key, arg3, arg11, arg12, arg13);
        v1
    }

    public fun fee_scaling() : u64 {
        1000000
    }

    fun get_adjusted_borrow_amount(arg0: u64, arg1: 0x1::fixed_point32::FixedPoint32) : u64 {
        let v0 = 1000000000000;
        (((arg0 as u256) * (v0 as u256) / ((v0 as u256) - (0x1::fixed_point32::multiply_u64(v0, arg1) as u256))) as u64) + 1
    }

    public fun get_swap_route<T0, T1, T2, T3>(arg0: &Vault<T0, T1, T2>) : vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value> {
        *0x2::table::borrow<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(&arg0.swap_routes, 0x1::type_name::get<T3>())
    }

    public fun harvest_cap_vault_id(arg0: &HarvestCap) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun info<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) : (u64, u64) {
        assert_vault_obligation<T0, T1, T2>(arg0, arg1);
        let v0 = if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::has_coin_x_as_collateral(arg1, 0x1::type_name::get<T0>())) {
            0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral(arg1, 0x1::type_name::get<T0>())
        } else {
            0
        };
        let v1 = if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::has_coin_x_as_debt(arg1, 0x1::type_name::get<T1>())) {
            let (v2, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg1, 0x1::type_name::get<T1>());
            v2
        } else {
            0
        };
        (v0, v1)
    }

    public(friend) fun initialize<T0, T1, T2>(arg0: 0x2::coin::TreasuryCap<T2>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg9: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg11: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg12: &0x2::clock::Clock, arg13: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg14: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1, v2) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::open_obligation(arg13, arg14);
        let v3 = v1;
        let v4 = v0;
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::stake(arg8, arg9, arg10, &v3, &mut v4, arg11, arg12, arg14);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::return_obligation(arg13, v4, v2);
        let v5 = Vault<T0, T1, T2>{
            id                         : 0x2::object::new(arg14),
            vt_treasury_cap            : arg0,
            obligation_key             : v3,
            pool_id                    : arg1,
            target_leverage            : arg2,
            withdrawal_fees            : arg3,
            performance_fees           : arg4,
            deposits_enabled           : false,
            deposit_limit              : arg5,
            seed_vt                    : 0x2::balance::zero<T2>(),
            collected_withdrawal_fees  : 0x2::balance::zero<T0>(),
            collected_performance_fees : 0x2::balance::zero<T2>(),
            slippage_up                : arg6,
            slippage_down              : arg7,
            swap_routes                : 0x2::table::new<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(arg14),
        };
        let v6 = 0x2::object::id<Vault<T0, T1, T2>>(&v5);
        let v7 = VaultCap{
            id       : 0x2::object::new(arg14),
            vault_id : v6,
        };
        let v8 = HarvestCap{
            id                  : 0x2::object::new(arg14),
            vault_id            : v6,
            whitelisted_address : 0x2::tx_context::sender(arg14),
        };
        0x2::transfer::share_object<Vault<T0, T1, T2>>(v5);
        0x2::transfer::share_object<HarvestCap>(v8);
        0x2::transfer::transfer<VaultCap>(v7, 0x2::tx_context::sender(arg14));
        v6
    }

    public fun leverage<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        arg0.target_leverage
    }

    public fun leverage_scaling() : u64 {
        1000000
    }

    public(friend) fun mint_vt<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x2::coin::mint<T2>(&mut arg0.vt_treasury_cap, arg1, arg2)
    }

    public(friend) fun obligation_key<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey {
        &arg0.obligation_key
    }

    public(friend) fun obligation_key_mut<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) : &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey {
        &mut arg0.obligation_key
    }

    public fun performance_fees<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : (u64, u64) {
        (arg0.performance_fees, 1000000)
    }

    public fun pool_id<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : 0x2::object::ID {
        arg0.pool_id
    }

    public(friend) fun seed<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<T2>) {
        0x2::balance::join<T2>(&mut arg0.seed_vt, arg1);
    }

    public(friend) fun set_deposit_limit<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64) {
        arg0.deposit_limit = arg1;
    }

    public(friend) fun set_deposits_enabled<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: bool) {
        arg0.deposits_enabled = arg1;
    }

    public(friend) fun set_harvest_whitelisted_address(arg0: &mut HarvestCap, arg1: address) {
        arg0.whitelisted_address = arg1;
    }

    public(friend) fun set_slippage<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u128, arg2: u128) {
        arg0.slippage_up = arg1;
        arg0.slippage_down = arg2;
    }

    public fun slippage<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : (u128, u128) {
        (arg0.slippage_up, arg0.slippage_down)
    }

    public fun total_vt_supply<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0x2::coin::total_supply<T2>(&arg0.vt_treasury_cap)
    }

    public(friend) fun update_leverage<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64) {
        arg0.target_leverage = arg1;
    }

    public(friend) fun update_performance_fees<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64) {
        arg0.performance_fees = arg1;
    }

    public(friend) fun update_withdrawal_fees<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64) {
        arg0.withdrawal_fees = arg1;
    }

    public(friend) fun withdraw<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg9: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg11: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_vault_obligation<T0, T1, T2>(arg0, arg4);
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::unstake(arg8, arg9, arg10, &arg0.obligation_key, arg4, arg12, arg13);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::repay::repay<T1>(arg3, arg4, arg5, arg1, arg12, arg13);
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::stake(arg8, arg9, arg10, &arg0.obligation_key, arg4, arg11, arg12, arg13);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::withdraw_collateral::withdraw_collateral<T0>(arg3, arg4, &arg0.obligation_key, arg5, arg6, arg2, arg7, arg12, arg13)
    }

    public(friend) fun withdraw_performance_fees<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64) : 0x2::balance::Balance<T2> {
        0x2::balance::split<T2>(&mut arg0.collected_performance_fees, arg1)
    }

    public(friend) fun withdraw_withdrawal_fees<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.collected_withdrawal_fees, arg1)
    }

    public fun withdrawal_fees<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : (u64, u64) {
        (arg0.withdrawal_fees, 1000000)
    }

    // decompiled from Move bytecode v6
}

