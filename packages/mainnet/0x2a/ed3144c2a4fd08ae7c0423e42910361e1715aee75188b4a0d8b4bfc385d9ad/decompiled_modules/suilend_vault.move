module 0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::suilend_vault {
    struct Vault<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T1>,
        obligation_owner_cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T2>,
        deposit_asset_index: u64,
        withdrawal_fees: u64,
        performance_fees: u64,
        deposits_enabled: bool,
        deposit_limit: u64,
        seed_vt: 0x2::balance::Balance<T1>,
        collected_withdrawal_fees: 0x2::balance::Balance<T0>,
        collected_performance_fees: 0x2::balance::Balance<T0>,
        swap_routes: 0x2::table::Table<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>,
    }

    public(friend) fun new<T0, T1, T2>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::coin::TreasuryCap<T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: u8, arg8: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = Vault<T0, T1, T2>{
            id                         : 0x2::object::new(arg10),
            treasury_cap               : arg1,
            obligation_owner_cap       : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T2>(arg8, arg10),
            deposit_asset_index        : arg2,
            withdrawal_fees            : arg3,
            performance_fees           : arg4,
            deposits_enabled           : true,
            deposit_limit              : arg5,
            seed_vt                    : 0x2::balance::zero<T1>(),
            collected_withdrawal_fees  : 0x2::balance::zero<T0>(),
            collected_performance_fees : 0x2::balance::zero<T0>(),
            swap_routes                : 0x2::table::new<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(arg10),
        };
        deposit<T0, T1, T2>(&v0, arg0, arg8, arg9, arg10);
        let v1 = &mut v0;
        0x2::balance::join<T1>(&mut v0.seed_vt, 0x2::coin::into_balance<T1>(mint_vt<T0, T1, T2>(v1, 0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::utils::safe_mul_div(0x2::balance::value<T0>(&arg0), 0x1::u64::pow(10, arg7), 0x1::u64::pow(10, arg6)), arg10)));
        0x2::transfer::share_object<Vault<T0, T1, T2>>(v0);
        0x2::object::id<Vault<T0, T1, T2>>(&v0)
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
        assert!(arg0.deposits_enabled && arg1 < arg0.deposit_limit, 0);
    }

    public(friend) fun burn_vt<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>) {
        0x2::coin::burn<T1>(&mut arg0.treasury_cap, arg1);
    }

    public(friend) fun claim_cranked_rewards<T0, T1, T2, T3>(arg0: &Vault<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        assert!(0x1::type_name::get<T3>() != 0x1::type_name::get<T1>(), 0);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T2, T3>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T2>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T2>(&arg0.obligation_owner_cap)));
        if (v0 == 0) {
            return 0x2::balance::zero<T3>()
        };
        0x2::coin::into_balance<T3>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T2, T3>(arg1, arg2, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T2, T3>(arg1, arg2, &arg0.obligation_owner_cap, arg3, v0, arg4), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T2, T3>>(), arg4))
    }

    public(friend) fun claim_rewards<T0, T1, T2, T3>(arg0: &Vault<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0x2::coin::into_balance<T3>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T2, T3>(arg1, &arg0.obligation_owner_cap, arg3, arg0.deposit_asset_index, arg2, true, arg4))
    }

    public(friend) fun collect_performance_fees<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.collected_performance_fees, arg1);
    }

    public(friend) fun collect_withdrawal_fees<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.collected_withdrawal_fees, arg1);
    }

    public(friend) fun deposit<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T2, T0>(arg2, arg0.deposit_asset_index, arg3, 0x2::coin::from_balance<T0>(arg1, arg4), arg4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T2, T0>(arg2, arg0.deposit_asset_index, &arg0.obligation_owner_cap, arg3, v0, arg4);
        0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T2, T0>>(&v0)
    }

    public fun deposit_asset_index<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        arg0.deposit_asset_index
    }

    public fun deposited<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>) : u64 {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_market_value<T2>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T2, T0>(arg1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T2, T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T2>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T2>(&arg0.obligation_owner_cap)))))
    }

    public fun deposited_ctoken_amount<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>) : u64 {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T2, T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T2>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T2>(&arg0.obligation_owner_cap)))
    }

    public fun fee_scaling() : u64 {
        1000000
    }

    public fun get_swap_route<T0, T1, T2, T3>(arg0: &Vault<T0, T1, T2>) : vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value> {
        *0x2::table::borrow<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(&arg0.swap_routes, 0x1::type_name::get<T3>())
    }

    public(friend) fun mint_vt<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::mint<T1>(&mut arg0.treasury_cap, arg1, arg2)
    }

    public(friend) fun obligation_owner_cap<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T2> {
        &arg0.obligation_owner_cap
    }

    public fun performance_fees<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : (u64, u64) {
        (arg0.performance_fees, 1000000)
    }

    public(friend) fun remove_swap_route<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1, T2>) {
        let v0 = 0x1::type_name::get<T3>();
        if (0x2::table::contains<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(&arg0.swap_routes, v0)) {
            let v1 = 0x2::table::remove<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(&mut arg0.swap_routes, v0);
            while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v1)) {
                let (_, _) = 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::unwrap(0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut v1));
            };
            0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(v1);
        };
    }

    public(friend) fun set_deposit_limit<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64) {
        arg0.deposit_limit = arg1;
    }

    public(friend) fun set_deposits_enabled<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: bool) {
        arg0.deposits_enabled = arg1;
    }

    public(friend) fun set_performance_fees<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64) {
        arg0.performance_fees = arg1;
    }

    public(friend) fun set_withdrawal_fees<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64) {
        arg0.withdrawal_fees = arg1;
    }

    public fun total_vt_supply<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0x2::coin::total_supply<T1>(&arg0.treasury_cap)
    }

    public(friend) fun withdraw<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: u64, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T2, T0>(arg2, arg0.deposit_asset_index, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T2, T0>(arg2, arg0.deposit_asset_index, &arg0.obligation_owner_cap, arg3, arg1, arg4), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T2, T0>>(), arg4))
    }

    public(friend) fun withdraw_performance_fees<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.collected_performance_fees, arg1)
    }

    public(friend) fun withdraw_withdrawal_fees<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.collected_withdrawal_fees, arg1)
    }

    public fun withdrawal_fees<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : (u64, u64) {
        (arg0.withdrawal_fees, 1000000)
    }

    // decompiled from Move bytecode v6
}

