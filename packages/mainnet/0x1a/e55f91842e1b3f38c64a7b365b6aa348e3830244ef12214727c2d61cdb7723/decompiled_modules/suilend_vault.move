module 0x1ae55f91842e1b3f38c64a7b365b6aa348e3830244ef12214727c2d61cdb7723::suilend_vault {
    struct SuilendVault<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        reserve_array_index: u64,
        obligation_owner_cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
        deposits_open: bool,
    }

    public fun admin_claim_rewards<T0, T1, T2, T3>(arg0: &0x7182b166c2461a4eda64f06b95dd69326bc9001656cc413b255eaa845ada8767::admin::AdminCap, arg1: &SuilendVault<T0, T1, T3>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: bool, arg6: &0x1ae55f91842e1b3f38c64a7b365b6aa348e3830244ef12214727c2d61cdb7723::version::Version, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x1ae55f91842e1b3f38c64a7b365b6aa348e3830244ef12214727c2d61cdb7723::version::assert_current_version(arg6);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T0, T2>(arg2, &arg1.obligation_owner_cap, arg3, arg1.reserve_array_index, arg4, arg5, arg7);
        0x1ae55f91842e1b3f38c64a7b365b6aa348e3830244ef12214727c2d61cdb7723::events::suilend_vault_rewards_claimed<T2>(0x2::object::id_address<SuilendVault<T0, T1, T3>>(arg1), 0x2::coin::value<T2>(&v0));
        v0
    }

    public fun admin_deposit<T0, T1, T2>(arg0: &0x7182b166c2461a4eda64f06b95dd69326bc9001656cc413b255eaa845ada8767::admin::AdminCap, arg1: &SuilendVault<T0, T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x32a12fb00a2ca9e72e6ff7b9b87f30eed20df034691fe8c850d0542a2d885d7b::session_flow::SessionFlow<T1, T2>, arg5: &0x1ae55f91842e1b3f38c64a7b365b6aa348e3830244ef12214727c2d61cdb7723::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x1ae55f91842e1b3f38c64a7b365b6aa348e3830244ef12214727c2d61cdb7723::version::assert_current_version(arg5);
        assert!(0x32a12fb00a2ca9e72e6ff7b9b87f30eed20df034691fe8c850d0542a2d885d7b::session_flow::is_move<T1, T2>(arg4), 9223372500711374851);
        assert!(0x32a12fb00a2ca9e72e6ff7b9b87f30eed20df034691fe8c850d0542a2d885d7b::session_flow::can_consoom<T1, T2>(arg4), 9223372505006473221);
        assert!(arg1.deposits_open, 9223372509301178369);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg2, arg1.reserve_array_index, &arg1.obligation_owner_cap, arg6, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg2, arg1.reserve_array_index, arg6, arg3, arg7), arg7);
        0x1ae55f91842e1b3f38c64a7b365b6aa348e3830244ef12214727c2d61cdb7723::events::suilend_vault_deposit(0x2::object::id_address<SuilendVault<T0, T1, T2>>(arg1), 0x2::coin::value<T1>(&arg3));
        0x32a12fb00a2ca9e72e6ff7b9b87f30eed20df034691fe8c850d0542a2d885d7b::session_flow::allow_consoom<T1, T2>(&arg1.id, arg4);
    }

    public fun create_vault<T0, T1, T2>(arg0: &0x7182b166c2461a4eda64f06b95dd69326bc9001656cc413b255eaa845ada8767::admin::AdminCap, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendVault<T0, T1, T2>{
            id                   : 0x2::object::new(arg3),
            reserve_array_index  : arg2,
            obligation_owner_cap : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg1, arg3),
            deposits_open        : true,
        };
        0x1ae55f91842e1b3f38c64a7b365b6aa348e3830244ef12214727c2d61cdb7723::events::suilend_vault_created<T1, T2>(0x2::object::id_address<SuilendVault<T0, T1, T2>>(&v0));
        0x2::transfer::share_object<SuilendVault<T0, T1, T2>>(v0);
    }

    public fun deposits_open<T0, T1, T2>(arg0: &SuilendVault<T0, T1, T2>) : bool {
        arg0.deposits_open
    }

    public fun estimate_ctokens_for_withdrawal<T0, T1>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64) : u64 {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg0))))
    }

    public(friend) fun id<T0, T1, T2>(arg0: &mut SuilendVault<T0, T1, T2>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun obligation_owner_cap_id<T0, T1, T2>(arg0: &SuilendVault<T0, T1, T2>) : 0x2::object::ID {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.obligation_owner_cap)
    }

    public fun public_deposit<T0, T1, T2>(arg0: &SuilendVault<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: bool, arg4: &0x1ae55f91842e1b3f38c64a7b365b6aa348e3830244ef12214727c2d61cdb7723::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x32a12fb00a2ca9e72e6ff7b9b87f30eed20df034691fe8c850d0542a2d885d7b::session_flow::SessionFlow<T1, T2> {
        0x1ae55f91842e1b3f38c64a7b365b6aa348e3830244ef12214727c2d61cdb7723::version::assert_current_version(arg4);
        assert!(arg0.deposits_open, 9223372294552813569);
        let v0 = 0x2::coin::value<T1>(&arg1);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg2, arg0.reserve_array_index, &arg0.obligation_owner_cap, arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg2, arg0.reserve_array_index, arg5, arg1, arg6), arg6);
        0x1ae55f91842e1b3f38c64a7b365b6aa348e3830244ef12214727c2d61cdb7723::events::suilend_vault_deposit(0x2::object::id_address<SuilendVault<T0, T1, T2>>(arg0), v0);
        let v1 = 0x32a12fb00a2ca9e72e6ff7b9b87f30eed20df034691fe8c850d0542a2d885d7b::session_flow::create_session<T1, T2>(&arg0.id, 0x32a12fb00a2ca9e72e6ff7b9b87f30eed20df034691fe8c850d0542a2d885d7b::session_flow::deposit_kind(), v0);
        if (arg3) {
            0x32a12fb00a2ca9e72e6ff7b9b87f30eed20df034691fe8c850d0542a2d885d7b::session_flow::allow_consoom<T1, T2>(&arg0.id, &mut v1);
        };
        v1
    }

    public fun public_withdraw<T0, T1, T2>(arg0: &SuilendVault<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0x32a12fb00a2ca9e72e6ff7b9b87f30eed20df034691fe8c850d0542a2d885d7b::session_flow::SessionFlow<T1, T2>, arg3: &0x2::clock::Clock, arg4: &0x1ae55f91842e1b3f38c64a7b365b6aa348e3830244ef12214727c2d61cdb7723::version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x1ae55f91842e1b3f38c64a7b365b6aa348e3830244ef12214727c2d61cdb7723::version::assert_current_version(arg4);
        assert!(0x32a12fb00a2ca9e72e6ff7b9b87f30eed20df034691fe8c850d0542a2d885d7b::session_flow::is_withdrawal<T1, T2>(arg2), 9223372676805033987);
        assert!(0x32a12fb00a2ca9e72e6ff7b9b87f30eed20df034691fe8c850d0542a2d885d7b::session_flow::can_consoom<T1, T2>(arg2), 9223372681100132357);
        let v0 = withdraw<T0, T1, T2>(arg0, arg1, 0x32a12fb00a2ca9e72e6ff7b9b87f30eed20df034691fe8c850d0542a2d885d7b::session_flow::value<T1, T2>(arg2), arg3, arg5);
        0x1ae55f91842e1b3f38c64a7b365b6aa348e3830244ef12214727c2d61cdb7723::events::suilend_vault_withdraw(0x2::object::id_address<SuilendVault<T0, T1, T2>>(arg0), 0x2::coin::value<T1>(&v0));
        v0
    }

    public fun reserve_array_index<T0, T1, T2>(arg0: &SuilendVault<T0, T1, T2>) : u64 {
        arg0.reserve_array_index
    }

    public fun toggle_deposits<T0, T1, T2>(arg0: &0x7182b166c2461a4eda64f06b95dd69326bc9001656cc413b255eaa845ada8767::admin::AdminCap, arg1: &mut SuilendVault<T0, T1, T2>, arg2: bool) {
        arg1.deposits_open = arg2;
    }

    public fun total_assets<T0, T1, T2>(arg0: &SuilendVault<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : u64 {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T0, T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, obligation_owner_cap_id<T0, T1, T2>(arg0)))), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg1))))
    }

    fun withdraw<T0, T1, T2>(arg0: &SuilendVault<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = estimate_ctokens_for_withdrawal<T0, T1>(arg1, arg2);
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T0, T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, obligation_owner_cap_id<T0, T1, T2>(arg0))) >= v0, 9223372917323464711);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg1, arg0.reserve_array_index, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg1, arg0.reserve_array_index, &arg0.obligation_owner_cap, arg3, v0, arg4), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg4);
        0x1ae55f91842e1b3f38c64a7b365b6aa348e3830244ef12214727c2d61cdb7723::events::suilend_vault_withdraw(0x2::object::id_address<SuilendVault<T0, T1, T2>>(arg0), 0x2::coin::value<T1>(&v1));
        v1
    }

    // decompiled from Move bytecode v6
}

