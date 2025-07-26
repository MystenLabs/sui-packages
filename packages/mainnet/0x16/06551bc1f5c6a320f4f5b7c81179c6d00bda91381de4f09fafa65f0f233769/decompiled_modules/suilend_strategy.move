module 0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::suilend_strategy {
    struct SuiLendStrategy<phantom T0> has store, key {
        id: 0x2::object::UID,
        manager_access: 0x1::option::Option<0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::ManagerAccess>,
        suilend_obl_cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
        admin_id: 0x2::object::ID,
        version: u64,
    }

    fun assert_current_version<T0>(arg0: &SuiLendStrategy<T0>) {
        assert!(arg0.version == 1, 13906835295330172934);
    }

    public fun deposit_to_suilend<T0, T1>(arg0: 0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::DepositRequest<T0>, arg1: &SuiLendStrategy<T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_current_version<T1>(arg1);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T1, T0>(arg2, arg3, &arg1.suilend_obl_cap, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T1, T0>(arg2, arg3, arg4, 0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::consume_deposit_request<T0>(arg0), arg5), arg5);
    }

    public fun init_strategy<T0>(arg0: &0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::AllocatorCap, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SuiLendStrategy<T0>{
            id              : 0x2::object::new(arg2),
            manager_access  : 0x1::option::none<0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::ManagerAccess>(),
            suilend_obl_cap : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg1, arg2),
            admin_id        : 0x2::object::id<0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::AllocatorCap>(arg0),
            version         : 1,
        };
        0x2::transfer::share_object<SuiLendStrategy<T0>>(v0);
    }

    entry fun join_manager<T0>(arg0: &0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::AllocatorCap, arg1: &mut 0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::StrategyManager, arg2: &mut SuiLendStrategy<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_current_version<T0>(arg2);
        0x1::option::fill<0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::ManagerAccess>(&mut arg2.manager_access, 0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::add_strategy(arg0, arg1, arg3));
    }

    entry fun migrate<T0>(arg0: &mut SuiLendStrategy<T0>, arg1: &0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::AllocatorCap) {
        assert!(arg0.admin_id == 0x2::object::id<0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::AllocatorCap>(arg1), 13906835321099845636);
        assert!(arg0.version < 1, 13906835325394681858);
        arg0.version = 1;
    }

    public fun remove_from_manager<T0>(arg0: &0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::AllocatorCap, arg1: &mut SuiLendStrategy<T0>) : 0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::StrategyRemovalTicket {
        0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::new_strategy_removal_ticket(0x1::option::extract<0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::ManagerAccess>(&mut arg1.manager_access))
    }

    public fun update_suilend_supplied<T0>(arg0: &SuiLendStrategy<T0>, arg1: &mut 0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::StrategyManager, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &vector<u64>, arg4: &0x2::clock::Clock) {
        assert_current_version<T0>(arg0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg3)) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::compound_interest<T0>(arg2, *0x1::vector::borrow<u64>(arg3, v0), arg4);
            v0 = v0 + 1;
        };
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposits<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.suilend_obl_cap)));
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v1)) {
            let v4 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v1, v3);
            v2 = v2 + 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_deposited_ctoken_amount(v4)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg2), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_reserve_array_index(v4)))));
            v3 = v3 + 1;
        };
        0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::update_strategy_supplied(arg1, 0x1::option::borrow<0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::ManagerAccess>(&arg0.manager_access), v2);
    }

    public fun withdraw_from_suilend<T0, T1>(arg0: 0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::WithdrawalRequest<T0>, arg1: &SuiLendStrategy<T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_current_version<T1>(arg1);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::compound_interest<T1>(arg2, arg3, arg4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T1, T0>(arg2, arg3, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T1, T0>(arg2, arg3, &arg1.suilend_obl_cap, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::consume_withdrawal_request<T0>(arg0)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T1>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T1>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T1>(arg2), arg3)))), arg5), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T1, T0>>(), arg5)
    }

    // decompiled from Move bytecode v6
}

