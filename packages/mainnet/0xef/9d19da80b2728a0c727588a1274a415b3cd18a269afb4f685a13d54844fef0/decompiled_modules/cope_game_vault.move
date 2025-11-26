module 0xef9d19da80b2728a0c727588a1274a415b3cd18a269afb4f685a13d54844fef0::cope_game_vault {
    struct DailyWithdrawal has store {
        amount: u64,
        day: u64,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        user_balances: 0x2::table::Table<address, u64>,
        user_lifetime_deposits: 0x2::table::Table<address, u64>,
        user_daily_withdrawals: 0x2::table::Table<address, DailyWithdrawal>,
        total_deposited: u64,
        total_withdrawn: u64,
        house_profit_lifetime: u64,
        house_loss_lifetime: u64,
        house_withdrawn_lifetime: u64,
        is_paused: bool,
        active_game: bool,
        created_at: u64,
        last_deposit_at: u64,
        last_withdraw_at: u64,
    }

    struct DepositEvent has copy, drop {
        user: address,
        amount: u64,
        new_balance: u64,
        user_lifetime_deposits: u64,
        timestamp: u64,
    }

    struct WithdrawalEvent has copy, drop {
        user: address,
        amount: u64,
        new_balance: u64,
        timestamp: u64,
    }

    struct GameStartedEvent has copy, drop {
        timestamp: u64,
    }

    struct GameEndedEvent has copy, drop {
        timestamp: u64,
    }

    struct GameSettlementEvent has copy, drop {
        num_players: u64,
        house_profit: u64,
        timestamp: u64,
    }

    struct UserSettlementEvent has copy, drop {
        user: address,
        old_balance: u64,
        new_balance: u64,
        pnl: u64,
        is_profit: bool,
        timestamp: u64,
    }

    struct VaultPausedEvent has copy, drop {
        is_paused: bool,
        timestamp: u64,
    }

    struct HouseProfitWithdrawalEvent has copy, drop {
        recipient: address,
        amount: u64,
        remaining_house_profit: u64,
        timestamp: u64,
    }

    struct AdminDepositEvent has copy, drop {
        admin: address,
        amount: u64,
        new_vault_balance: u64,
        timestamp: u64,
    }

    public fun admin_deposit<T0>(arg0: &0xef9d19da80b2728a0c727588a1274a415b3cd18a269afb4f685a13d54844fef0::app::AdminCap, arg1: &mut Vault<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_paused, 2);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 7);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
        let v1 = AdminDepositEvent{
            admin             : 0x2::tx_context::sender(arg4),
            amount            : v0,
            new_vault_balance : 0x2::balance::value<T0>(&arg1.balance),
            timestamp         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AdminDepositEvent>(v1);
    }

    public fun can_withdraw<T0>(arg0: &Vault<T0>, arg1: u64) : bool {
        0x2::balance::value<T0>(&arg0.balance) >= arg1
    }

    public fun create_vault<T0>(arg0: &0xef9d19da80b2728a0c727588a1274a415b3cd18a269afb4f685a13d54844fef0::app::AdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id                       : 0x2::object::new(arg2),
            balance                  : 0x2::balance::zero<T0>(),
            user_balances            : 0x2::table::new<address, u64>(arg2),
            user_lifetime_deposits   : 0x2::table::new<address, u64>(arg2),
            user_daily_withdrawals   : 0x2::table::new<address, DailyWithdrawal>(arg2),
            total_deposited          : 0,
            total_withdrawn          : 0,
            house_profit_lifetime    : 0,
            house_loss_lifetime      : 0,
            house_withdrawn_lifetime : 0,
            is_paused                : false,
            active_game              : false,
            created_at               : 0x2::clock::timestamp_ms(arg1),
            last_deposit_at          : 0,
            last_withdraw_at         : 0,
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0xef9d19da80b2728a0c727588a1274a415b3cd18a269afb4f685a13d54844fef0::config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 2);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 0xef9d19da80b2728a0c727588a1274a415b3cd18a269afb4f685a13d54844fef0::config::get_min_deposit(arg2), 3);
        assert!(v0 <= 0xef9d19da80b2728a0c727588a1274a415b3cd18a269afb4f685a13d54844fef0::config::get_max_deposit(arg2), 5);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        if (!0x2::table::contains<address, u64>(&arg0.user_balances, v1)) {
            0x2::table::add<address, u64>(&mut arg0.user_balances, v1, v0);
        } else {
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_balances, v1);
            *v3 = *v3 + v0;
        };
        if (!0x2::table::contains<address, u64>(&arg0.user_lifetime_deposits, v1)) {
            0x2::table::add<address, u64>(&mut arg0.user_lifetime_deposits, v1, v0);
        } else {
            let v4 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_lifetime_deposits, v1);
            *v4 = *v4 + v0;
        };
        arg0.total_deposited = arg0.total_deposited + v0;
        arg0.last_deposit_at = v2;
        let v5 = DepositEvent{
            user                   : v1,
            amount                 : v0,
            new_balance            : *0x2::table::borrow<address, u64>(&arg0.user_balances, v1),
            user_lifetime_deposits : *0x2::table::borrow<address, u64>(&arg0.user_lifetime_deposits, v1),
            timestamp              : v2,
        };
        0x2::event::emit<DepositEvent>(v5);
    }

    public fun emergency_withdraw_all<T0>(arg0: &0xef9d19da80b2728a0c727588a1274a415b3cd18a269afb4f685a13d54844fef0::app::AdminCap, arg1: &0xef9d19da80b2728a0c727588a1274a415b3cd18a269afb4f685a13d54844fef0::config::Config, arg2: &mut Vault<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.is_paused, 2);
        arg2.total_withdrawn = arg2.total_withdrawn + 0x2::balance::value<T0>(&arg2.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg2.balance), arg3), 0xef9d19da80b2728a0c727588a1274a415b3cd18a269afb4f685a13d54844fef0::config::get_admin_address(arg1));
    }

    public fun end_game<T0>(arg0: &0xef9d19da80b2728a0c727588a1274a415b3cd18a269afb4f685a13d54844fef0::app::AdminCap, arg1: &mut Vault<T0>, arg2: &0x2::clock::Clock) {
        assert!(arg1.active_game, 9);
        arg1.active_game = false;
        let v0 = GameEndedEvent{timestamp: 0x2::clock::timestamp_ms(arg2)};
        0x2::event::emit<GameEndedEvent>(v0);
    }

    public fun get_net_house_profit<T0>(arg0: &Vault<T0>) : (u64, bool) {
        if (arg0.house_profit_lifetime >= arg0.house_loss_lifetime) {
            (arg0.house_profit_lifetime - arg0.house_loss_lifetime, true)
        } else {
            (arg0.house_loss_lifetime - arg0.house_profit_lifetime, false)
        }
    }

    public fun get_user_balance<T0>(arg0: &Vault<T0>, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.user_balances, arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(&arg0.user_balances, arg1)
    }

    public fun get_user_lifetime_deposits<T0>(arg0: &Vault<T0>, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.user_lifetime_deposits, arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(&arg0.user_lifetime_deposits, arg1)
    }

    public fun get_vault_balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_vault_stats<T0>(arg0: &Vault<T0>) : (u64, u64, u64, u64, u64, bool, bool) {
        (0x2::balance::value<T0>(&arg0.balance), arg0.total_deposited, arg0.total_withdrawn, arg0.house_profit_lifetime, arg0.house_loss_lifetime, arg0.is_paused, arg0.active_game)
    }

    public fun is_game_active<T0>(arg0: &Vault<T0>) : bool {
        arg0.active_game
    }

    public fun set_pause<T0>(arg0: &0xef9d19da80b2728a0c727588a1274a415b3cd18a269afb4f685a13d54844fef0::app::AdminCap, arg1: &mut Vault<T0>, arg2: bool, arg3: &0x2::clock::Clock) {
        arg1.is_paused = arg2;
        let v0 = VaultPausedEvent{
            is_paused : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<VaultPausedEvent>(v0);
    }

    public fun settle_game<T0>(arg0: &0xef9d19da80b2728a0c727588a1274a415b3cd18a269afb4f685a13d54844fef0::app::AdminCap, arg1: &mut Vault<T0>, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::clock::Clock) {
        assert!(!arg1.is_paused, 2);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 12);
        assert!(v0 > 0, 12);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v2 < v0) {
            let v5 = *0x1::vector::borrow<address>(&arg2, v2);
            let v6 = *0x1::vector::borrow<u64>(&arg3, v2);
            assert!(0x2::table::contains<address, u64>(&arg1.user_balances, v5), 10);
            let v7 = *0x2::table::borrow<address, u64>(&arg1.user_balances, v5);
            v3 = v3 + v7;
            v4 = v4 + v6;
            *0x2::table::borrow_mut<address, u64>(&mut arg1.user_balances, v5) = v6;
            if (v6 >= v7) {
                let v8 = UserSettlementEvent{
                    user        : v5,
                    old_balance : v7,
                    new_balance : v6,
                    pnl         : v6 - v7,
                    is_profit   : true,
                    timestamp   : v1,
                };
                0x2::event::emit<UserSettlementEvent>(v8);
            } else {
                let v9 = UserSettlementEvent{
                    user        : v5,
                    old_balance : v7,
                    new_balance : v6,
                    pnl         : v7 - v6,
                    is_profit   : false,
                    timestamp   : v1,
                };
                0x2::event::emit<UserSettlementEvent>(v9);
            };
            v2 = v2 + 1;
        };
        let v10 = 0;
        if (v4 <= v3) {
            let v11 = v3 - v4;
            v10 = v11;
            arg1.house_profit_lifetime = arg1.house_profit_lifetime + v11;
        } else {
            arg1.house_loss_lifetime = arg1.house_loss_lifetime + v4 - v3;
            assert!(0x2::balance::value<T0>(&arg1.balance) >= v4, 1);
        };
        let v12 = GameSettlementEvent{
            num_players  : v0,
            house_profit : v10,
            timestamp    : v1,
        };
        0x2::event::emit<GameSettlementEvent>(v12);
    }

    public fun start_game<T0>(arg0: &0xef9d19da80b2728a0c727588a1274a415b3cd18a269afb4f685a13d54844fef0::app::AdminCap, arg1: &mut Vault<T0>, arg2: &0x2::clock::Clock) {
        assert!(!arg1.is_paused, 2);
        assert!(!arg1.active_game, 8);
        arg1.active_game = true;
        let v0 = GameStartedEvent{timestamp: 0x2::clock::timestamp_ms(arg2)};
        0x2::event::emit<GameStartedEvent>(v0);
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &0xef9d19da80b2728a0c727588a1274a415b3cd18a269afb4f685a13d54844fef0::config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.is_paused, 2);
        assert!(!arg0.active_game, 8);
        assert!(arg1 >= 0xef9d19da80b2728a0c727588a1274a415b3cd18a269afb4f685a13d54844fef0::config::get_min_withdraw(arg2), 4);
        assert!(arg1 <= 0xef9d19da80b2728a0c727588a1274a415b3cd18a269afb4f685a13d54844fef0::config::get_max_withdraw(arg2), 6);
        assert!(arg1 > 0, 7);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, u64>(&arg0.user_balances, v0), 10);
        assert!(*0x2::table::borrow<address, u64>(&arg0.user_balances, v0) >= arg1, 10);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = v1 / 86400000;
        if (!0x2::table::contains<address, DailyWithdrawal>(&arg0.user_daily_withdrawals, v0)) {
            let v3 = DailyWithdrawal{
                amount : arg1,
                day    : v2,
            };
            0x2::table::add<address, DailyWithdrawal>(&mut arg0.user_daily_withdrawals, v0, v3);
            assert!(arg1 <= 0xef9d19da80b2728a0c727588a1274a415b3cd18a269afb4f685a13d54844fef0::config::get_max_withdraw_per_day(arg2), 13);
        } else {
            let v4 = 0x2::table::borrow_mut<address, DailyWithdrawal>(&mut arg0.user_daily_withdrawals, v0);
            if (v4.day == v2) {
                let v5 = v4.amount + arg1;
                assert!(v5 <= 0xef9d19da80b2728a0c727588a1274a415b3cd18a269afb4f685a13d54844fef0::config::get_max_withdraw_per_day(arg2), 13);
                v4.amount = v5;
            } else {
                v4.amount = arg1;
                v4.day = v2;
                assert!(arg1 <= 0xef9d19da80b2728a0c727588a1274a415b3cd18a269afb4f685a13d54844fef0::config::get_max_withdraw_per_day(arg2), 13);
            };
        };
        let v6 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_balances, v0);
        *v6 = *v6 - arg1;
        arg0.total_withdrawn = arg0.total_withdrawn + arg1;
        arg0.last_withdraw_at = v1;
        let v7 = WithdrawalEvent{
            user        : v0,
            amount      : arg1,
            new_balance : *v6,
            timestamp   : v1,
        };
        0x2::event::emit<WithdrawalEvent>(v7);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg4)
    }

    public fun withdraw_house_profits<T0>(arg0: &0xef9d19da80b2728a0c727588a1274a415b3cd18a269afb4f685a13d54844fef0::app::AdminCap, arg1: &0xef9d19da80b2728a0c727588a1274a415b3cd18a269afb4f685a13d54844fef0::config::Config, arg2: &mut Vault<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.is_paused, 2);
        assert!(arg3 > 0, 7);
        let v0 = if (arg2.house_profit_lifetime >= arg2.house_loss_lifetime) {
            arg2.house_profit_lifetime - arg2.house_loss_lifetime
        } else {
            0
        };
        assert!(arg3 <= v0, 11);
        assert!(0x2::balance::value<T0>(&arg2.balance) >= arg3, 1);
        arg2.house_profit_lifetime = arg2.house_profit_lifetime - arg3;
        arg2.house_withdrawn_lifetime = arg2.house_withdrawn_lifetime + arg3;
        let v1 = 0xef9d19da80b2728a0c727588a1274a415b3cd18a269afb4f685a13d54844fef0::config::get_admin_address(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.balance, arg3), arg5), v1);
        let v2 = HouseProfitWithdrawalEvent{
            recipient              : v1,
            amount                 : arg3,
            remaining_house_profit : arg2.house_profit_lifetime - arg2.house_loss_lifetime,
            timestamp              : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<HouseProfitWithdrawalEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

