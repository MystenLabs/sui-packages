module 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config {
    struct SuilendConfig<phantom T0, phantom T1, phantom T2> has store {
        obligation_owner_cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T2>,
        deposit_asset_index: u64,
        borrow_asset_index: u64,
        extra_info: 0x2::bag::Bag,
    }

    public(friend) fun borrow<T0, T1, T2>(arg0: &SuilendConfig<T0, T1, T2>, arg1: u64, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow<T2, T1>(arg2, arg0.borrow_asset_index, &arg0.obligation_owner_cap, arg3, arg1, arg4))
    }

    public(friend) fun new<T0, T1, T2>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : SuilendConfig<T0, T1, T2> {
        SuilendConfig<T0, T1, T2>{
            obligation_owner_cap : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T2>(arg0, arg3),
            deposit_asset_index  : arg1,
            borrow_asset_index   : arg2,
            extra_info           : 0x2::bag::new(arg3),
        }
    }

    public(friend) fun add_extra_info<T0, T1, T2, T3: copy + drop + store, T4: store>(arg0: &mut SuilendConfig<T0, T1, T2>, arg1: T3, arg2: T4) {
        0x2::bag::add<T3, T4>(&mut arg0.extra_info, arg1, arg2);
    }

    public fun borrow_asset_index<T0, T1, T2>(arg0: &SuilendConfig<T0, T1, T2>) : u64 {
        arg0.borrow_asset_index
    }

    public fun borrowed<T0, T1, T2>(arg0: &SuilendConfig<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>) : u64 {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrowed_amount<T2, T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T2>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T2>(&arg0.obligation_owner_cap))))
    }

    public(friend) fun claim_cranked_rewards<T0, T1, T2, T3>(arg0: &SuilendConfig<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        assert!(0x1::type_name::get<T3>() != 0x1::type_name::get<T0>(), 0);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T2, T3>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T2>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T2>(&arg0.obligation_owner_cap)));
        if (v0 == 0) {
            return 0x2::balance::zero<T3>()
        };
        0x2::coin::into_balance<T3>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T2, T3>(arg1, arg2, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T2, T3>(arg1, arg2, &arg0.obligation_owner_cap, arg3, v0, arg4), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T2, T3>>(), arg4))
    }

    public(friend) fun claim_rewards<T0, T1, T2, T3>(arg0: &SuilendConfig<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        let v0 = if (arg2) {
            arg0.deposit_asset_index
        } else {
            arg0.borrow_asset_index
        };
        0x2::coin::into_balance<T3>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T2, T3>(arg1, &arg0.obligation_owner_cap, arg4, v0, arg3, arg2, arg5))
    }

    public(friend) fun deposit<T0, T1, T2>(arg0: &SuilendConfig<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T2, T0>(arg2, arg0.deposit_asset_index, arg3, 0x2::coin::from_balance<T0>(arg1, arg4), arg4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T2, T0>(arg2, arg0.deposit_asset_index, &arg0.obligation_owner_cap, arg3, v0, arg4);
        0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T2, T0>>(&v0)
    }

    public fun deposit_asset_index<T0, T1, T2>(arg0: &SuilendConfig<T0, T1, T2>) : u64 {
        arg0.deposit_asset_index
    }

    public fun deposited<T0, T1, T2>(arg0: &SuilendConfig<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>) : u64 {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T2, T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T2>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T2>(&arg0.obligation_owner_cap)))), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T2>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T2, T0>(arg1))))
    }

    public fun deposited_ctoken_amount<T0, T1, T2>(arg0: &SuilendConfig<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>) : u64 {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T2, T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T2>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T2>(&arg0.obligation_owner_cap)))
    }

    public(friend) fun extra_info_exists<T0, T1, T2, T3: copy + drop + store>(arg0: &SuilendConfig<T0, T1, T2>, arg1: T3) : bool {
        0x2::bag::contains<T3>(&arg0.extra_info, arg1)
    }

    public(friend) fun get_extra_info<T0, T1, T2, T3: copy + drop + store, T4: store>(arg0: &SuilendConfig<T0, T1, T2>, arg1: T3) : &T4 {
        0x2::bag::borrow<T3, T4>(&arg0.extra_info, arg1)
    }

    public fun obligation_id<T0, T1, T2>(arg0: &SuilendConfig<T0, T1, T2>) : 0x2::object::ID {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T2>(&arg0.obligation_owner_cap)
    }

    public(friend) fun obligation_owner_cap<T0, T1, T2>(arg0: &SuilendConfig<T0, T1, T2>) : &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T2> {
        &arg0.obligation_owner_cap
    }

    public(friend) fun remove_extra_info<T0, T1, T2, T3: copy + drop + store, T4: store>(arg0: &mut SuilendConfig<T0, T1, T2>, arg1: T3) : T4 {
        0x2::bag::remove<T3, T4>(&mut arg0.extra_info, arg1)
    }

    public(friend) fun repay<T0, T1, T2>(arg0: &SuilendConfig<T0, T1, T2>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T1>(arg1, arg4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::repay<T2, T1>(arg2, arg0.borrow_asset_index, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T2>(&arg0.obligation_owner_cap), arg3, &mut v0, arg4);
        0x2::coin::destroy_zero<T1>(v0);
    }

    public(friend) fun withdraw<T0, T1, T2>(arg0: &SuilendConfig<T0, T1, T2>, arg1: u64, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T2, T0>(arg2, arg0.deposit_asset_index, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T2, T0>(arg2, arg0.deposit_asset_index, &arg0.obligation_owner_cap, arg3, arg1, arg4), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T2, T0>>(), arg4))
    }

    // decompiled from Move bytecode v6
}

