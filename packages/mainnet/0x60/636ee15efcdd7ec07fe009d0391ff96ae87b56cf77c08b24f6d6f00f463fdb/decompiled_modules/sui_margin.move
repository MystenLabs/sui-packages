module 0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_margin {
    struct MarginAccount has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        total_allocated: u64,
        max_allocation_bps: u64,
        max_leverage: u64,
        enabled: bool,
        cumulative_profit: u64,
        cumulative_loss: u64,
        trade_count: u64,
    }

    struct MarginDepositAuth has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        amount: u64,
        expires_at: u64,
    }

    struct MarginReturnAuth has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        min_return_amount: u64,
        expires_at: u64,
    }

    struct MarginAccountCreated has copy, drop {
        vault_id: 0x2::object::ID,
        margin_account_id: 0x2::object::ID,
        max_leverage: u64,
        max_allocation_bps: u64,
    }

    struct MarginDepositAuthorized has copy, drop {
        vault_id: 0x2::object::ID,
        auth_id: 0x2::object::ID,
        amount: u64,
    }

    struct MarginFundsExtracted has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        total_allocated: u64,
    }

    struct MarginFundsReturned has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        total_allocated: u64,
        pnl_amount: u64,
        is_profit: bool,
    }

    struct MarginSettingsUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        max_leverage: u64,
        max_allocation_bps: u64,
        enabled: bool,
    }

    public fun authorize_margin_deposit<T0>(arg0: &0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_vault::SuiVault<T0>, arg1: &0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_vault::SuiLeaderCap, arg2: &mut MarginAccount, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : MarginDepositAuth {
        let v0 = 0x2::object::id<0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_vault::SuiVault<T0>>(arg0);
        assert!(0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_vault::leader_cap_vault_id(arg1) == v0, 100);
        assert!(arg2.vault_id == v0, 100);
        assert!(arg2.enabled, 100);
        assert!(arg3 > 0, 101);
        assert!(((arg2.total_allocated + arg3) as u128) <= (0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_vault::available_usdc_for_trading<T0>(arg0) as u128) * (arg2.max_allocation_bps as u128) / (10000 as u128), 102);
        let v1 = MarginDepositAuth{
            id         : 0x2::object::new(arg6),
            vault_id   : v0,
            amount     : arg3,
            expires_at : 0x2::clock::timestamp_ms(arg5) / 1000 + arg4,
        };
        let v2 = MarginDepositAuthorized{
            vault_id : v0,
            auth_id  : 0x2::object::id<MarginDepositAuth>(&v1),
            amount   : arg3,
        };
        0x2::event::emit<MarginDepositAuthorized>(v2);
        v1
    }

    public fun authorize_margin_return<T0>(arg0: &0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_vault::SuiVault<T0>, arg1: &0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_vault::SuiLeaderCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : MarginReturnAuth {
        let v0 = 0x2::object::id<0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_vault::SuiVault<T0>>(arg0);
        assert!(0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_vault::leader_cap_vault_id(arg1) == v0, 100);
        MarginReturnAuth{
            id                : 0x2::object::new(arg5),
            vault_id          : v0,
            min_return_amount : arg2,
            expires_at        : 0x2::clock::timestamp_ms(arg4) / 1000 + arg3,
        }
    }

    public fun consume_margin_deposit<T0>(arg0: MarginDepositAuth, arg1: &mut 0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_vault::SuiVault<T0>, arg2: &mut MarginAccount, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let MarginDepositAuth {
            id         : v0,
            vault_id   : v1,
            amount     : v2,
            expires_at : v3,
        } = arg0;
        assert!(0x2::clock::timestamp_ms(arg3) / 1000 < v3, 103);
        assert!(v1 == 0x2::object::id<0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_vault::SuiVault<T0>>(arg1), 100);
        assert!(v1 == arg2.vault_id, 100);
        0x2::object::delete(v0);
        arg2.total_allocated = arg2.total_allocated + v2;
        let v4 = MarginFundsExtracted{
            vault_id        : v1,
            amount          : v2,
            total_allocated : arg2.total_allocated,
        };
        0x2::event::emit<MarginFundsExtracted>(v4);
        0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_vault::extract_usdc_for_trading<T0>(arg1, v2, arg4)
    }

    public fun create_margin_account<T0>(arg0: &0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_vault::SuiVault<T0>, arg1: &0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_vault::SuiLeaderCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_vault::leader_cap_vault_id(arg1) == 0x2::object::id<0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_vault::SuiVault<T0>>(arg0), 100);
        let v0 = 0x2::object::id<0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_vault::SuiVault<T0>>(arg0);
        let v1 = MarginAccount{
            id                 : 0x2::object::new(arg2),
            vault_id           : v0,
            total_allocated    : 0,
            max_allocation_bps : 5000,
            max_leverage       : 5000,
            enabled            : true,
            cumulative_profit  : 0,
            cumulative_loss    : 0,
            trade_count        : 0,
        };
        let v2 = MarginAccountCreated{
            vault_id           : v0,
            margin_account_id  : 0x2::object::id<MarginAccount>(&v1),
            max_leverage       : 5000,
            max_allocation_bps : 5000,
        };
        0x2::event::emit<MarginAccountCreated>(v2);
        0x2::transfer::share_object<MarginAccount>(v1);
    }

    public fun cumulative_loss(arg0: &MarginAccount) : u64 {
        arg0.cumulative_loss
    }

    public fun cumulative_profit(arg0: &MarginAccount) : u64 {
        arg0.cumulative_profit
    }

    public fun is_enabled(arg0: &MarginAccount) : bool {
        arg0.enabled
    }

    public fun margin_vault_id(arg0: &MarginAccount) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun max_allocation_bps(arg0: &MarginAccount) : u64 {
        arg0.max_allocation_bps
    }

    public fun max_leverage(arg0: &MarginAccount) : u64 {
        arg0.max_leverage
    }

    public fun net_pnl(arg0: &MarginAccount) : (bool, u64) {
        if (arg0.cumulative_profit >= arg0.cumulative_loss) {
            (true, arg0.cumulative_profit - arg0.cumulative_loss)
        } else {
            (false, arg0.cumulative_loss - arg0.cumulative_profit)
        }
    }

    public fun return_margin_funds<T0>(arg0: MarginReturnAuth, arg1: &mut 0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_vault::SuiVault<T0>, arg2: &mut MarginAccount, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock) {
        let MarginReturnAuth {
            id                : v0,
            vault_id          : v1,
            min_return_amount : v2,
            expires_at        : v3,
        } = arg0;
        assert!(0x2::clock::timestamp_ms(arg5) / 1000 < v3, 103);
        assert!(v1 == 0x2::object::id<0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_vault::SuiVault<T0>>(arg1), 100);
        assert!(v1 == arg2.vault_id, 100);
        let v4 = 0x2::coin::value<T0>(&arg3);
        assert!(v4 >= v2, 101);
        0x2::object::delete(v0);
        if (v4 >= arg4) {
            arg2.cumulative_profit = arg2.cumulative_profit + v4 - arg4;
        } else {
            arg2.cumulative_loss = arg2.cumulative_loss + arg4 - v4;
        };
        if (arg2.total_allocated >= arg4) {
            arg2.total_allocated = arg2.total_allocated - arg4;
        } else {
            arg2.total_allocated = 0;
        };
        arg2.trade_count = arg2.trade_count + 1;
        let (v5, v6) = if (v4 >= arg4) {
            (true, v4 - arg4)
        } else {
            (false, arg4 - v4)
        };
        let v7 = MarginFundsReturned{
            vault_id        : v1,
            amount          : v4,
            total_allocated : arg2.total_allocated,
            pnl_amount      : v6,
            is_profit       : v5,
        };
        0x2::event::emit<MarginFundsReturned>(v7);
        0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_vault::deposit_usdc_from_trading<T0>(arg1, arg3);
    }

    public fun total_allocated(arg0: &MarginAccount) : u64 {
        arg0.total_allocated
    }

    public fun trade_count(arg0: &MarginAccount) : u64 {
        arg0.trade_count
    }

    public fun update_margin_settings<T0>(arg0: &0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_vault::SuiVault<T0>, arg1: &0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_vault::SuiLeaderCap, arg2: &mut MarginAccount, arg3: u64, arg4: u64, arg5: bool) {
        let v0 = 0x2::object::id<0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_vault::SuiVault<T0>>(arg0);
        assert!(0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_vault::leader_cap_vault_id(arg1) == v0, 100);
        assert!(arg2.vault_id == v0, 100);
        assert!(arg3 >= 1000 && arg3 <= 20000, 104);
        assert!(arg4 <= 8000, 102);
        if (!arg5) {
            assert!(arg2.total_allocated == 0, 107);
        };
        arg2.max_leverage = arg3;
        arg2.max_allocation_bps = arg4;
        arg2.enabled = arg5;
        let v1 = MarginSettingsUpdated{
            vault_id           : v0,
            max_leverage       : arg3,
            max_allocation_bps : arg4,
            enabled            : arg5,
        };
        0x2::event::emit<MarginSettingsUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

