module 0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::suilend_usdc_strategy {
    struct SuilendStrategy<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        admin_cap_id: 0x2::object::ID,
        vault_access: 0x1::option::Option<0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::VaultAccess>,
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
        actual_amount: u64,
        ctokens_redeemed: u64,
        timestamp: u64,
    }

    struct SuilendOperationExecuted has copy, drop {
        strategy_id: 0x2::object::ID,
        operation_type: vector<u8>,
        amount: u64,
        new_underlying_value: u64,
        timestamp: u64,
    }

    fun assert_admin<T0, T1>(arg0: &StrategyAdminCap, arg1: &SuilendStrategy<T0, T1>) {
        assert!(0x2::object::id<StrategyAdminCap>(arg0) == arg1.admin_cap_id, 1);
    }

    fun assert_lending_market<T0>(arg0: 0x2::object::ID, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) {
        assert!(0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg1) == arg0, 14);
    }

    fun assert_suilend_lending_market<T0>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) {
        assert!(0x2::object::id_address<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg0) == @0x84030d26d85eaa7035084a057f2f11f701b7e2e4eda87551becbc7c97505ece1, 2);
    }

    fun assert_suilend_price_info(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        assert!(0x2::object::id_address<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg0) == @0x5dec622733a204ca27f5a90d8c2fad453cc6665186fd5dff13a83d0b6c9027ab, 3);
    }

    fun assert_suilend_reserve_index(arg0: u64) {
        assert!(arg0 == 7, 17);
    }

    fun assert_vault_access<T0, T1>(arg0: &SuilendStrategy<T0, T1>) {
        assert!(0x1::option::is_some<0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::VaultAccess>(&arg0.vault_access), 6);
    }

    fun assert_version<T0, T1>(arg0: &SuilendStrategy<T0, T1>) {
        assert!(arg0.version == 1, 4);
    }

    public entry fun create_strategy<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0xf92f5598caf737db94a4902f927629596a659e695406851d91982cfb55e2bc1, 13);
        assert_suilend_lending_market<T0>(arg0);
        assert_suilend_reserve_index(arg1);
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = StrategyAdminCap{
            id          : 0x2::object::new(arg3),
            strategy_id : v1,
        };
        let v3 = 0x2::object::id<StrategyAdminCap>(&v2);
        let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg0, arg3);
        let v5 = 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg0);
        let v6 = SuilendStrategy<T0, T1>{
            id                       : v0,
            admin_cap_id             : v3,
            vault_access             : 0x1::option::none<0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::VaultAccess>(),
            obligation_cap           : v4,
            lending_market_id        : v5,
            reserve_array_index      : arg1,
            underlying_nominal_value : 0,
            version                  : 1,
            is_active                : true,
        };
        let v7 = StrategyCreated{
            strategy_id       : v1,
            admin_cap_id      : v3,
            lending_market_id : v5,
            reserve_index     : arg1,
            obligation_id     : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&v4),
            timestamp         : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<StrategyCreated>(v7);
        0x2::transfer::share_object<SuilendStrategy<T0, T1>>(v6);
        0x2::transfer::transfer<StrategyAdminCap>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun emergency_withdraw<T0, T1>(arg0: &StrategyAdminCap, arg1: &mut SuilendStrategy<T0, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert_admin<T0, T1>(arg0, arg1);
        assert_version<T0, T1>(arg1);
        assert_lending_market<T0>(arg1.lending_market_id, arg2);
        assert_suilend_lending_market<T0>(arg2);
        assert_suilend_price_info(arg4);
        if (arg1.underlying_nominal_value == 0) {
            return 0x2::balance::zero<T1>()
        };
        let v0 = get_deposited_ctoken_amount<T0, T1>(arg1, arg2);
        if (v0 == 0) {
            arg1.underlying_nominal_value = 0;
            return 0x2::balance::zero<T1>()
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg2, arg1.reserve_array_index, arg3, arg4);
        arg1.underlying_nominal_value = 0;
        0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg2, arg1.reserve_array_index, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg2, arg1.reserve_array_index, &arg1.obligation_cap, arg3, v0, arg5), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg5))
    }

    public fun get_admin_cap_id<T0, T1>(arg0: &SuilendStrategy<T0, T1>) : 0x2::object::ID {
        arg0.admin_cap_id
    }

    public fun get_deposited_ctoken_amount<T0, T1>(arg0: &SuilendStrategy<T0, T1>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : u64 {
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

    public fun is_strategy_active<T0, T1>(arg0: &SuilendStrategy<T0, T1>) : bool {
        arg0.is_active
    }

    public entry fun join_vault<T0, T1, T2>(arg0: &0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::AdminCap, arg1: &mut 0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::Vault<T1, T2>, arg2: &StrategyAdminCap, arg3: &mut SuilendStrategy<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version<T0, T1>(arg3);
        assert_admin<T0, T1>(arg2, arg3);
        assert!(0x1::option::is_none<0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::VaultAccess>(&arg3.vault_access), 16);
        0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::set_target_allocation<T1, T2>(arg0, arg1, 0x2::object::id<SuilendStrategy<T0, T1>>(arg3), 3000);
        0x1::option::fill<0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::VaultAccess>(&mut arg3.vault_access, 0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::add_strategy<T1, T2>(arg0, arg1, 0x2::object::id<SuilendStrategy<T0, T1>>(arg3), b"Suilend_Lending", 5000, arg4, arg5));
        let v0 = StrategyJoinedVault{
            strategy_id : 0x2::object::id<SuilendStrategy<T0, T1>>(arg3),
            vault_id    : 0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::vault_id<T1, T2>(arg1),
            timestamp   : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<StrategyJoinedVault>(v0);
    }

    entry fun migrate<T0, T1>(arg0: &StrategyAdminCap, arg1: &mut SuilendStrategy<T0, T1>) {
        assert_admin<T0, T1>(arg0, arg1);
        assert!(arg1.version < 1, 5);
        arg1.version = 1;
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun muldiv(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        if (arg2 == 0) {
            abort 7
        };
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun ptb_withdraw<T0, T1, T2>(arg0: &mut SuilendStrategy<T0, T1>, arg1: &mut 0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::Vault<T1, T2>, arg2: &mut 0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::WithdrawReceipt<T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version<T0, T1>(arg0);
        assert_vault_access<T0, T1>(arg0);
        assert_lending_market<T0>(arg0.lending_market_id, arg3);
        assert_suilend_lending_market<T0>(arg3);
        assert_suilend_price_info(arg5);
        let v0 = 0x2::object::id<SuilendStrategy<T0, T1>>(arg0);
        if (!0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::is_strategy_allocated_in_receipt<T1, T2>(arg2, v0)) {
            return
        };
        let v1 = 0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::get_strategy_allocation_from_receipt<T1, T2>(arg2, v0);
        if (v1 == 0) {
            0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::update_receipt_after_strategy_withdrawal<T1, T2>(arg2, v0, 0x2::balance::zero<T1>());
            return
        };
        let v2 = min(v1, arg0.underlying_nominal_value);
        if (v2 == 0) {
            0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::update_receipt_after_strategy_withdrawal<T1, T2>(arg2, v0, 0x2::balance::zero<T1>());
            return
        };
        let v3 = get_deposited_ctoken_amount<T0, T1>(arg0, arg3);
        if (v3 == 0) {
            0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::update_receipt_after_strategy_withdrawal<T1, T2>(arg2, v0, 0x2::balance::zero<T1>());
            return
        };
        let v4 = if (arg0.underlying_nominal_value > 0) {
            muldiv(v3, v2, arg0.underlying_nominal_value)
        } else {
            0
        };
        if (v4 == 0) {
            0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::update_receipt_after_strategy_withdrawal<T1, T2>(arg2, v0, 0x2::balance::zero<T1>());
            return
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg0.reserve_array_index, arg4, arg5);
        let v5 = 0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg3, arg0.reserve_array_index, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg3, arg0.reserve_array_index, &arg0.obligation_cap, arg4, v4, arg6), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg6));
        let v6 = 0x2::balance::value<T1>(&v5);
        arg0.underlying_nominal_value = arg0.underlying_nominal_value - min(v2, arg0.underlying_nominal_value);
        0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::update_strategy_allocation_after_withdrawal<T1, T2>(arg1, v0, v6);
        0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::update_receipt_after_strategy_withdrawal<T1, T2>(arg2, v0, v5);
        let v7 = PTBWithdrawalExecuted{
            strategy_id      : v0,
            requested_amount : v1,
            actual_amount    : v6,
            ctokens_redeemed : v4,
            timestamp        : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<PTBWithdrawalExecuted>(v7);
    }

    public entry fun rebalance<T0, T1, T2>(arg0: &StrategyAdminCap, arg1: &mut SuilendStrategy<T0, T1>, arg2: &mut 0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::Vault<T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, arg1);
        assert_version<T0, T1>(arg1);
        assert_vault_access<T0, T1>(arg1);
        assert_lending_market<T0>(arg1.lending_market_id, arg3);
        assert_suilend_lending_market<T0>(arg3);
        assert_suilend_price_info(arg5);
        let v0 = 0x1::option::borrow<0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::VaultAccess>(&arg1.vault_access);
        let v1 = 0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::calc_rebalance_amounts<T1, T2>(arg2);
        let (v2, v3) = 0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::rebalance_amounts_get(&v1, v0);
        if (v2 == 0 && v3 == 0) {
            return
        };
        if (v3 > 0) {
            let v4 = min(v3, arg1.underlying_nominal_value);
            if (v4 > 0) {
                let v5 = if (arg1.underlying_nominal_value > 0) {
                    muldiv(get_deposited_ctoken_amount<T0, T1>(arg1, arg3), v4, arg1.underlying_nominal_value)
                } else {
                    0
                };
                if (v5 == 0) {
                    return
                };
                0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg1.reserve_array_index, arg4, arg5);
                let v6 = 0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg3, arg1.reserve_array_index, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg3, arg1.reserve_array_index, &arg1.obligation_cap, arg4, v5, arg6), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg6));
                0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::defund_strategy<T1, T2>(arg2, v0, v6, v4, arg4);
                arg1.underlying_nominal_value = arg1.underlying_nominal_value - v4;
                let v7 = SuilendOperationExecuted{
                    strategy_id          : 0x2::object::id<SuilendStrategy<T0, T1>>(arg1),
                    operation_type       : b"withdraw",
                    amount               : 0x2::balance::value<T1>(&v6),
                    new_underlying_value : arg1.underlying_nominal_value,
                    timestamp            : 0x2::clock::timestamp_ms(arg4),
                };
                0x2::event::emit<SuilendOperationExecuted>(v7);
            };
        };
        if (v2 > 0) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg1.reserve_array_index, arg4, arg5);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg3, arg1.reserve_array_index, &arg1.obligation_cap, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg3, arg1.reserve_array_index, arg4, 0x2::coin::from_balance<T1>(0x1db33e34daffa75f888533072af1bdeb584958afc92b1561f602d42434441331::usdc_vault::fund_strategy<T1, T2>(arg2, v0, v2, arg4), arg6), arg6), arg6);
            arg1.underlying_nominal_value = arg1.underlying_nominal_value + v2;
            let v8 = SuilendOperationExecuted{
                strategy_id          : 0x2::object::id<SuilendStrategy<T0, T1>>(arg1),
                operation_type       : b"deposit",
                amount               : v2,
                new_underlying_value : arg1.underlying_nominal_value,
                timestamp            : 0x2::clock::timestamp_ms(arg4),
            };
            0x2::event::emit<SuilendOperationExecuted>(v8);
        };
        if (v2 > 0 || v3 > 0) {
            let v9 = StrategyRebalanced{
                strategy_id          : 0x2::object::id<SuilendStrategy<T0, T1>>(arg1),
                fund_amount          : v2,
                defund_amount        : v3,
                new_underlying_value : arg1.underlying_nominal_value,
                timestamp            : 0x2::clock::timestamp_ms(arg4),
            };
            0x2::event::emit<StrategyRebalanced>(v9);
        };
    }

    public entry fun set_strategy_active<T0, T1>(arg0: &StrategyAdminCap, arg1: &mut SuilendStrategy<T0, T1>, arg2: bool) {
        assert_admin<T0, T1>(arg0, arg1);
        assert_version<T0, T1>(arg1);
        arg1.is_active = arg2;
    }

    public entry fun update_reserve_index<T0, T1>(arg0: &StrategyAdminCap, arg1: &mut SuilendStrategy<T0, T1>, arg2: u64) {
        assert_admin<T0, T1>(arg0, arg1);
        assert_version<T0, T1>(arg1);
        assert_suilend_reserve_index(arg2);
        arg1.reserve_array_index = arg2;
    }

    // decompiled from Move bytecode v6
}

