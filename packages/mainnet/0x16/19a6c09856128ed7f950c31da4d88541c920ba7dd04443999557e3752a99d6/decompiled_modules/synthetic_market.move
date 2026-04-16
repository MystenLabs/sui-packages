module 0xf6a8bc8c95f2e23bf90075d2f33f6775b0eca3828305e88000c525bdb0e072e9::synthetic_market {
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

    struct Market<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        ticker: 0x1::string::String,
        yes_coin_type: 0x1::string::String,
        no_coin_type: 0x1::string::String,
        status: u8,
        yes_supply: 0x2::balance::Supply<T0>,
        no_supply: 0x2::balance::Supply<T1>,
        pending_orders: 0x2::object_bag::ObjectBag,
    }

    struct PendingSellOrder<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        order_id: u64,
        user: address,
        outcome: u8,
        amount: u64,
        price: u64,
        locked_yes: 0x1::option::Option<0x2::coin::Coin<T0>>,
        locked_no: 0x1::option::Option<0x2::coin::Coin<T1>>,
        created_at: u64,
    }

    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        ticker: 0x1::string::String,
        yes_coin_type: 0x1::string::String,
        no_coin_type: 0x1::string::String,
    }

    struct PositionMinted has copy, drop {
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

    struct MarketClosed has copy, drop {
        ticker: 0x1::string::String,
    }

    struct MarketDetermined has copy, drop {
        ticker: 0x1::string::String,
        winning_outcome: u8,
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

    public fun cancel_sell<T0, T1>(arg0: &AdminCap, arg1: &mut Market<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object_bag::contains<u64>(&arg1.pending_orders, arg2), 4);
        let PendingSellOrder {
            id         : v0,
            order_id   : _,
            user       : v2,
            outcome    : v3,
            amount     : v4,
            price      : _,
            locked_yes : v6,
            locked_no  : v7,
            created_at : _,
        } = 0x2::object_bag::remove<u64, PendingSellOrder<T0, T1>>(&mut arg1.pending_orders, arg2);
        0x2::object::delete(v0);
        if (v3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::destroy_some<0x2::coin::Coin<T0>>(v6), v2);
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x1::option::destroy_some<0x2::coin::Coin<T1>>(v7), v2);
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(v6);
        };
        let v9 = SellOrderCancelled{
            order_id : arg2,
            user     : v2,
            ticker   : arg1.ticker,
            outcome  : v3,
            amount   : v4,
        };
        0x2::event::emit<SellOrderCancelled>(v9);
    }

    public fun close_market<T0, T1>(arg0: &AdminCap, arg1: &mut Market<T0, T1>) {
        assert!(arg1.status == 0, 2);
        arg1.status = 3;
        let v0 = MarketClosed{ticker: arg1.ticker};
        0x2::event::emit<MarketClosed>(v0);
    }

    public fun confirm_sell<T0, T1>(arg0: &AdminCap, arg1: &mut Market<T0, T1>, arg2: u64) {
        assert!(0x2::object_bag::contains<u64>(&arg1.pending_orders, arg2), 4);
        let PendingSellOrder {
            id         : v0,
            order_id   : _,
            user       : v2,
            outcome    : v3,
            amount     : v4,
            price      : _,
            locked_yes : v6,
            locked_no  : v7,
            created_at : _,
        } = 0x2::object_bag::remove<u64, PendingSellOrder<T0, T1>>(&mut arg1.pending_orders, arg2);
        0x2::object::delete(v0);
        if (v3 == 0) {
            0x2::balance::decrease_supply<T0>(&mut arg1.yes_supply, 0x2::coin::into_balance<T0>(0x1::option::destroy_some<0x2::coin::Coin<T0>>(v6)));
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(v7);
        } else {
            0x2::balance::decrease_supply<T1>(&mut arg1.no_supply, 0x2::coin::into_balance<T1>(0x1::option::destroy_some<0x2::coin::Coin<T1>>(v7)));
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(v6);
        };
        let v9 = SellOrderConfirmed{
            order_id : arg2,
            user     : v2,
            ticker   : arg1.ticker,
            outcome  : v3,
            amount   : v4,
        };
        0x2::event::emit<SellOrderConfirmed>(v9);
    }

    public fun create_market<T0, T1>(arg0: &AdminCap, arg1: &mut Config, arg2: 0x1::string::String, arg3: 0x2::coin::TreasuryCap<T0>, arg4: 0x2::coin::TreasuryCap<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketKey{ticker: arg2};
        assert!(!0x2::derived_object::exists<MarketKey>(&arg1.id, v0), 1);
        let v1 = Market<T0, T1>{
            id             : 0x2::derived_object::claim<MarketKey>(&mut arg1.id, v0),
            ticker         : arg2,
            yes_coin_type  : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            no_coin_type   : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())),
            status         : 0,
            yes_supply     : 0x2::coin::treasury_into_supply<T0>(arg3),
            no_supply      : 0x2::coin::treasury_into_supply<T1>(arg4),
            pending_orders : 0x2::object_bag::new(arg5),
        };
        let v2 = MarketCreated{
            market_id     : 0x2::object::id<Market<T0, T1>>(&v1),
            ticker        : arg2,
            yes_coin_type : v1.yes_coin_type,
            no_coin_type  : v1.no_coin_type,
        };
        0x2::event::emit<MarketCreated>(v2);
        0x2::transfer::share_object<Market<T0, T1>>(v1);
    }

    public fun determine_market<T0, T1>(arg0: &AdminCap, arg1: &mut Market<T0, T1>, arg2: u8) {
        assert!(arg1.status == 3, 8);
        assert!(arg2 == 0 || arg2 == 1, 0);
        let v0 = if (arg2 == 0) {
            4
        } else {
            5
        };
        arg1.status = v0;
        let v1 = MarketDetermined{
            ticker          : arg1.ticker,
            winning_outcome : arg2,
        };
        0x2::event::emit<MarketDetermined>(v1);
    }

    public fun get_pending_order_info<T0, T1>(arg0: &Market<T0, T1>, arg1: u64) : (address, u8, u64, u64, u64) {
        assert!(0x2::object_bag::contains<u64>(&arg0.pending_orders, arg1), 4);
        let v0 = 0x2::object_bag::borrow<u64, PendingSellOrder<T0, T1>>(&arg0.pending_orders, arg1);
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

    public fun is_market_active<T0, T1>(arg0: &Market<T0, T1>) : bool {
        arg0.status == 0
    }

    public fun is_market_closed<T0, T1>(arg0: &Market<T0, T1>) : bool {
        arg0.status == 3
    }

    public fun is_market_determined<T0, T1>(arg0: &Market<T0, T1>) : bool {
        arg0.status == 4 || arg0.status == 5
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun market_status<T0, T1>(arg0: &Market<T0, T1>) : u8 {
        arg0.status
    }

    public fun market_ticker<T0, T1>(arg0: &Market<T0, T1>) : 0x1::string::String {
        arg0.ticker
    }

    public fun no_coin_type<T0, T1>(arg0: &Market<T0, T1>) : 0x1::string::String {
        arg0.no_coin_type
    }

    public fun no_supply<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        0x2::balance::supply_value<T1>(&arg0.no_supply)
    }

    public fun order_counter(arg0: &Config) : u64 {
        arg0.order_counter
    }

    public fun pending_order_exists<T0, T1>(arg0: &Market<T0, T1>, arg1: u64) : bool {
        0x2::object_bag::contains<u64>(&arg0.pending_orders, arg1)
    }

    public fun redeem_winning<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x1::option::Option<0x2::coin::Coin<T0>>, arg2: 0x1::option::Option<0x2::coin::Coin<T1>>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 == 0 && arg0.status == 1 || arg3 == 1 && arg0.status == 2, 3);
        let v0 = if (arg3 == 0) {
            0x2::coin::value<T0>(0x1::option::borrow<0x2::coin::Coin<T0>>(&arg1))
        } else {
            0x2::coin::value<T1>(0x1::option::borrow<0x2::coin::Coin<T1>>(&arg2))
        };
        assert!(v0 > 0, 5);
        if (arg3 == 0) {
            0x2::balance::decrease_supply<T0>(&mut arg0.yes_supply, 0x2::coin::into_balance<T0>(0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg1)));
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg2);
        } else {
            0x2::balance::decrease_supply<T1>(&mut arg0.no_supply, 0x2::coin::into_balance<T1>(0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg2)));
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg1);
        };
        let v1 = WinningsRedeemed{
            user    : 0x2::tx_context::sender(arg4),
            ticker  : arg0.ticker,
            outcome : arg3,
            amount  : v0,
        };
        0x2::event::emit<WinningsRedeemed>(v1);
    }

    public fun resolve_market<T0, T1>(arg0: &AdminCap, arg1: &mut Market<T0, T1>) {
        assert!(arg1.status == 4 || arg1.status == 5, 9);
        let v0 = if (arg1.status == 4) {
            0
        } else {
            1
        };
        let v1 = if (v0 == 0) {
            1
        } else {
            2
        };
        arg1.status = v1;
        let v2 = MarketResolved{
            ticker          : arg1.ticker,
            winning_outcome : v0,
        };
        0x2::event::emit<MarketResolved>(v2);
    }

    public fun sell_position<T0, T1>(arg0: &mut Config, arg1: &mut Market<T0, T1>, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<0x2::coin::Coin<T0>>, arg4: 0x1::option::Option<0x2::coin::Coin<T1>>, arg5: u8, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(!arg0.paused, 6);
        assert!(arg1.status == 0, 2);
        assert!(arg5 == 0 || arg5 == 1, 0);
        let v0 = if (arg5 == 0) {
            0x2::coin::value<T0>(0x1::option::borrow<0x2::coin::Coin<T0>>(&arg3))
        } else {
            0x2::coin::value<T1>(0x1::option::borrow<0x2::coin::Coin<T1>>(&arg4))
        };
        assert!(v0 > 0, 5);
        arg0.order_counter = arg0.order_counter + 1;
        let v1 = arg0.order_counter;
        let v2 = 0x2::tx_context::sender(arg7);
        let v3 = PendingSellOrder<T0, T1>{
            id         : 0x2::object::new(arg7),
            order_id   : v1,
            user       : v2,
            outcome    : arg5,
            amount     : v0,
            price      : arg6,
            locked_yes : arg3,
            locked_no  : arg4,
            created_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::object_bag::add<u64, PendingSellOrder<T0, T1>>(&mut arg1.pending_orders, v1, v3);
        let v4 = SellOrderCreated{
            order_id : v1,
            user     : v2,
            ticker   : arg1.ticker,
            outcome  : arg5,
            amount   : v0,
            price    : arg6,
        };
        0x2::event::emit<SellOrderCreated>(v4);
        v1
    }

    public fun sell_position_partial<T0, T1>(arg0: &mut Config, arg1: &mut Market<T0, T1>, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<0x2::coin::Coin<T0>>, arg4: 0x1::option::Option<0x2::coin::Coin<T1>>, arg5: u8, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(!arg0.paused, 6);
        assert!(arg1.status == 0, 2);
        assert!(arg5 == 0 || arg5 == 1, 0);
        assert!(arg6 > 0, 5);
        arg0.order_counter = arg0.order_counter + 1;
        let v0 = arg0.order_counter;
        let v1 = 0x2::tx_context::sender(arg8);
        if (arg5 == 0) {
            let v2 = 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg3);
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg4);
            assert!(0x2::coin::value<T0>(&v2) >= arg6, 7);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v1);
            let v3 = PendingSellOrder<T0, T1>{
                id         : 0x2::object::new(arg8),
                order_id   : v0,
                user       : v1,
                outcome    : arg5,
                amount     : arg6,
                price      : arg7,
                locked_yes : 0x1::option::some<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v2, arg6, arg8)),
                locked_no  : 0x1::option::none<0x2::coin::Coin<T1>>(),
                created_at : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::object_bag::add<u64, PendingSellOrder<T0, T1>>(&mut arg1.pending_orders, v0, v3);
        } else {
            let v4 = 0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg4);
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg3);
            assert!(0x2::coin::value<T1>(&v4) >= arg6, 7);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, v1);
            let v5 = PendingSellOrder<T0, T1>{
                id         : 0x2::object::new(arg8),
                order_id   : v0,
                user       : v1,
                outcome    : arg5,
                amount     : arg6,
                price      : arg7,
                locked_yes : 0x1::option::none<0x2::coin::Coin<T0>>(),
                locked_no  : 0x1::option::some<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v4, arg6, arg8)),
                created_at : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::object_bag::add<u64, PendingSellOrder<T0, T1>>(&mut arg1.pending_orders, v0, v5);
        };
        let v6 = SellOrderCreated{
            order_id : v0,
            user     : v1,
            ticker   : arg1.ticker,
            outcome  : arg5,
            amount   : arg6,
            price    : arg7,
        };
        0x2::event::emit<SellOrderCreated>(v6);
        v0
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
        let v0 = ProtocolPaused{paused: arg2};
        0x2::event::emit<ProtocolPaused>(v0);
    }

    public fun settle_order<T0, T1>(arg0: &AdminCap, arg1: &Config, arg2: &mut Market<T0, T1>, arg3: address, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 6);
        assert!(arg2.status == 0, 2);
        assert!(arg4 == 1 || arg4 == 0, 0);
        assert!(arg5 > 0, 5);
        if (arg4 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::increase_supply<T0>(&mut arg2.yes_supply, arg5), arg6), arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::increase_supply<T1>(&mut arg2.no_supply, arg5), arg6), arg3);
        };
        let v0 = PositionMinted{
            user    : arg3,
            ticker  : arg2.ticker,
            outcome : arg4,
            amount  : arg5,
        };
        0x2::event::emit<PositionMinted>(v0);
    }

    public fun transfer_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun winning_outcome<T0, T1>(arg0: &Market<T0, T1>) : u8 {
        if (arg0.status == 1) {
            0
        } else if (arg0.status == 2) {
            1
        } else {
            255
        }
    }

    public fun yes_coin_type<T0, T1>(arg0: &Market<T0, T1>) : 0x1::string::String {
        arg0.yes_coin_type
    }

    public fun yes_supply<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        0x2::balance::supply_value<T0>(&arg0.yes_supply)
    }

    // decompiled from Move bytecode v6
}

