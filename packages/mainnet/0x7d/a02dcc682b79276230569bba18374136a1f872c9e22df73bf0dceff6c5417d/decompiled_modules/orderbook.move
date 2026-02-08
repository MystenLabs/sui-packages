module 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook {
    struct DepositKey has copy, drop, store {
        order_id: u64,
    }

    struct Order has copy, drop, store {
        order_id: u64,
        owner: address,
        side: u8,
        amount: u64,
        rate: u64,
        timestamp: u64,
        is_active: bool,
    }

    struct OrderBook<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        duration_bucket: u64,
        risk_tier: u8,
        max_ltv_bps: u64,
        orders: 0x2::table::Table<u64, Order>,
        next_order_id: u64,
        total_bids: u64,
        total_asks: u64,
        min_order_amount: u64,
        is_active: bool,
    }

    struct OrderPlaced has copy, drop {
        book_id: 0x2::object::ID,
        order_id: u64,
        owner: address,
        side: u8,
        amount: u64,
        rate: u64,
        timestamp: u64,
    }

    struct OrderCancelled has copy, drop {
        book_id: 0x2::object::ID,
        order_id: u64,
        owner: address,
    }

    struct OrderMatched has copy, drop {
        book_id: 0x2::object::ID,
        lend_order_id: u64,
        borrow_order_id: u64,
        matched_amount: u64,
        rate: u64,
        lender: address,
        borrower: address,
    }

    public(friend) fun new<T0, T1>(arg0: u64, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : OrderBook<T0, T1> {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 604800) {
            true
        } else if (arg0 == 2592000) {
            true
        } else {
            arg0 == 7776000
        };
        assert!(v0, 101);
        assert!(arg1 == 0 || arg1 == 1, 110);
        OrderBook<T0, T1>{
            id               : 0x2::object::new(arg3),
            duration_bucket  : arg0,
            risk_tier        : arg1,
            max_ltv_bps      : arg2,
            orders           : 0x2::table::new<u64, Order>(arg3),
            next_order_id    : 0,
            total_bids       : 0,
            total_asks       : 0,
            min_order_amount : 1000,
            is_active        : true,
        }
    }

    public(friend) fun add_order<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: address) : u64 {
        assert!(arg0.is_active, 107);
        assert!(arg1 == 0 || arg1 == 1, 100);
        assert!(arg2 >= arg0.min_order_amount, 103);
        assert!(arg3 > 0 && arg3 <= 10000, 102);
        let v0 = arg0.next_order_id;
        arg0.next_order_id = arg0.next_order_id + 1;
        let v1 = Order{
            order_id  : v0,
            owner     : arg5,
            side      : arg1,
            amount    : arg2,
            rate      : arg3,
            timestamp : arg4,
            is_active : true,
        };
        0x2::table::add<u64, Order>(&mut arg0.orders, v0, v1);
        if (arg1 == 0) {
            arg0.total_asks = arg0.total_asks + 1;
        } else {
            arg0.total_bids = arg0.total_bids + 1;
        };
        let v2 = OrderPlaced{
            book_id   : 0x2::object::id<OrderBook<T0, T1>>(arg0),
            order_id  : v0,
            owner     : arg5,
            side      : arg1,
            amount    : arg2,
            rate      : arg3,
            timestamp : arg4,
        };
        0x2::event::emit<OrderPlaced>(v2);
        v0
    }

    public fun borrow_order<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u64) : &Order {
        assert!(0x2::table::contains<u64, Order>(&arg0.orders, arg1), 104);
        0x2::table::borrow<u64, Order>(&arg0.orders, arg1)
    }

    public fun duration_bucket<T0, T1>(arg0: &OrderBook<T0, T1>) : u64 {
        arg0.duration_bucket
    }

    public(friend) fun execute_match<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: u64, arg2: u64) : (u64, u64, u64, u64, address, address, u64) {
        let (v0, v1, v2, v3, v4, v5) = validate_and_match_internal<T0, T1>(arg0, arg1, arg2);
        (v0, v1, v2, v3, v4, v5, v0 * 10000 / arg0.max_ltv_bps)
    }

    public(friend) fun execute_match_priced<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock) : (u64, u64, u64, u64, address, address, u64) {
        let (v0, v1, v2, v3, v4, v5) = validate_and_match_internal<T0, T1>(arg0, arg1, arg2);
        (v0, v1, v2, v3, v4, v5, (((v0 as u128) * (1000000000 as u128) * (10000 as u128) / (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T1, T0>(arg3, arg4) as u128) * (arg0.max_ltv_bps as u128)) as u64))
    }

    public(friend) fun execute_match_priced_inverse<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) : (u64, u64, u64, u64, address, address, u64) {
        let (v0, v1, v2, v3, v4, v5) = validate_and_match_internal<T0, T1>(arg0, arg1, arg2);
        (v0, v1, v2, v3, v4, v5, (((v0 as u128) * (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg3, arg4) as u128) * (10000 as u128) / (1000000000 as u128) * (arg0.max_ltv_bps as u128)) as u64))
    }

    public fun has_active_order<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u64) : bool {
        if (!0x2::table::contains<u64, Order>(&arg0.orders, arg1)) {
            return false
        };
        0x2::table::borrow<u64, Order>(&arg0.orders, arg1).is_active
    }

    public fun has_deposit<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u64) : bool {
        let v0 = DepositKey{order_id: arg1};
        0x2::dynamic_field::exists_<DepositKey>(&arg0.id, v0)
    }

    public fun is_active<T0, T1>(arg0: &OrderBook<T0, T1>) : bool {
        arg0.is_active
    }

    public fun max_ltv_bps<T0, T1>(arg0: &OrderBook<T0, T1>) : u64 {
        arg0.max_ltv_bps
    }

    public fun min_order_amount<T0, T1>(arg0: &OrderBook<T0, T1>) : u64 {
        arg0.min_order_amount
    }

    public fun next_order_id<T0, T1>(arg0: &OrderBook<T0, T1>) : u64 {
        arg0.next_order_id
    }

    public fun order_amount(arg0: &Order) : u64 {
        arg0.amount
    }

    public fun order_id(arg0: &Order) : u64 {
        arg0.order_id
    }

    public fun order_is_active(arg0: &Order) : bool {
        arg0.is_active
    }

    public fun order_owner(arg0: &Order) : address {
        arg0.owner
    }

    public fun order_rate(arg0: &Order) : u64 {
        arg0.rate
    }

    public fun order_side(arg0: &Order) : u8 {
        arg0.side
    }

    public fun order_timestamp(arg0: &Order) : u64 {
        arg0.timestamp
    }

    public(friend) fun remove_order<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: u64, arg2: address) {
        assert!(0x2::table::contains<u64, Order>(&arg0.orders, arg1), 104);
        let v0 = 0x2::table::borrow_mut<u64, Order>(&mut arg0.orders, arg1);
        assert!(v0.owner == arg2, 105);
        assert!(v0.is_active, 106);
        v0.is_active = false;
        if (v0.side == 0) {
            arg0.total_asks = arg0.total_asks - 1;
        } else {
            arg0.total_bids = arg0.total_bids - 1;
        };
        let v1 = OrderCancelled{
            book_id  : 0x2::object::id<OrderBook<T0, T1>>(arg0),
            order_id : arg1,
            owner    : arg2,
        };
        0x2::event::emit<OrderCancelled>(v1);
    }

    public fun risk_tier<T0, T1>(arg0: &OrderBook<T0, T1>) : u8 {
        arg0.risk_tier
    }

    public(friend) fun share<T0, T1>(arg0: OrderBook<T0, T1>) {
        0x2::transfer::share_object<OrderBook<T0, T1>>(arg0);
    }

    public(friend) fun store_deposit<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: u64, arg2: 0x2::balance::Balance<T0>) {
        let v0 = DepositKey{order_id: arg1};
        0x2::dynamic_field::add<DepositKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, arg2);
    }

    public fun total_asks<T0, T1>(arg0: &OrderBook<T0, T1>) : u64 {
        arg0.total_asks
    }

    public fun total_bids<T0, T1>(arg0: &OrderBook<T0, T1>) : u64 {
        arg0.total_bids
    }

    fun validate_and_match_internal<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: u64, arg2: u64) : (u64, u64, u64, u64, address, address) {
        assert!(0x2::table::contains<u64, Order>(&arg0.orders, arg1), 104);
        assert!(0x2::table::contains<u64, Order>(&arg0.orders, arg2), 104);
        let v0 = *0x2::table::borrow<u64, Order>(&arg0.orders, arg1);
        let v1 = *0x2::table::borrow<u64, Order>(&arg0.orders, arg2);
        assert!(v0.is_active, 106);
        assert!(v1.is_active, 106);
        assert!(v0.owner != v1.owner, 108);
        assert!(v0.side != v1.side, 100);
        let (v2, v3) = if (v0.side == 0) {
            (v0, v1)
        } else {
            (v1, v0)
        };
        let v4 = v3;
        let v5 = v2;
        assert!(v5.rate <= v4.rate, 109);
        let v6 = if (v5.amount < v4.amount) {
            v5.amount
        } else {
            v4.amount
        };
        let v7 = v1.rate;
        0x2::table::borrow_mut<u64, Order>(&mut arg0.orders, arg1).is_active = false;
        0x2::table::borrow_mut<u64, Order>(&mut arg0.orders, arg2).is_active = false;
        arg0.total_asks = arg0.total_asks - 1;
        arg0.total_bids = arg0.total_bids - 1;
        let v8 = OrderMatched{
            book_id         : 0x2::object::id<OrderBook<T0, T1>>(arg0),
            lend_order_id   : v5.order_id,
            borrow_order_id : v4.order_id,
            matched_amount  : v6,
            rate            : v7,
            lender          : v5.owner,
            borrower        : v4.owner,
        };
        0x2::event::emit<OrderMatched>(v8);
        (v6, v7, v5.order_id, v4.order_id, v5.owner, v4.owner)
    }

    public(friend) fun withdraw_deposit<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = DepositKey{order_id: arg1};
        0x2::dynamic_field::remove<DepositKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v0)
    }

    // decompiled from Move bytecode v6
}

