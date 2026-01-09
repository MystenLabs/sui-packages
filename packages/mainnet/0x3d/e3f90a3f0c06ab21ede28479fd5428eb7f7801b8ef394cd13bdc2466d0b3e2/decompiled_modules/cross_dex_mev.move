module 0x3de3f90a3f0c06ab21ede28479fd5428eb7f7801b8ef394cd13bdc2466d0b3e2::cross_dex_mev {
    struct MEVBot has key {
        id: 0x2::object::UID,
        owner: address,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        max_slippage_bps: u64,
        min_profit_bps: u64,
        max_position_age_epochs: u64,
        total_trades: u64,
        total_profit: u64,
        total_loss: u64,
        successful_trades: u64,
    }

    struct Position<phantom T0> has store, key {
        id: 0x2::object::UID,
        bot_id: 0x2::object::ID,
        coin_balance: 0x2::balance::Balance<T0>,
        sui_spent: u64,
        entry_price: u64,
        entry_epoch: u64,
        buy_dex: vector<u8>,
        is_flash_loan: bool,
        flash_amount: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        bot_id: 0x2::object::ID,
    }

    struct FrontrunExecuted has copy, drop {
        bot_id: 0x2::object::ID,
        coin_type: vector<u8>,
        sui_spent: u64,
        tokens_received: u64,
        dex: vector<u8>,
    }

    struct BackrunExecuted has copy, drop {
        bot_id: 0x2::object::ID,
        coin_type: vector<u8>,
        tokens_sold: u64,
        sui_received: u64,
        profit: u64,
        is_profit: bool,
    }

    struct PositionClosed has copy, drop {
        bot_id: 0x2::object::ID,
        coin_type: vector<u8>,
        pnl: u64,
        is_profit: bool,
    }

    struct ArbitrageExecuted has copy, drop {
        bot_id: 0x2::object::ID,
        coin_type: vector<u8>,
        buy_dex: vector<u8>,
        sell_dex: vector<u8>,
        profit: u64,
    }

    public fun backrun<T0>(arg0: &mut MEVBot, arg1: &AdminCap, arg2: Position<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.bot_id == 0x2::object::id<MEVBot>(arg0), 0);
        assert!(arg2.bot_id == 0x2::object::id<MEVBot>(arg0), 0);
        let Position {
            id            : v0,
            bot_id        : _,
            coin_balance  : v2,
            sui_spent     : v3,
            entry_price   : _,
            entry_epoch   : _,
            buy_dex       : v6,
            is_flash_loan : v7,
            flash_amount  : v8,
        } = arg2;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v2);
        let v9 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        let v10 = if (v7 && v8 > 0) {
            let v11 = v8 + v8 * 9 / 10000;
            if (v9 > v11) {
                v9 - v11
            } else {
                0
            }
        } else {
            v9
        };
        let (v12, v13) = if (v10 > v3) {
            (v10 - v3, true)
        } else {
            (v3 - v10, false)
        };
        if (v13) {
            arg0.total_profit = arg0.total_profit + v12;
            arg0.successful_trades = arg0.successful_trades + 1;
        } else {
            arg0.total_loss = arg0.total_loss + v12;
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v14 = BackrunExecuted{
            bot_id       : 0x2::object::id<MEVBot>(arg0),
            coin_type    : v6,
            tokens_sold  : 0,
            sui_received : v9,
            profit       : v12,
            is_profit    : v13,
        };
        0x2::event::emit<BackrunExecuted>(v14);
    }

    public fun calculate_min_output(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 * arg1 / 10000
    }

    public entry fun create_bot(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MEVBot{
            id                      : 0x2::object::new(arg0),
            owner                   : 0x2::tx_context::sender(arg0),
            sui_balance             : 0x2::balance::zero<0x2::sui::SUI>(),
            max_slippage_bps        : 200,
            min_profit_bps          : 10,
            max_position_age_epochs : 20,
            total_trades            : 0,
            total_profit            : 0,
            total_loss              : 0,
            successful_trades       : 0,
        };
        let v1 = AdminCap{
            id     : 0x2::object::new(arg0),
            bot_id : 0x2::object::id<MEVBot>(&v0),
        };
        0x2::transfer::share_object<MEVBot>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun cross_dex_arbitrage<T0>(arg0: &mut MEVBot, arg1: &AdminCap, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.bot_id == 0x2::object::id<MEVBot>(arg0), 0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 > arg2, 4);
        let v1 = v0 - arg2;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        arg0.total_trades = arg0.total_trades + 1;
        arg0.total_profit = arg0.total_profit + v1;
        arg0.successful_trades = arg0.successful_trades + 1;
        let v2 = ArbitrageExecuted{
            bot_id    : 0x2::object::id<MEVBot>(arg0),
            coin_type : arg4,
            buy_dex   : arg4,
            sell_dex  : arg5,
            profit    : v1,
        };
        0x2::event::emit<ArbitrageExecuted>(v2);
    }

    public entry fun deposit_sui(arg0: &mut MEVBot, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun emergency_close<T0>(arg0: &mut MEVBot, arg1: &AdminCap, arg2: Position<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        backrun<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun frontrun<T0>(arg0: &mut MEVBot, arg1: &AdminCap, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Position<T0> {
        assert!(arg1.bot_id == 0x2::object::id<MEVBot>(arg0), 0);
        assert!(arg2 > 0, 5);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= arg2, 1);
        0x2::balance::destroy_zero<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg2));
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = if (v0 > 0) {
            arg2 * 1000000000 / v0
        } else {
            0
        };
        let v2 = Position<T0>{
            id            : 0x2::object::new(arg6),
            bot_id        : 0x2::object::id<MEVBot>(arg0),
            coin_balance  : 0x2::coin::into_balance<T0>(arg3),
            sui_spent     : arg2,
            entry_price   : v1,
            entry_epoch   : 0x2::clock::timestamp_ms(arg5) / 1000,
            buy_dex       : arg4,
            is_flash_loan : false,
            flash_amount  : 0,
        };
        arg0.total_trades = arg0.total_trades + 1;
        let v3 = FrontrunExecuted{
            bot_id          : 0x2::object::id<MEVBot>(arg0),
            coin_type       : arg4,
            sui_spent       : arg2,
            tokens_received : v0,
            dex             : arg4,
        };
        0x2::event::emit<FrontrunExecuted>(v3);
        v2
    }

    public fun frontrun_with_flash<T0>(arg0: &mut MEVBot, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Position<T0> {
        assert!(arg1.bot_id == 0x2::object::id<MEVBot>(arg0), 0);
        let v0 = arg2 + arg3;
        assert!(v0 > 0, 5);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= arg2, 1);
        0x2::balance::destroy_zero<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg2));
        let v1 = 0x2::coin::value<T0>(&arg4);
        let v2 = if (v1 > 0) {
            v0 * 1000000000 / v1
        } else {
            0
        };
        let v3 = Position<T0>{
            id            : 0x2::object::new(arg7),
            bot_id        : 0x2::object::id<MEVBot>(arg0),
            coin_balance  : 0x2::coin::into_balance<T0>(arg4),
            sui_spent     : v0,
            entry_price   : v2,
            entry_epoch   : 0x2::clock::timestamp_ms(arg6) / 1000,
            buy_dex       : arg5,
            is_flash_loan : true,
            flash_amount  : arg3,
        };
        arg0.total_trades = arg0.total_trades + 1;
        let v4 = FrontrunExecuted{
            bot_id          : 0x2::object::id<MEVBot>(arg0),
            coin_type       : arg5,
            sui_spent       : v0,
            tokens_received : v1,
            dex             : arg5,
        };
        0x2::event::emit<FrontrunExecuted>(v4);
        v3
    }

    public fun get_owner(arg0: &MEVBot) : address {
        arg0.owner
    }

    public fun get_position_info<T0>(arg0: &Position<T0>) : (u64, u64, u64, bool, u64) {
        (0x2::balance::value<T0>(&arg0.coin_balance), arg0.sui_spent, arg0.entry_price, arg0.is_flash_loan, arg0.flash_amount)
    }

    public fun get_stats(arg0: &MEVBot) : (u64, u64, u64, u64) {
        (arg0.total_trades, arg0.successful_trades, arg0.total_profit, arg0.total_loss)
    }

    public fun get_sui_balance(arg0: &MEVBot) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)
    }

    public fun is_arbitrage_profitable(arg0: u64, arg1: u64, arg2: u64) : bool {
        if (arg1 <= arg0) {
            return false
        };
        (arg1 - arg0) * 10000 / arg0 >= arg2
    }

    public fun is_position_for_bot<T0>(arg0: &Position<T0>, arg1: &MEVBot) : bool {
        arg0.bot_id == 0x2::object::id<MEVBot>(arg1)
    }

    public entry fun transfer_ownership(arg0: &mut MEVBot, arg1: &AdminCap, arg2: address) {
        assert!(arg1.bot_id == 0x2::object::id<MEVBot>(arg0), 0);
        arg0.owner = arg2;
    }

    public entry fun update_settings(arg0: &mut MEVBot, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg1.bot_id == 0x2::object::id<MEVBot>(arg0), 0);
        assert!(arg2 <= 1000, 4);
        arg0.max_slippage_bps = arg2;
        arg0.min_profit_bps = arg3;
        arg0.max_position_age_epochs = arg4;
    }

    public entry fun withdraw_all_sui(arg0: &mut MEVBot, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.bot_id == 0x2::object::id<MEVBot>(arg0), 0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v0), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun withdraw_sui(arg0: &mut MEVBot, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.bot_id == 0x2::object::id<MEVBot>(arg0), 0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

