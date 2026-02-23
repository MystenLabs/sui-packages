module 0xb3485bf323927a158a71c4ccc6e05a4828bb5d38d1ebf3a6ed312cd052903229::synthetic_market {
    struct SYNTHETIC has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MarketKey has copy, drop, store {
        ticker: 0x1::string::String,
    }

    struct Config has key {
        id: 0x2::object::UID,
        order_counter: u64,
        paused: bool,
    }

    struct Market has store, key {
        id: 0x2::object::UID,
        ticker: 0x1::string::String,
        status: u8,
        yes_supply: 0x2::balance::Supply<SYNTHETIC>,
        no_supply: 0x2::balance::Supply<SYNTHETIC>,
        pending_orders: 0x2::object_bag::ObjectBag,
    }

    struct SyntheticPosition has store, key {
        id: 0x2::object::UID,
        ticker: 0x1::string::String,
        outcome: u8,
        balance: 0x2::balance::Balance<SYNTHETIC>,
    }

    struct PendingSellOrder has store, key {
        id: 0x2::object::UID,
        order_id: u64,
        user: address,
        outcome: u8,
        amount: u64,
        price: u64,
        locked_balance: 0x2::balance::Balance<SYNTHETIC>,
        created_at: u64,
    }

    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        ticker: 0x1::string::String,
    }

    struct PositionMinted has copy, drop {
        position_id: 0x2::object::ID,
        user: address,
        ticker: 0x1::string::String,
        outcome: u8,
        amount: u64,
    }

    struct SellOrderCreated has copy, drop {
        order_id: u64,
        user: address,
        ticker: 0x1::string::String,
        outcome: u8,
        amount: u64,
        price: u64,
    }

    struct SellOrderConfirmed has copy, drop {
        order_id: u64,
        user: address,
        ticker: 0x1::string::String,
        outcome: u8,
        amount: u64,
    }

    struct SellOrderCancelled has copy, drop {
        order_id: u64,
        user: address,
        ticker: 0x1::string::String,
        outcome: u8,
        amount: u64,
    }

    struct MarketResolved has copy, drop {
        ticker: 0x1::string::String,
        winning_outcome: u8,
    }

    struct WinningsRedeemed has copy, drop {
        user: address,
        ticker: 0x1::string::String,
        outcome: u8,
        amount: u64,
    }

    struct ProtocolPaused has copy, drop {
        paused: bool,
    }

    public fun cancel_sell(arg0: &AdminCap, arg1: &mut Market, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object_bag::contains<u64>(&arg1.pending_orders, arg2), 4);
        let PendingSellOrder {
            id             : v0,
            order_id       : _,
            user           : v2,
            outcome        : v3,
            amount         : v4,
            price          : _,
            locked_balance : v6,
            created_at     : _,
        } = 0x2::object_bag::remove<u64, PendingSellOrder>(&mut arg1.pending_orders, arg2);
        0x2::object::delete(v0);
        let v8 = SyntheticPosition{
            id      : 0x2::object::new(arg3),
            ticker  : arg1.ticker,
            outcome : v3,
            balance : v6,
        };
        0x2::transfer::transfer<SyntheticPosition>(v8, v2);
        let v9 = SellOrderCancelled{
            order_id : arg2,
            user     : v2,
            ticker   : arg1.ticker,
            outcome  : v3,
            amount   : v4,
        };
        0x2::event::emit<SellOrderCancelled>(v9);
    }

    public fun confirm_sell(arg0: &AdminCap, arg1: &mut Market, arg2: u64) {
        assert!(0x2::object_bag::contains<u64>(&arg1.pending_orders, arg2), 4);
        let PendingSellOrder {
            id             : v0,
            order_id       : _,
            user           : v2,
            outcome        : v3,
            amount         : v4,
            price          : _,
            locked_balance : v6,
            created_at     : _,
        } = 0x2::object_bag::remove<u64, PendingSellOrder>(&mut arg1.pending_orders, arg2);
        0x2::object::delete(v0);
        if (v3 == 1) {
            0x2::balance::decrease_supply<SYNTHETIC>(&mut arg1.yes_supply, v6);
        } else {
            0x2::balance::decrease_supply<SYNTHETIC>(&mut arg1.no_supply, v6);
        };
        let v8 = SellOrderConfirmed{
            order_id : arg2,
            user     : v2,
            ticker   : arg1.ticker,
            outcome  : v3,
            amount   : v4,
        };
        0x2::event::emit<SellOrderConfirmed>(v8);
    }

    public fun create_market(arg0: &AdminCap, arg1: &mut Config, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketKey{ticker: arg2};
        assert!(!0x2::derived_object::exists<MarketKey>(&arg1.id, v0), 1);
        let v1 = SYNTHETIC{dummy_field: false};
        let v2 = SYNTHETIC{dummy_field: false};
        let v3 = Market{
            id             : 0x2::derived_object::claim<MarketKey>(&mut arg1.id, v0),
            ticker         : arg2,
            status         : 0,
            yes_supply     : 0x2::balance::create_supply<SYNTHETIC>(v1),
            no_supply      : 0x2::balance::create_supply<SYNTHETIC>(v2),
            pending_orders : 0x2::object_bag::new(arg3),
        };
        let v4 = MarketCreated{
            market_id : 0x2::object::id<Market>(&v3),
            ticker    : arg2,
        };
        0x2::event::emit<MarketCreated>(v4);
        0x2::transfer::share_object<Market>(v3);
    }

    public fun get_pending_order_info(arg0: &Market, arg1: u64) : (address, u8, u64, u64, u64) {
        assert!(0x2::object_bag::contains<u64>(&arg0.pending_orders, arg1), 4);
        let v0 = 0x2::object_bag::borrow<u64, PendingSellOrder>(&arg0.pending_orders, arg1);
        (v0.user, v0.outcome, v0.amount, v0.price, v0.created_at)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id            : 0x2::object::new(arg0),
            order_counter : 0,
            paused        : false,
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_market_active(arg0: &Market) : bool {
        arg0.status == 0
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun market_no_supply(arg0: &Market) : u64 {
        0x2::balance::supply_value<SYNTHETIC>(&arg0.no_supply)
    }

    public fun market_status(arg0: &Market) : u8 {
        arg0.status
    }

    public fun market_ticker(arg0: &Market) : 0x1::string::String {
        arg0.ticker
    }

    public fun market_yes_supply(arg0: &Market) : u64 {
        0x2::balance::supply_value<SYNTHETIC>(&arg0.yes_supply)
    }

    public fun merge_positions(arg0: &mut SyntheticPosition, arg1: SyntheticPosition) {
        assert!(arg0.ticker == arg1.ticker, 7);
        assert!(arg0.outcome == arg1.outcome, 7);
        let SyntheticPosition {
            id      : v0,
            ticker  : _,
            outcome : _,
            balance : v3,
        } = arg1;
        0x2::object::delete(v0);
        0x2::balance::join<SYNTHETIC>(&mut arg0.balance, v3);
    }

    public fun order_counter(arg0: &Config) : u64 {
        arg0.order_counter
    }

    public fun pending_order_exists(arg0: &Market, arg1: u64) : bool {
        0x2::object_bag::contains<u64>(&arg0.pending_orders, arg1)
    }

    public fun position_amount(arg0: &SyntheticPosition) : u64 {
        0x2::balance::value<SYNTHETIC>(&arg0.balance)
    }

    public fun position_outcome(arg0: &SyntheticPosition) : u8 {
        arg0.outcome
    }

    public fun position_ticker(arg0: &SyntheticPosition) : 0x1::string::String {
        arg0.ticker
    }

    public fun redeem_winning(arg0: &mut Market, arg1: SyntheticPosition, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.outcome == 1 && arg0.status == 1 || arg1.outcome == 0 && arg0.status == 2, 3);
        assert!(arg1.ticker == arg0.ticker, 7);
        let v0 = 0x2::balance::value<SYNTHETIC>(&arg1.balance);
        assert!(v0 > 0, 5);
        let v1 = arg1.outcome;
        let SyntheticPosition {
            id      : v2,
            ticker  : _,
            outcome : _,
            balance : v5,
        } = arg1;
        0x2::object::delete(v2);
        if (v1 == 1) {
            0x2::balance::decrease_supply<SYNTHETIC>(&mut arg0.yes_supply, v5);
        } else {
            0x2::balance::decrease_supply<SYNTHETIC>(&mut arg0.no_supply, v5);
        };
        let v6 = WinningsRedeemed{
            user    : 0x2::tx_context::sender(arg2),
            ticker  : arg0.ticker,
            outcome : v1,
            amount  : v0,
        };
        0x2::event::emit<WinningsRedeemed>(v6);
    }

    public fun redeem_winning_partial(arg0: &mut Market, arg1: &mut SyntheticPosition, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.outcome == 1 && arg0.status == 1 || arg1.outcome == 0 && arg0.status == 2, 3);
        assert!(arg1.ticker == arg0.ticker, 7);
        assert!(arg2 > 0, 5);
        assert!(0x2::balance::value<SYNTHETIC>(&arg1.balance) >= arg2, 8);
        let v0 = arg1.outcome;
        if (v0 == 1) {
            0x2::balance::decrease_supply<SYNTHETIC>(&mut arg0.yes_supply, 0x2::balance::split<SYNTHETIC>(&mut arg1.balance, arg2));
        } else {
            0x2::balance::decrease_supply<SYNTHETIC>(&mut arg0.no_supply, 0x2::balance::split<SYNTHETIC>(&mut arg1.balance, arg2));
        };
        let v1 = WinningsRedeemed{
            user    : 0x2::tx_context::sender(arg3),
            ticker  : arg0.ticker,
            outcome : v0,
            amount  : arg2,
        };
        0x2::event::emit<WinningsRedeemed>(v1);
    }

    public fun resolve_market(arg0: &AdminCap, arg1: &mut Market, arg2: u8) {
        assert!(arg2 == 0 || arg2 == 1, 0);
        assert!(arg1.status == 0, 2);
        let v0 = if (arg2 == 1) {
            1
        } else {
            2
        };
        arg1.status = v0;
        let v1 = MarketResolved{
            ticker          : arg1.ticker,
            winning_outcome : arg2,
        };
        0x2::event::emit<MarketResolved>(v1);
    }

    public fun sell_position(arg0: &mut Config, arg1: &mut Market, arg2: &0x2::clock::Clock, arg3: SyntheticPosition, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(!arg0.paused, 6);
        assert!(arg1.status == 0, 2);
        assert!(arg3.ticker == arg1.ticker, 7);
        let v0 = 0x2::balance::value<SYNTHETIC>(&arg3.balance);
        assert!(v0 > 0, 5);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = arg3.outcome;
        let SyntheticPosition {
            id      : v3,
            ticker  : _,
            outcome : _,
            balance : v6,
        } = arg3;
        0x2::object::delete(v3);
        arg0.order_counter = arg0.order_counter + 1;
        let v7 = arg0.order_counter;
        let v8 = PendingSellOrder{
            id             : 0x2::object::new(arg5),
            order_id       : v7,
            user           : v1,
            outcome        : v2,
            amount         : v0,
            price          : arg4,
            locked_balance : v6,
            created_at     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::object_bag::add<u64, PendingSellOrder>(&mut arg1.pending_orders, v7, v8);
        let v9 = SellOrderCreated{
            order_id : v7,
            user     : v1,
            ticker   : arg1.ticker,
            outcome  : v2,
            amount   : v0,
            price    : arg4,
        };
        0x2::event::emit<SellOrderCreated>(v9);
        v7
    }

    public fun sell_position_partial(arg0: &mut Config, arg1: &mut Market, arg2: &0x2::clock::Clock, arg3: &mut SyntheticPosition, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(!arg0.paused, 6);
        assert!(arg1.status == 0, 2);
        assert!(arg3.ticker == arg1.ticker, 7);
        assert!(arg4 > 0, 5);
        assert!(0x2::balance::value<SYNTHETIC>(&arg3.balance) >= arg4, 8);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = arg3.outcome;
        arg0.order_counter = arg0.order_counter + 1;
        let v2 = arg0.order_counter;
        let v3 = PendingSellOrder{
            id             : 0x2::object::new(arg6),
            order_id       : v2,
            user           : v0,
            outcome        : v1,
            amount         : arg4,
            price          : arg5,
            locked_balance : 0x2::balance::split<SYNTHETIC>(&mut arg3.balance, arg4),
            created_at     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::object_bag::add<u64, PendingSellOrder>(&mut arg1.pending_orders, v2, v3);
        let v4 = SellOrderCreated{
            order_id : v2,
            user     : v0,
            ticker   : arg1.ticker,
            outcome  : v1,
            amount   : arg4,
            price    : arg5,
        };
        0x2::event::emit<SellOrderCreated>(v4);
        v2
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
        let v0 = ProtocolPaused{paused: arg2};
        0x2::event::emit<ProtocolPaused>(v0);
    }

    public fun settle_order(arg0: &AdminCap, arg1: &Config, arg2: &mut Market, arg3: address, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 6);
        assert!(arg2.status == 0, 2);
        assert!(arg4 == 0 || arg4 == 1, 0);
        assert!(arg5 > 0, 5);
        let v0 = if (arg4 == 1) {
            0x2::balance::increase_supply<SYNTHETIC>(&mut arg2.yes_supply, arg5)
        } else {
            0x2::balance::increase_supply<SYNTHETIC>(&mut arg2.no_supply, arg5)
        };
        let v1 = SyntheticPosition{
            id      : 0x2::object::new(arg6),
            ticker  : arg2.ticker,
            outcome : arg4,
            balance : v0,
        };
        let v2 = PositionMinted{
            position_id : 0x2::object::id<SyntheticPosition>(&v1),
            user        : arg3,
            ticker      : arg2.ticker,
            outcome     : arg4,
            amount      : arg5,
        };
        0x2::event::emit<PositionMinted>(v2);
        0x2::transfer::transfer<SyntheticPosition>(v1, arg3);
    }

    public fun split_position(arg0: &mut SyntheticPosition, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : SyntheticPosition {
        assert!(arg1 > 0, 5);
        assert!(0x2::balance::value<SYNTHETIC>(&arg0.balance) > arg1, 8);
        SyntheticPosition{
            id      : 0x2::object::new(arg2),
            ticker  : arg0.ticker,
            outcome : arg0.outcome,
            balance : 0x2::balance::split<SYNTHETIC>(&mut arg0.balance, arg1),
        }
    }

    public fun transfer_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun winning_outcome(arg0: &Market) : u8 {
        if (arg0.status == 1) {
            1
        } else if (arg0.status == 2) {
            0
        } else {
            255
        }
    }

    // decompiled from Move bytecode v6
}

