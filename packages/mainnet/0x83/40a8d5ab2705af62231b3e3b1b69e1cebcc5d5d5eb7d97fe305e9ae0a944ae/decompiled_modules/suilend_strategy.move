module 0x8340a8d5ab2705af62231b3e3b1b69e1cebcc5d5d5eb7d97fe305e9ae0a944ae::suilend_strategy {
    struct SuilendStrategy<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        admin_cap_id: 0x2::object::ID,
        vault_access: 0x1::option::Option<0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::VaultAccess>,
        obligation_cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
        lending_market_id: 0x2::object::ID,
        reserve_array_index: u64,
        underlying_nominal_value: u64,
        version: u64,
        is_active: bool,
    }

    struct StrategyAdminCap has key {
        id: 0x2::object::UID,
        strategy_id: 0x2::object::ID,
    }

    struct StrategyCreated has copy, drop {
        strategy_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        lending_market_id: 0x2::object::ID,
        reserve_index: u64,
        obligation_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct StrategyJoinedVault has copy, drop {
        strategy_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct StrategyRebalanced has copy, drop {
        strategy_id: 0x2::object::ID,
        fund_amount: u64,
        defund_amount: u64,
        new_underlying_value: u64,
        timestamp: u64,
    }

    struct PTBWithdrawalExecuted has copy, drop {
        strategy_id: 0x2::object::ID,
        requested_amount: u64,
        timestamp: u64,
    }

    struct EmergencyWithdrawExecuted has copy, drop {
        strategy_id: 0x2::object::ID,
        withdrawn_amount: u64,
        initial_underlying_value: u64,
        timestamp: u64,
    }

    struct StrategyProfitEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        profit_amount: u64,
        timestamp: u64,
    }

    fun assert_admin<T0, T1>(arg0: &StrategyAdminCap, arg1: &SuilendStrategy<T0, T1>) {
        assert!(0x2::object::id<StrategyAdminCap>(arg0) == arg1.admin_cap_id, 3);
    }

    fun assert_lending_market<T0>(arg0: 0x2::object::ID, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) {
        assert!(0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg1) == arg0, 10);
    }

    fun assert_suilend_lending_market<T0>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) {
        assert!(0x2::object::id_address<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg0) == @0x84030d26d85eaa7035084a057f2f11f701b7e2e4eda87551becbc7c97505ece1, 5);
    }

    fun assert_suilend_price_info(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        assert!(0x2::object::id_address<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg0) == @0x5dec622733a204ca27f5a90d8c2fad453cc6665186fd5dff13a83d0b6c9027ab, 6);
    }

    fun assert_vault_access<T0, T1>(arg0: &SuilendStrategy<T0, T1>) {
        assert!(0x1::option::is_some<0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::VaultAccess>(&arg0.vault_access), 8);
    }

    fun assert_version<T0, T1>(arg0: &SuilendStrategy<T0, T1>) {
        assert!(arg0.version == 1, 2);
    }

    public fun check_strategy_loss<T0, T1>(arg0: &StrategyAdminCap, arg1: &SuilendStrategy<T0, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x2::tx_context::TxContext) : (bool, u64) {
        assert_admin<T0, T1>(arg0, arg1);
        assert_version<T0, T1>(arg1);
        assert_vault_access<T0, T1>(arg1);
        assert_lending_market<T0>(arg1.lending_market_id, arg2);
        assert_suilend_lending_market<T0>(arg2);
        assert_suilend_price_info(arg4);
        let v0 = get_deposited_ctoken_amount<T0, T1>(arg1, arg2);
        if (v0 == 0 || arg1.underlying_nominal_value == 0) {
            return (false, 0)
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg2, arg1.reserve_array_index, arg3, arg4);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg2, arg1.reserve_array_index, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg2, arg1.reserve_array_index, &arg1.obligation_cap, arg3, v0, arg5), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg5);
        let v2 = 0x2::coin::value<T1>(&v1);
        let v3 = arg1.underlying_nominal_value;
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg2, arg1.reserve_array_index, arg3, arg4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg2, arg1.reserve_array_index, &arg1.obligation_cap, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg2, arg1.reserve_array_index, arg3, 0x2::coin::from_balance<T1>(0x2::coin::into_balance<T1>(v1), arg5), arg5), arg5);
        if (v2 < v3) {
            (true, v3 - v2)
        } else {
            (false, 0)
        }
    }

    public fun create_strategy<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xf92f5598caf737db94a4902f927629596a659e695406851d91982cfb55e2bc1, 1);
        assert_suilend_lending_market<T0>(arg0);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = StrategyAdminCap{
            id          : 0x2::object::new(arg2),
            strategy_id : v1,
        };
        let v3 = 0x2::object::id<StrategyAdminCap>(&v2);
        let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg0, arg2);
        let v5 = 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg0);
        let v6 = SuilendStrategy<T0, T1>{
            id                       : v0,
            admin_cap_id             : v3,
            vault_access             : 0x1::option::none<0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::VaultAccess>(),
            obligation_cap           : v4,
            lending_market_id        : v5,
            reserve_array_index      : 7,
            underlying_nominal_value : 0,
            version                  : 1,
            is_active                : true,
        };
        let v7 = StrategyCreated{
            strategy_id       : v1,
            admin_cap_id      : v3,
            lending_market_id : v5,
            reserve_index     : 7,
            obligation_id     : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&v4),
            timestamp         : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<StrategyCreated>(v7);
        0x2::transfer::share_object<SuilendStrategy<T0, T1>>(v6);
        0x2::transfer::transfer<StrategyAdminCap>(v2, 0x2::tx_context::sender(arg2));
    }

    public fun emergency_withdraw<T0, T1, T2>(arg0: &StrategyAdminCap, arg1: &mut SuilendStrategy<T0, T1>, arg2: &mut 0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::Vault<T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, arg1);
        assert_version<T0, T1>(arg1);
        assert_vault_access<T0, T1>(arg1);
        assert_lending_market<T0>(arg1.lending_market_id, arg3);
        assert_suilend_lending_market<T0>(arg3);
        assert_suilend_price_info(arg5);
        let v0 = 0x1::option::borrow<0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::VaultAccess>(&arg1.vault_access);
        if (arg1.underlying_nominal_value == 0) {
            let v1 = EmergencyWithdrawExecuted{
                strategy_id              : 0x2::object::id<SuilendStrategy<T0, T1>>(arg1),
                withdrawn_amount         : 0,
                initial_underlying_value : arg1.underlying_nominal_value,
                timestamp                : 0x2::clock::timestamp_ms(arg4),
            };
            0x2::event::emit<EmergencyWithdrawExecuted>(v1);
            return
        };
        let v2 = get_deposited_ctoken_amount<T0, T1>(arg1, arg3);
        if (v2 == 0) {
            arg1.underlying_nominal_value = 0;
            let v3 = EmergencyWithdrawExecuted{
                strategy_id              : 0x2::object::id<SuilendStrategy<T0, T1>>(arg1),
                withdrawn_amount         : 0,
                initial_underlying_value : arg1.underlying_nominal_value,
                timestamp                : 0x2::clock::timestamp_ms(arg4),
            };
            0x2::event::emit<EmergencyWithdrawExecuted>(v3);
            return
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg1.reserve_array_index, arg4, arg5);
        let v4 = 0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg3, arg1.reserve_array_index, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg3, arg1.reserve_array_index, &arg1.obligation_cap, arg4, v2, arg6), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg6));
        0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::emergency_defund_strategy<T1, T2>(arg2, v0, v4, arg4);
        arg1.underlying_nominal_value = 0;
        let v5 = EmergencyWithdrawExecuted{
            strategy_id              : 0x2::object::id<SuilendStrategy<T0, T1>>(arg1),
            withdrawn_amount         : 0x2::balance::value<T1>(&v4),
            initial_underlying_value : arg1.underlying_nominal_value,
            timestamp                : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<EmergencyWithdrawExecuted>(v5);
    }

    public fun get_admin_cap_id<T0, T1>(arg0: &SuilendStrategy<T0, T1>) : 0x2::object::ID {
        arg0.admin_cap_id
    }

    fun get_deposited_ctoken_amount<T0, T1>(arg0: &SuilendStrategy<T0, T1>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : u64 {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T0, T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.obligation_cap)))
    }

    public fun get_lending_market_id<T0, T1>(arg0: &SuilendStrategy<T0, T1>) : 0x2::object::ID {
        arg0.lending_market_id
    }

    public fun get_obligation_id<T0, T1>(arg0: &SuilendStrategy<T0, T1>) : 0x2::object::ID {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.obligation_cap)
    }

    public fun get_reserve_index<T0, T1>(arg0: &SuilendStrategy<T0, T1>) : u64 {
        arg0.reserve_array_index
    }

    public fun get_strategy_id<T0, T1>(arg0: &SuilendStrategy<T0, T1>) : 0x2::object::ID {
        0x2::object::id<SuilendStrategy<T0, T1>>(arg0)
    }

    public fun get_strategy_summary<T0, T1>(arg0: &SuilendStrategy<T0, T1>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : (u64, u64, bool, 0x2::object::ID) {
        (arg0.underlying_nominal_value, get_deposited_ctoken_amount<T0, T1>(arg0, arg1), arg0.is_active, arg0.lending_market_id)
    }

    public fun get_underlying_value<T0, T1>(arg0: &SuilendStrategy<T0, T1>) : u64 {
        arg0.underlying_nominal_value
    }

    public fun harvest_profit<T0, T1, T2>(arg0: &mut SuilendStrategy<T0, T1>, arg1: &StrategyAdminCap, arg2: &mut 0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::Vault<T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        assert_version<T0, T1>(arg0);
        assert_admin<T0, T1>(arg1, arg0);
        assert_vault_access<T0, T1>(arg0);
        assert_lending_market<T0>(arg0.lending_market_id, arg3);
        assert_suilend_lending_market<T0>(arg3);
        assert_suilend_price_info(arg5);
        let v0 = 0x1::option::borrow<0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::VaultAccess>(&arg0.vault_access);
        let v1 = get_deposited_ctoken_amount<T0, T1>(arg0, arg3);
        if (v1 == 0 || arg0.underlying_nominal_value == 0) {
            return 0
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg0.reserve_array_index, arg4, arg5);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg3, arg0.reserve_array_index, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg3, arg0.reserve_array_index, &arg0.obligation_cap, arg4, v1, arg6), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg6);
        let v3 = 0x2::coin::value<T1>(&v2);
        let v4 = arg0.underlying_nominal_value;
        let v5 = 0x2::coin::into_balance<T1>(v2);
        if (v3 > v4) {
            let v7 = v3 - v4;
            0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::add_strategy_profit<T1, T2>(arg2, v0, 0x2::balance::split<T1>(&mut v5, v7), arg4);
            let v8 = StrategyProfitEvent{
                vault_id      : 0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::vault_id<T1, T2>(arg2),
                strategy_id   : 0x2::object::id<SuilendStrategy<T0, T1>>(arg0),
                profit_amount : v7,
                timestamp     : 0x2::clock::timestamp_ms(arg4),
            };
            0x2::event::emit<StrategyProfitEvent>(v8);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg0.reserve_array_index, arg4, arg5);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg3, arg0.reserve_array_index, &arg0.obligation_cap, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg3, arg0.reserve_array_index, arg4, 0x2::coin::from_balance<T1>(v5, arg6), arg6), arg6);
            v7
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg0.reserve_array_index, arg4, arg5);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg3, arg0.reserve_array_index, &arg0.obligation_cap, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg3, arg0.reserve_array_index, arg4, 0x2::coin::from_balance<T1>(v5, arg6), arg6), arg6);
            0
        }
    }

    public fun is_strategy_active<T0, T1>(arg0: &SuilendStrategy<T0, T1>) : bool {
        arg0.is_active
    }

    public fun join_vault<T0, T1, T2>(arg0: &0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::AdminCap, arg1: &mut 0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::Vault<T1, T2>, arg2: &StrategyAdminCap, arg3: &mut SuilendStrategy<T0, T1>, arg4: &0x2::clock::Clock) {
        assert_version<T0, T1>(arg3);
        assert_admin<T0, T1>(arg2, arg3);
        assert!(0x1::option::is_none<0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::VaultAccess>(&arg3.vault_access), 4);
        0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::set_target_allocation<T1, T2>(arg0, arg1, 0x2::object::id<SuilendStrategy<T0, T1>>(arg3), 3500, arg4);
        0x1::option::fill<0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::VaultAccess>(&mut arg3.vault_access, 0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::add_strategy<T1, T2>(arg0, arg1, 0x2::object::id<SuilendStrategy<T0, T1>>(arg3), b"SUILEND_STRATEGY_LENDING_USDC", 5000, arg4));
        let v0 = StrategyJoinedVault{
            strategy_id : 0x2::object::id<SuilendStrategy<T0, T1>>(arg3),
            vault_id    : 0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::vault_id<T1, T2>(arg1),
            timestamp   : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<StrategyJoinedVault>(v0);
    }

    entry fun migrate<T0, T1>(arg0: &StrategyAdminCap, arg1: &mut SuilendStrategy<T0, T1>) {
        assert_admin<T0, T1>(arg0, arg1);
        assert!(arg1.version < 1, 2);
        arg1.version = 1;
    }

    public fun ptb_withdraw<T0, T1, T2>(arg0: &mut SuilendStrategy<T0, T1>, arg1: &mut 0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::Vault<T1, T2>, arg2: &mut 0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::WithdrawReceipt<T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version<T0, T1>(arg0);
        assert_vault_access<T0, T1>(arg0);
        assert_lending_market<T0>(arg0.lending_market_id, arg3);
        assert_suilend_lending_market<T0>(arg3);
        assert_suilend_price_info(arg5);
        let v0 = 0x2::object::id<SuilendStrategy<T0, T1>>(arg0);
        if (!0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::is_strategy_allocated_in_receipt<T1, T2>(arg2, v0)) {
            return
        };
        let v1 = 0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::get_strategy_allocation_from_receipt<T1, T2>(arg2, v0);
        if (v1 == 0) {
            0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::update_receipt_after_strategy_withdrawal<T1, T2>(arg1, arg2, v0, 0x2::balance::zero<T1>(), arg6);
            return
        };
        let v2 = get_deposited_ctoken_amount<T0, T1>(arg0, arg3);
        if (v2 == 0 || arg0.underlying_nominal_value == 0) {
            0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::update_receipt_after_strategy_withdrawal<T1, T2>(arg1, arg2, v0, 0x2::balance::zero<T1>(), arg6);
            return
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg0.reserve_array_index, arg4, arg5);
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg3, arg0.reserve_array_index, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg3, arg0.reserve_array_index, &arg0.obligation_cap, arg4, v2, arg6), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg6);
        let v4 = 0x2::coin::value<T1>(&v3);
        assert!(v4 >= v1, 7);
        let v5 = 0x2::coin::into_balance<T1>(v3);
        if (0x2::balance::value<T1>(&v5) > 0) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg0.reserve_array_index, arg4, arg5);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg3, arg0.reserve_array_index, &arg0.obligation_cap, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg3, arg0.reserve_array_index, arg4, 0x2::coin::from_balance<T1>(v5, arg6), arg6), arg6);
        } else {
            0x2::balance::destroy_zero<T1>(v5);
        };
        arg0.underlying_nominal_value = v4 - v1;
        0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::update_receipt_after_strategy_withdrawal<T1, T2>(arg1, arg2, v0, 0x2::balance::split<T1>(&mut v5, v1), arg6);
        let v6 = PTBWithdrawalExecuted{
            strategy_id      : v0,
            requested_amount : v1,
            timestamp        : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<PTBWithdrawalExecuted>(v6);
    }

    public fun rebalance<T0, T1, T2>(arg0: &StrategyAdminCap, arg1: &mut SuilendStrategy<T0, T1>, arg2: &mut 0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::Vault<T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, arg1);
        assert_version<T0, T1>(arg1);
        assert_vault_access<T0, T1>(arg1);
        assert_lending_market<T0>(arg1.lending_market_id, arg3);
        assert_suilend_lending_market<T0>(arg3);
        assert_suilend_price_info(arg5);
        let v0 = 0x1::option::borrow<0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::VaultAccess>(&arg1.vault_access);
        let v1 = 0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::calc_rebalance_amounts<T1, T2>(arg2);
        let (v2, v3) = 0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::rebalance_amounts_get(&v1, v0);
        if (v2 == 0 && v3 == 0) {
            return
        };
        if (v3 > 0) {
            let v4 = get_deposited_ctoken_amount<T0, T1>(arg1, arg3);
            if (v4 == 0 || arg1.underlying_nominal_value == 0) {
                return
            };
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg1.reserve_array_index, arg4, arg5);
            let v5 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg3, arg1.reserve_array_index, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg3, arg1.reserve_array_index, &arg1.obligation_cap, arg4, v4, arg6), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg6);
            let v6 = 0x2::coin::value<T1>(&v5);
            assert!(v3 <= v6, 7);
            let v7 = 0x2::coin::into_balance<T1>(v5);
            0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::defund_strategy<T1, T2>(arg2, v0, 0x2::balance::split<T1>(&mut v7, v3), v3, arg4);
            if (0x2::balance::value<T1>(&v7) > 0) {
                0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg1.reserve_array_index, arg4, arg5);
                0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg3, arg1.reserve_array_index, &arg1.obligation_cap, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg3, arg1.reserve_array_index, arg4, 0x2::coin::from_balance<T1>(v7, arg6), arg6), arg6);
            } else {
                0x2::balance::destroy_zero<T1>(v7);
            };
            arg1.underlying_nominal_value = v6 - v3;
        };
        if (v2 > 0) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg1.reserve_array_index, arg4, arg5);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg3, arg1.reserve_array_index, &arg1.obligation_cap, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg3, arg1.reserve_array_index, arg4, 0x2::coin::from_balance<T1>(0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::fund_strategy<T1, T2>(arg2, v0, v2, arg4), arg6), arg6), arg6);
            arg1.underlying_nominal_value = arg1.underlying_nominal_value + v2;
        };
        if (v2 > 0 || v3 > 0) {
            let v8 = StrategyRebalanced{
                strategy_id          : 0x2::object::id<SuilendStrategy<T0, T1>>(arg1),
                fund_amount          : v2,
                defund_amount        : v3,
                new_underlying_value : arg1.underlying_nominal_value,
                timestamp            : 0x2::clock::timestamp_ms(arg4),
            };
            0x2::event::emit<StrategyRebalanced>(v8);
        };
    }

    public fun set_strategy_active<T0, T1>(arg0: &StrategyAdminCap, arg1: &mut SuilendStrategy<T0, T1>, arg2: bool) {
        assert_admin<T0, T1>(arg0, arg1);
        assert_version<T0, T1>(arg1);
        arg1.is_active = arg2;
    }

    // decompiled from Move bytecode v6
}

