module 0x5ea383c8eeec29f260297834bc4dca2e83d8726b682d6fe884f795ccafab6007::vault {
    struct VaultCap has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct Vault<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        vt_treasury_cap: 0x2::coin::TreasuryCap<T2>,
        obligation_key: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey,
        pool_id: 0x2::object::ID,
        leverage: u64,
        withdrawal_fees: u64,
        slippage_up: u128,
        slippage_down: u128,
        collected_fees: 0x2::balance::Balance<T0>,
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

    public(friend) fun assert_vault_cap<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &VaultCap) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1, T2>>(arg0), 0);
    }

    fun assert_vault_ownership<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg1, &arg0.obligation_key);
    }

    public(friend) fun burn_vt<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>) {
        0x2::coin::burn<T2>(&mut arg0.vt_treasury_cap, arg1);
    }

    public(friend) fun collect_fees<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.collected_fees, arg1);
    }

    public(friend) fun deposit<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: u64, arg8: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg9: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg11: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_vault_ownership<T0, T1, T2>(arg0, arg3);
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::unstake(arg8, arg9, arg10, &arg0.obligation_key, arg3, arg12, arg13);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::deposit_collateral::deposit_collateral<T0>(arg2, arg3, arg4, arg1, arg13);
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::stake(arg8, arg9, arg10, &arg0.obligation_key, arg3, arg11, arg12, arg13);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow::borrow<T1>(arg2, arg3, &arg0.obligation_key, arg4, arg5, get_adjusted_borrow_amount(arg7, *0x2::dynamic_field::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::uid(arg4), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market_dynamic_keys::borrow_fee_key(0x1::type_name::get<T1>()))), arg6, arg12, arg13)
    }

    public fun fee_scaling() : u64 {
        1000000
    }

    fun get_adjusted_borrow_amount(arg0: u64, arg1: 0x1::fixed_point32::FixedPoint32) : u64 {
        let v0 = 1000000000;
        (((arg0 as u256) * (v0 as u256)) as u64) / (v0 - 0x1::fixed_point32::multiply_u64(v0, arg1))
    }

    public fun get_swap_route<T0, T1, T2, T3>(arg0: &Vault<T0, T1, T2>) : vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value> {
        *0x2::table::borrow<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(&arg0.swap_routes, 0x1::type_name::get<T3>())
    }

    public fun info<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) : (u64, u64) {
        assert_vault_ownership<T0, T1, T2>(arg0, arg1);
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

    public(friend) fun initialize<T0, T1, T2>(arg0: 0x2::coin::TreasuryCap<T2>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg7: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg8: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg9: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg10: &0x2::clock::Clock, arg11: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1, v2) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::open_obligation(arg11, arg12);
        let v3 = v1;
        let v4 = v0;
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::stake(arg6, arg7, arg8, &v3, &mut v4, arg9, arg10, arg12);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::return_obligation(arg11, v4, v2);
        let v5 = Vault<T0, T1, T2>{
            id              : 0x2::object::new(arg12),
            vt_treasury_cap : arg0,
            obligation_key  : v3,
            pool_id         : arg1,
            leverage        : arg2,
            withdrawal_fees : arg3,
            slippage_up     : arg4,
            slippage_down   : arg5,
            collected_fees  : 0x2::balance::zero<T0>(),
            swap_routes     : 0x2::table::new<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(arg12),
        };
        let v6 = 0x2::object::id<Vault<T0, T1, T2>>(&v5);
        let v7 = VaultCap{
            id       : 0x2::object::new(arg12),
            vault_id : v6,
        };
        0x2::transfer::share_object<Vault<T0, T1, T2>>(v5);
        0x2::transfer::transfer<VaultCap>(v7, 0x2::tx_context::sender(arg12));
        v6
    }

    public fun leverage<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        arg0.leverage
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

    public fun pool_id<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun slippage<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : (u128, u128) {
        (arg0.slippage_up, arg0.slippage_down)
    }

    public fun slippage_scaling() : u128 {
        18446744073709551616
    }

    public fun total_vt_supply<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0x2::coin::total_supply<T2>(&arg0.vt_treasury_cap)
    }

    public(friend) fun update_withdrawal_fees<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64) {
        arg0.withdrawal_fees = arg1;
    }

    public(friend) fun withdraw<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg9: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg11: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_vault_ownership<T0, T1, T2>(arg0, arg4);
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::unstake(arg8, arg9, arg10, &arg0.obligation_key, arg4, arg12, arg13);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::repay::repay<T1>(arg3, arg4, arg5, arg1, arg12, arg13);
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::stake(arg8, arg9, arg10, &arg0.obligation_key, arg4, arg11, arg12, arg13);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::withdraw_collateral::withdraw_collateral<T0>(arg3, arg4, &arg0.obligation_key, arg5, arg6, arg2, arg7, arg12, arg13)
    }

    public(friend) fun withdraw_fees<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.collected_fees, arg1)
    }

    public fun withdrawal_fees<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : (u64, u64) {
        (arg0.withdrawal_fees, 1000000)
    }

    // decompiled from Move bytecode v6
}

