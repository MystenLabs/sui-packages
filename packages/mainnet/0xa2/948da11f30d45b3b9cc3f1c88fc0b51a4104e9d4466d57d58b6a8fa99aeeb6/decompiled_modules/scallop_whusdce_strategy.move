module 0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::scallop_whusdce_strategy {
    struct ScallopStrategy<phantom T0> has key {
        id: 0x2::object::UID,
        admin_cap_id: 0x2::object::ID,
        vault_access: 0x1::option::Option<0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault::VaultAccess>,
        s_asset_balance: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>,
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
        s_assets_redeemed: u64,
        timestamp: u64,
    }

    fun assert_admin<T0>(arg0: &StrategyAdminCap, arg1: &ScallopStrategy<T0>) {
        assert!(0x2::object::id<StrategyAdminCap>(arg0) == arg1.admin_cap_id, 1);
    }

    fun assert_scallop_market(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) {
        assert!(0x2::object::id_address<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg0) == @0xa757975255146dc9686aa823b7838b507f315d704f428cbadad2f4ea061939d9, 2);
    }

    fun assert_scallop_version(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version) {
        assert!(0x2::object::id_address<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version>(arg0) == @0x7871c4b3c847a0f674510d4978d5cf6f960452795e8ff6f189fd2088a3f6ac7, 3);
    }

    fun assert_vault_access<T0>(arg0: &ScallopStrategy<T0>) {
        assert!(0x1::option::is_some<0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault::VaultAccess>(&arg0.vault_access), 6);
    }

    fun assert_version<T0>(arg0: &ScallopStrategy<T0>) {
        assert!(arg0.version == 1, 4);
    }

    public entry fun create_strategy<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0xf92f5598caf737db94a4902f927629596a659e695406851d91982cfb55e2bc1, 13);
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = StrategyAdminCap{
            id          : 0x2::object::new(arg1),
            strategy_id : v1,
        };
        let v3 = 0x2::object::id<StrategyAdminCap>(&v2);
        let v4 = ScallopStrategy<T0>{
            id                       : v0,
            admin_cap_id             : v3,
            vault_access             : 0x1::option::none<0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault::VaultAccess>(),
            s_asset_balance          : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(),
            underlying_nominal_value : 0,
            version                  : 1,
            is_active                : true,
        };
        let v5 = StrategyCreated{
            strategy_id  : v1,
            admin_cap_id : v3,
            timestamp    : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<StrategyCreated>(v5);
        0x2::transfer::share_object<ScallopStrategy<T0>>(v4);
        0x2::transfer::transfer<StrategyAdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun emergency_withdraw<T0>(arg0: &StrategyAdminCap, arg1: &mut ScallopStrategy<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert_admin<T0>(arg0, arg1);
        assert_version<T0>(arg1);
        assert_scallop_version(arg2);
        assert_scallop_market(arg3);
        let v0 = 0x2::balance::withdraw_all<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg1.s_asset_balance);
        if (0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v0) == 0) {
            0x2::balance::destroy_zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v0);
            arg1.underlying_nominal_value = 0;
            return 0x2::balance::zero<T0>()
        };
        arg1.underlying_nominal_value = 0;
        0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg3, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v0, arg5), arg4, arg5))
    }

    public fun get_admin_cap_id<T0>(arg0: &ScallopStrategy<T0>) : 0x2::object::ID {
        arg0.admin_cap_id
    }

    public fun get_s_asset_balance<T0>(arg0: &ScallopStrategy<T0>) : u64 {
        0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg0.s_asset_balance)
    }

    public fun get_strategy_id<T0>(arg0: &ScallopStrategy<T0>) : 0x2::object::ID {
        0x2::object::id<ScallopStrategy<T0>>(arg0)
    }

    public fun get_strategy_summary<T0>(arg0: &ScallopStrategy<T0>) : (u64, u64, bool) {
        (arg0.underlying_nominal_value, 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg0.s_asset_balance), arg0.is_active)
    }

    public fun get_underlying_value<T0>(arg0: &ScallopStrategy<T0>) : u64 {
        arg0.underlying_nominal_value
    }

    public fun is_strategy_active<T0>(arg0: &ScallopStrategy<T0>) : bool {
        arg0.is_active
    }

    public entry fun join_vault<T0, T1>(arg0: &0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault::AdminCap, arg1: &mut 0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault::Vault<T0, T1>, arg2: &StrategyAdminCap, arg3: &mut ScallopStrategy<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg3);
        assert_admin<T0>(arg2, arg3);
        assert!(0x1::option::is_none<0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault::VaultAccess>(&arg3.vault_access), 6);
        0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault::set_target_allocation<T0, T1>(arg0, arg1, 0x2::object::id<ScallopStrategy<T0>>(arg3), 3000);
        0x1::option::fill<0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault::VaultAccess>(&mut arg3.vault_access, 0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault::add_strategy<T0, T1>(arg0, arg1, 0x2::object::id<ScallopStrategy<T0>>(arg3), b"Scallop_Asset_Lending", 5000, arg4, arg5));
        let v0 = StrategyJoinedVault{
            strategy_id : 0x2::object::id<ScallopStrategy<T0>>(arg3),
            vault_id    : 0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault::vault_id<T0, T1>(arg1),
            timestamp   : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<StrategyJoinedVault>(v0);
    }

    entry fun migrate<T0>(arg0: &StrategyAdminCap, arg1: &mut ScallopStrategy<T0>) {
        assert_admin<T0>(arg0, arg1);
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

    public fun ptb_withdraw<T0, T1>(arg0: &mut ScallopStrategy<T0>, arg1: &mut 0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault::Vault<T0, T1>, arg2: &mut 0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault::WithdrawReceipt<T0, T1>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_vault_access<T0>(arg0);
        assert_scallop_version(arg3);
        assert_scallop_market(arg4);
        let v0 = 0x2::object::id<ScallopStrategy<T0>>(arg0);
        if (!0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault::is_strategy_allocated_in_receipt<T0, T1>(arg2, v0)) {
            return
        };
        let v1 = 0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault::get_strategy_allocation_from_receipt<T0, T1>(arg2, v0);
        if (v1 == 0) {
            0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault::update_receipt_after_strategy_withdrawal<T0, T1>(arg2, v0, 0x2::balance::zero<T0>());
            return
        };
        let v2 = min(v1, arg0.underlying_nominal_value);
        if (v2 == 0) {
            0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault::update_receipt_after_strategy_withdrawal<T0, T1>(arg2, v0, 0x2::balance::zero<T0>());
            return
        };
        let v3 = 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg0.s_asset_balance);
        let v4 = if (arg0.underlying_nominal_value > 0) {
            muldiv(v3, v2, arg0.underlying_nominal_value)
        } else {
            0
        };
        if (v4 == 0 || v3 == 0) {
            0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault::update_receipt_after_strategy_withdrawal<T0, T1>(arg2, v0, 0x2::balance::zero<T0>());
            return
        };
        let v5 = 0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg3, arg4, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg0.s_asset_balance, v4), arg6), arg5, arg6));
        let v6 = 0x2::balance::value<T0>(&v5);
        arg0.underlying_nominal_value = arg0.underlying_nominal_value - min(v2, arg0.underlying_nominal_value);
        0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault::update_strategy_allocation_after_withdrawal<T0, T1>(arg1, v0, v6);
        0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault::update_receipt_after_strategy_withdrawal<T0, T1>(arg2, v0, v5);
        let v7 = PTBWithdrawalExecuted{
            strategy_id       : v0,
            requested_amount  : v1,
            actual_amount     : v6,
            s_assets_redeemed : v4,
            timestamp         : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<PTBWithdrawalExecuted>(v7);
    }

    public entry fun rebalance<T0, T1>(arg0: &StrategyAdminCap, arg1: &mut ScallopStrategy<T0>, arg2: &mut 0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault::Vault<T0, T1>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg1);
        assert_version<T0>(arg1);
        assert_vault_access<T0>(arg1);
        assert_scallop_version(arg3);
        assert_scallop_market(arg4);
        let v0 = 0x1::option::borrow<0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault::VaultAccess>(&arg1.vault_access);
        let v1 = 0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault::calc_rebalance_amounts<T0, T1>(arg2);
        let (v2, v3) = 0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault::rebalance_amounts_get(&v1, v0);
        if (v2 == 0 && v3 == 0) {
            return
        };
        if (v3 > 0) {
            let v4 = min(v3, arg1.underlying_nominal_value);
            if (v4 > 0) {
                let v5 = if (arg1.underlying_nominal_value > 0) {
                    muldiv(0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg1.s_asset_balance), v4, arg1.underlying_nominal_value)
                } else {
                    0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg1.s_asset_balance)
                };
                0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault::defund_strategy<T0, T1>(arg2, v0, 0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg3, arg4, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg1.s_asset_balance, v5), arg6), arg5, arg6)), v4, arg5);
                arg1.underlying_nominal_value = arg1.underlying_nominal_value - v4;
            };
        };
        if (v2 > 0) {
            0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg1.s_asset_balance, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg3, arg4, 0x2::coin::from_balance<T0>(0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault::fund_strategy<T0, T1>(arg2, v0, v2, arg5), arg6), arg5, arg6)));
            arg1.underlying_nominal_value = arg1.underlying_nominal_value + v2;
        };
        if (v2 > 0 || v3 > 0) {
            let v6 = StrategyRebalanced{
                strategy_id          : 0x2::object::id<ScallopStrategy<T0>>(arg1),
                fund_amount          : v2,
                defund_amount        : v3,
                new_underlying_value : arg1.underlying_nominal_value,
                timestamp            : 0x2::clock::timestamp_ms(arg5),
            };
            0x2::event::emit<StrategyRebalanced>(v6);
        };
    }

    public entry fun set_strategy_active<T0>(arg0: &StrategyAdminCap, arg1: &mut ScallopStrategy<T0>, arg2: bool) {
        assert_admin<T0>(arg0, arg1);
        assert_version<T0>(arg1);
        arg1.is_active = arg2;
    }

    // decompiled from Move bytecode v6
}

