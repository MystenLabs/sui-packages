module 0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_trading {
    struct SuiTradingVault<phantom T0> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        trading_balance: 0x2::balance::Balance<T0>,
        max_trade_size: u64,
        daily_trade_limit: u64,
        daily_traded: u64,
        day_reset_time: u64,
        paused: bool,
    }

    struct SuiLeaderTradeCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        trading_vault_id: 0x2::object::ID,
    }

    struct SuiTradingModule has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        trading_vault_id: 0x2::object::ID,
        api_wallets: 0x2::table::Table<address, 0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_types::ApiWalletInfo>,
        order_nonce: u128,
        positions: 0x2::table::Table<u64, PositionInfo>,
    }

    struct TradeAuthorization has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        base_type: u64,
        quote_type: u64,
        max_amount: u64,
        is_buy: bool,
        min_output: u64,
        expires_at: u64,
        used: bool,
    }

    struct PositionInfo has copy, drop, store {
        base_amount: u64,
        quote_spent: u64,
        last_update: u64,
    }

    struct TradingVaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        trading_vault_id: 0x2::object::ID,
    }

    struct FundsDeposited has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct FundsWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct TradeAuthorized has copy, drop {
        vault_id: 0x2::object::ID,
        authorization_id: 0x2::object::ID,
        max_amount: u64,
        is_buy: bool,
        order_nonce: u128,
    }

    struct TradeExecuted has copy, drop {
        vault_id: 0x2::object::ID,
        authorization_id: 0x2::object::ID,
        amount_used: u64,
        output_received: u64,
    }

    struct ApiWalletAdded has copy, drop {
        vault_id: 0x2::object::ID,
        wallet: address,
        expires_at: u64,
        name: 0x1::string::String,
    }

    struct ApiWalletRemoved has copy, drop {
        vault_id: 0x2::object::ID,
        wallet: address,
    }

    public fun add_api_wallet(arg0: &mut SuiTradingModule, arg1: &SuiLeaderTradeCap, arg2: address, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == arg0.vault_id, 1);
        assert!(!0x2::table::contains<address, 0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_types::ApiWalletInfo>(&arg0.api_wallets, arg2), 7);
        let v0 = if (arg3 == 0) {
            0
        } else {
            assert!(arg3 >= 0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_types::min_api_wallet_duration() / 86400 && arg3 <= 0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_types::max_api_wallet_duration() / 86400, 5);
            0x2::clock::timestamp_ms(arg5) / 1000 + arg3 * 24 * 60 * 60
        };
        0x2::table::add<address, 0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_types::ApiWalletInfo>(&mut arg0.api_wallets, arg2, 0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_types::new_api_wallet_info(true, v0, arg4));
        let v1 = ApiWalletAdded{
            vault_id   : arg0.vault_id,
            wallet     : arg2,
            expires_at : v0,
            name       : 0x1::string::utf8(arg4),
        };
        0x2::event::emit<ApiWalletAdded>(v1);
    }

    public fun authorize_trade<T0>(arg0: &mut SuiTradingModule, arg1: &mut SuiTradingVault<T0>, arg2: &SuiLeaderTradeCap, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.vault_id == arg0.vault_id, 1);
        assert!(!arg1.paused, 2);
        let v0 = 0x2::clock::timestamp_ms(arg9) / 1000;
        if (v0 >= arg1.day_reset_time) {
            arg1.daily_traded = 0;
            arg1.day_reset_time = v0 + 86400;
        };
        assert!(arg5 <= arg1.max_trade_size, 11);
        assert!(arg1.daily_traded + arg5 <= arg1.daily_trade_limit, 11);
        assert!(0x2::balance::value<T0>(&arg1.trading_balance) >= arg5, 8);
        arg1.daily_traded = arg1.daily_traded + arg5;
        arg0.order_nonce = arg0.order_nonce + 1;
        let v1 = TradeAuthorization{
            id         : 0x2::object::new(arg10),
            vault_id   : arg0.vault_id,
            base_type  : arg3,
            quote_type : arg4,
            max_amount : arg5,
            is_buy     : arg6,
            min_output : arg7,
            expires_at : v0 + arg8,
            used       : false,
        };
        let v2 = TradeAuthorized{
            vault_id         : arg0.vault_id,
            authorization_id : 0x2::object::id<TradeAuthorization>(&v1),
            max_amount       : arg5,
            is_buy           : arg6,
            order_nonce      : arg0.order_nonce,
        };
        0x2::event::emit<TradeAuthorized>(v2);
        0x2::transfer::transfer<TradeAuthorization>(v1, 0x2::tx_context::sender(arg10));
    }

    public fun consume_authorization_for_trade<T0>(arg0: TradeAuthorization, arg1: &mut SuiTradingVault<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let TradeAuthorization {
            id         : v0,
            vault_id   : _,
            base_type  : _,
            quote_type : _,
            max_amount : v4,
            is_buy     : _,
            min_output : _,
            expires_at : v7,
            used       : v8,
        } = arg0;
        assert!(!v8, 10);
        assert!(0x2::clock::timestamp_ms(arg3) / 1000 < v7, 4);
        assert!(arg2 <= v4, 11);
        assert!(0x2::balance::value<T0>(&arg1.trading_balance) >= arg2, 8);
        0x2::object::delete(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.trading_balance, arg2), arg4)
    }

    public fun create_trading_vault<T0>(arg0: &0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_factory::SuiAdminCap, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        create_trading_vault_internal<T0>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun create_trading_vault_internal<T0>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = SuiTradingVault<T0>{
            id                : 0x2::object::new(arg5),
            vault_id          : arg0,
            trading_balance   : 0x2::balance::zero<T0>(),
            max_trade_size    : arg2,
            daily_trade_limit : arg3,
            daily_traded      : 0,
            day_reset_time    : 0x2::clock::timestamp_ms(arg4) / 1000 + 86400,
            paused            : false,
        };
        let v1 = 0x2::object::id<SuiTradingVault<T0>>(&v0);
        let v2 = SuiLeaderTradeCap{
            id               : 0x2::object::new(arg5),
            vault_id         : arg0,
            trading_vault_id : v1,
        };
        let v3 = SuiTradingModule{
            id               : 0x2::object::new(arg5),
            vault_id         : arg0,
            trading_vault_id : v1,
            api_wallets      : 0x2::table::new<address, 0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_types::ApiWalletInfo>(arg5),
            order_nonce      : 0,
            positions        : 0x2::table::new<u64, PositionInfo>(arg5),
        };
        let v4 = TradingVaultCreated{
            vault_id         : arg0,
            trading_vault_id : v1,
        };
        0x2::event::emit<TradingVaultCreated>(v4);
        0x2::transfer::transfer<SuiTradingVault<T0>>(v0, 0x2::tx_context::sender(arg5));
        0x2::transfer::transfer<SuiLeaderTradeCap>(v2, arg1);
        0x2::transfer::share_object<SuiTradingModule>(v3);
    }

    public fun create_trading_vault_unlimited<T0>(arg0: &0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_factory::SuiAdminCap, arg1: 0x2::object::ID, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        create_trading_vault_internal<T0>(arg1, arg2, 18446744073709551615, 18446744073709551615, arg3, arg4);
    }

    public fun daily_trade_limit<T0>(arg0: &SuiTradingVault<T0>) : u64 {
        arg0.daily_trade_limit
    }

    public fun daily_traded<T0>(arg0: &SuiTradingVault<T0>) : u64 {
        arg0.daily_traded
    }

    public fun deposit_to_trading<T0>(arg0: &mut SuiTradingVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.trading_balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = FundsDeposited{
            vault_id : arg0.vault_id,
            amount   : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<FundsDeposited>(v0);
    }

    public fun has_api_wallet(arg0: &SuiTradingModule, arg1: address) : bool {
        0x2::table::contains<address, 0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_types::ApiWalletInfo>(&arg0.api_wallets, arg1)
    }

    public fun is_paused<T0>(arg0: &SuiTradingVault<T0>) : bool {
        arg0.paused
    }

    public fun leader_trade_cap_vault_id(arg0: &SuiLeaderTradeCap) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun max_trade_size<T0>(arg0: &SuiTradingVault<T0>) : u64 {
        arg0.max_trade_size
    }

    public fun order_nonce(arg0: &SuiTradingModule) : u128 {
        arg0.order_nonce
    }

    public fun remove_api_wallet(arg0: &mut SuiTradingModule, arg1: &SuiLeaderTradeCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == arg0.vault_id, 1);
        assert!(0x2::table::contains<address, 0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_types::ApiWalletInfo>(&arg0.api_wallets, arg2), 6);
        0x2::table::remove<address, 0x60636ee15efcdd7ec07fe009d0391ff96ae87b56cf77c08b24f6d6f00f463fdb::sui_types::ApiWalletInfo>(&mut arg0.api_wallets, arg2);
        let v0 = ApiWalletRemoved{
            vault_id : arg0.vault_id,
            wallet   : arg2,
        };
        0x2::event::emit<ApiWalletRemoved>(v0);
    }

    public fun return_trade_output<T0>(arg0: &mut SuiTradingVault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.trading_balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun set_daily_trade_limit<T0>(arg0: &mut SuiTradingVault<T0>, arg1: u64) {
        arg0.daily_trade_limit = arg1;
    }

    public fun set_max_trade_size<T0>(arg0: &mut SuiTradingVault<T0>, arg1: u64) {
        arg0.max_trade_size = arg1;
    }

    public fun set_paused<T0>(arg0: &mut SuiTradingVault<T0>, arg1: bool) {
        arg0.paused = arg1;
    }

    public fun trading_balance<T0>(arg0: &SuiTradingVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.trading_balance)
    }

    public fun trading_vault_id<T0>(arg0: &SuiTradingVault<T0>) : 0x2::object::ID {
        0x2::object::id<SuiTradingVault<T0>>(arg0)
    }

    public fun trading_vault_vault_id<T0>(arg0: &SuiTradingVault<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun withdraw_all_from_trading<T0>(arg0: &mut SuiTradingVault<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0.trading_balance);
        withdraw_from_trading<T0>(arg0, v0, arg1)
    }

    public fun withdraw_all_from_trading_to<T0>(arg0: &mut SuiTradingVault<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw_all_from_trading<T0>(arg0, arg2), arg1);
    }

    public fun withdraw_from_trading<T0>(arg0: &mut SuiTradingVault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::balance::value<T0>(&arg0.trading_balance) >= arg1, 8);
        let v0 = FundsWithdrawn{
            vault_id : arg0.vault_id,
            amount   : arg1,
        };
        0x2::event::emit<FundsWithdrawn>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.trading_balance, arg1), arg2)
    }

    public fun withdraw_from_trading_to<T0>(arg0: &mut SuiTradingVault<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw_from_trading<T0>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

