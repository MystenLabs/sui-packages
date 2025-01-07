module 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::book {
    struct Order has drop, store {
        market_id: 0x2::object::ID,
        trader: address,
        order_id: u128,
        origin_balance: u64,
        remain_balance: u64,
        filled_balance: u64,
        is_bid: bool,
        nft_id: 0x1::option::Option<0x2::object::ID>,
        price: u64,
        match_price: u64,
        ord_type: u8,
        status: u8,
        expire_timestamp: u64,
        fill_mode: u8,
    }

    struct OrderEvent has copy, drop, store {
        market: 0x2::object::ID,
        order_id: u128,
        nft_id: 0x1::option::Option<0x2::object::ID>,
        is_bid: bool,
        is_taker: bool,
        ord_type: u8,
        qty: u64,
        price: u64,
        state: u8,
    }

    struct OrderInfo has drop, store {
        market_id: 0x2::object::ID,
        trader: address,
        balance: u64,
        is_bid: bool,
        nft_id: 0x1::option::Option<0x2::object::ID>,
        price: u64,
        ord_type: u8,
        fill_mode: u8,
        expire_timestamp: u64,
    }

    struct Fill has copy, drop, store {
        taker_is_bid: bool,
        taker_id: u128,
        taker: address,
        maker_id: u128,
        maker: address,
        exec_price: u64,
        exec_qty: u64,
        taker_fee: u64,
        maker_fee: u64,
        expired: bool,
        completed: bool,
        nft_id: 0x2::object::ID,
    }

    struct TradeProof {
        taker: address,
        taker_fee: u64,
        maker_fee: u64,
        fills: vector<Fill>,
        delist: vector<u128>,
        fill_limit_reached: bool,
        order_id: u128,
        inject: bool,
        remain_balance: u64,
        exec_balance: u64,
        taker_is_bid: bool,
        taker_nft: 0x1::option::Option<0x2::object::ID>,
        taker_status: u8,
    }

    struct Book has store {
        taker_fee: u64,
        maker_fee: u64,
        tick_size: u64,
        min_size: u64,
        asks: 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::big_vector::BigVector<Order>,
        bids: 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::big_vector::BigVector<Order>,
        next_bid_order_id: u64,
        next_ask_order_id: u64,
    }

    public(friend) fun empty(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Book {
        Book{
            taker_fee         : arg0,
            maker_fee         : arg1,
            tick_size         : arg2,
            min_size          : arg3,
            asks              : 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::big_vector::empty<Order>(0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::max_slice_size(), 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::max_fan_out(), arg4),
            bids              : 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::big_vector::empty<Order>(0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::max_slice_size(), 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::max_fan_out(), arg4),
            next_bid_order_id : 18446744073709551615,
            next_ask_order_id : 1,
        }
    }

    public fun asks(arg0: &Book) : &0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::big_vector::BigVector<Order> {
        &arg0.asks
    }

    fun assert_inject_order(arg0: &Order, arg1: &TradeProof) : bool {
        arg0.ord_type == 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::ord_market() || arg0.status >= 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::filled() || arg1.fill_limit_reached
    }

    public fun bids(arg0: &Book) : &0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::big_vector::BigVector<Order> {
        &arg0.bids
    }

    public fun bill_info(arg0: &TradeProof) : (&vector<Fill>, u64, u64) {
        (&arg0.fills, arg0.taker_fee, arg0.maker_fee)
    }

    fun book_side(arg0: &Book, arg1: u128) : &0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::big_vector::BigVector<Order> {
        let (v0, _, _) = 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::utils::decode_order_id(arg1);
        if (v0) {
            &arg0.bids
        } else {
            &arg0.asks
        }
    }

    fun book_side_mut(arg0: &mut Book, arg1: u128) : &mut 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::big_vector::BigVector<Order> {
        let (v0, _, _) = 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::utils::decode_order_id(arg1);
        if (v0) {
            &mut arg0.bids
        } else {
            &mut arg0.asks
        }
    }

    public fun cancel_order(arg0: &mut Book, arg1: u128, arg2: bool) : Order {
        let v0 = 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::big_vector::remove<Order>(book_side_mut(arg0, arg1), arg1);
        if (!arg2) {
            v0.status = 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::canceled();
        } else {
            v0.status = 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::filled();
            v0.filled_balance = v0.filled_balance + v0.remain_balance;
            v0.remain_balance = 0;
        };
        0x2::event::emit<OrderEvent>(make_event(&v0));
        v0
    }

    public fun confirm_proof(arg0: TradeProof) {
        let TradeProof {
            taker              : _,
            taker_fee          : _,
            maker_fee          : _,
            fills              : _,
            delist             : _,
            fill_limit_reached : _,
            order_id           : _,
            inject             : _,
            remain_balance     : _,
            exec_balance       : _,
            taker_is_bid       : _,
            taker_nft          : _,
            taker_status       : _,
        } = arg0;
    }

    fun copy_order(arg0: &Order) : Order {
        Order{
            market_id        : arg0.market_id,
            trader           : arg0.trader,
            order_id         : arg0.order_id,
            origin_balance   : arg0.origin_balance,
            remain_balance   : arg0.remain_balance,
            filled_balance   : arg0.filled_balance,
            is_bid           : arg0.is_bid,
            nft_id           : arg0.nft_id,
            price            : arg0.price,
            match_price      : arg0.match_price,
            ord_type         : arg0.ord_type,
            status           : arg0.status,
            expire_timestamp : arg0.expire_timestamp,
            fill_mode        : arg0.fill_mode,
        }
    }

    public fun create_order(arg0: &mut Book, arg1: &mut OrderInfo, arg2: u64) : TradeProof {
        validate_inputs(arg1, arg0.tick_size, arg0.min_size, arg2);
        let v0 = get_order_id(arg0, arg1.is_bid);
        let v1 = 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::utils::encode_order_id(arg1.is_bid, arg1.price, v0);
        let v2 = to_order(v1, arg1);
        0x2::event::emit<OrderEvent>(make_event(&v2));
        let v3 = TradeProof{
            taker              : v2.trader,
            taker_fee          : arg0.taker_fee,
            maker_fee          : arg0.maker_fee,
            fills              : 0x1::vector::empty<Fill>(),
            delist             : 0x1::vector::empty<u128>(),
            fill_limit_reached : false,
            order_id           : v1,
            inject             : true,
            remain_balance     : v2.origin_balance,
            exec_balance       : 0,
            taker_is_bid       : v2.is_bid,
            taker_nft          : v2.nft_id,
            taker_status       : 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::live(),
        };
        let v4 = &mut v2;
        let v5 = &mut v3;
        match_against_book(arg0, v4, v5, arg2);
        v3.inject = !assert_inject_order(&v2, &v3);
        v3.exec_balance = v2.filled_balance;
        v3.remain_balance = v2.remain_balance;
        v3.taker_status = v2.status;
        0x2::event::emit<OrderEvent>(make_event(&v2));
        if (v3.inject) {
            inject_limit_order(arg0, v2);
        };
        v3
    }

    fun fee(arg0: u64, arg1: u64) : u64 {
        0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::math::div(0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::math::mul(arg0, arg1), 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::max_fee())
    }

    public fun fill_info(arg0: &Fill) : (bool, address, u64, 0x2::object::ID) {
        (arg0.taker_is_bid, arg0.maker, arg0.exec_qty, arg0.nft_id)
    }

    public fun get_order(arg0: &Book, arg1: u128) : Order {
        copy_order(0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::big_vector::borrow<Order>(book_side(arg0, arg1), arg1))
    }

    fun get_order_id(arg0: &mut Book, arg1: bool) : u64 {
        if (arg1) {
            arg0.next_bid_order_id = arg0.next_bid_order_id - 1;
            arg0.next_bid_order_id
        } else {
            arg0.next_ask_order_id = arg0.next_ask_order_id + 1;
            arg0.next_ask_order_id
        }
    }

    fun inject_limit_order(arg0: &mut Book, arg1: Order) {
        if (arg1.is_bid) {
            0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::big_vector::insert<Order>(&mut arg0.bids, arg1.order_id, arg1);
        } else {
            0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::big_vector::insert<Order>(&mut arg0.asks, arg1.order_id, arg1);
        };
    }

    public(friend) fun makeOrder(arg0: &mut Book, arg1: &mut OrderInfo, arg2: u64) : Order {
        validate_inputs(arg1, arg0.tick_size, arg0.min_size, arg2);
        to_order(0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::utils::encode_order_id(arg1.is_bid, arg1.price, get_order_id(arg0, arg1.is_bid)), arg1)
    }

    fun make_event(arg0: &Order) : OrderEvent {
        OrderEvent{
            market   : arg0.market_id,
            order_id : arg0.order_id,
            nft_id   : arg0.nft_id,
            is_bid   : arg0.is_bid,
            is_taker : true,
            ord_type : arg0.ord_type,
            qty      : arg0.remain_balance,
            price    : arg0.price,
            state    : arg0.status,
        }
    }

    public(friend) fun make_order(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: bool, arg4: 0x1::option::Option<0x2::object::ID>, arg5: u64, arg6: u8, arg7: u64, arg8: u8) : OrderInfo {
        OrderInfo{
            market_id        : arg0,
            trader           : arg1,
            balance          : arg2,
            is_bid           : arg3,
            nft_id           : arg4,
            price            : arg5,
            ord_type         : arg6,
            fill_mode        : arg8,
            expire_timestamp : arg7,
        }
    }

    fun match_against_book(arg0: &mut Book, arg1: &mut Order, arg2: &mut TradeProof, arg3: u64) {
        let v0 = &mut arg2.fills;
        let v1 = &mut arg2.delist;
        let v2 = arg1.is_bid;
        let v3 = if (v2) {
            &mut arg0.asks
        } else {
            &mut arg0.bids
        };
        let (v4, v5) = if (v2) {
            0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::big_vector::min_slice<Order>(v3)
        } else {
            0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::big_vector::max_slice<Order>(v3)
        };
        let v6 = v5;
        let v7 = v4;
        while (!0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::big_vector::slice_is_null(&v7) && 0x1::vector::length<Fill>(v0) < 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::max_fills()) {
            let v8 = 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::big_vector::slice_borrow_mut<Order>(0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::big_vector::borrow_slice_mut<Order>(v3, v7), v6);
            let v9 = match_maker(arg1, v8, v0, v1, arg2.taker_fee, arg2.maker_fee, arg3);
            if (!v9) {
                break
            };
            let (v10, v11) = if (v2) {
                0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::big_vector::next_slice<Order>(v3, v7, v6)
            } else {
                0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::big_vector::prev_slice<Order>(v3, v7, v6)
            };
            v6 = v11;
            v7 = v10;
        };
        let v12 = 0x1::vector::length<Fill>(v0);
        while (v12 > 0) {
            v12 = v12 - 1;
            let v13 = 0x1::vector::borrow_mut<Fill>(v0, v12);
            if (v13.completed || v13.expired) {
                0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::big_vector::remove<Order>(v3, v13.maker_id);
                continue
            };
        };
        let v14 = 0x1::vector::length<u128>(v1);
        while (v14 > 0) {
            v14 = v14 - 1;
            0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::big_vector::remove<Order>(v3, *0x1::vector::borrow_mut<u128>(v1, v14));
        };
        if (0x1::vector::length<Fill>(v0) == 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::max_fills()) {
            arg2.fill_limit_reached = true;
        };
    }

    fun match_maker(arg0: &mut Order, arg1: &mut Order, arg2: &mut vector<Fill>, arg3: &mut vector<u128>, arg4: u64, arg5: u64, arg6: u64) : bool {
        if (arg0.is_bid) {
            assert!(arg1.remain_balance == 1, 10);
            if (arg0.ord_type == 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::ord_market()) {
                if (arg0.remain_balance < arg1.price) {
                    return false
                };
                arg1.remain_balance = 0;
                arg1.filled_balance = 1;
                arg1.match_price = arg1.price;
                update_order_state(arg1, arg6);
                let v0 = arg1.price;
                arg0.match_price = median_price(arg0.match_price, arg0.filled_balance, v0);
                arg0.remain_balance = arg0.remain_balance - v0;
                arg0.filled_balance = arg0.filled_balance + v0;
                update_order_state(arg0, arg6);
                let v1 = Fill{
                    taker_is_bid : true,
                    taker_id     : arg0.order_id,
                    taker        : arg0.trader,
                    maker_id     : arg1.order_id,
                    maker        : arg1.trader,
                    exec_price   : arg1.price,
                    exec_qty     : v0,
                    taker_fee    : fee(v0, arg4),
                    maker_fee    : fee(v0, arg5),
                    expired      : arg1.status == 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::expired(),
                    completed    : true,
                    nft_id       : *0x1::option::borrow<0x2::object::ID>(&arg1.nft_id),
                };
                0x1::vector::push_back<Fill>(arg2, v1);
                return arg0.remain_balance >= arg1.price
            };
            if (arg0.price < arg1.price) {
                return false
            };
            if (arg0.remain_balance < arg1.price) {
                return false
            };
            let v2 = arg1.price;
            arg0.match_price = median_price(arg0.match_price, arg0.filled_balance, v2);
            arg0.remain_balance = arg0.remain_balance - v2;
            arg0.filled_balance = arg0.filled_balance + v2;
            update_order_state(arg0, arg6);
            arg1.remain_balance = 0;
            arg1.filled_balance = 1;
            arg1.match_price = arg1.price;
            update_order_state(arg1, arg6);
            let v3 = Fill{
                taker_is_bid : true,
                taker_id     : arg0.order_id,
                taker        : arg0.trader,
                maker_id     : arg1.order_id,
                maker        : arg1.trader,
                exec_price   : arg1.price,
                exec_qty     : v2,
                taker_fee    : fee(v2, arg4),
                maker_fee    : fee(v2, arg5),
                expired      : arg1.status == 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::expired(),
                completed    : true,
                nft_id       : *0x1::option::borrow<0x2::object::ID>(&arg1.nft_id),
            };
            0x1::vector::push_back<Fill>(arg2, v3);
            return arg0.remain_balance >= arg1.price
        };
        assert!(arg0.remain_balance == 1, 10);
        if (arg0.ord_type == 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::ord_market()) {
            if (arg1.remain_balance < arg1.price) {
                0x1::vector::push_back<u128>(arg3, arg1.order_id);
                return true
            };
            let v4 = arg1.price;
            arg1.match_price = median_price(arg1.match_price, arg1.filled_balance, v4);
            arg1.remain_balance = arg1.remain_balance - v4;
            arg1.filled_balance = arg1.filled_balance + v4;
            update_order_state(arg1, arg6);
            arg0.remain_balance = 0;
            arg0.filled_balance = 1;
            arg0.match_price = arg1.price;
            update_order_state(arg0, arg6);
            let v5 = Fill{
                taker_is_bid : false,
                taker_id     : arg0.order_id,
                taker        : arg0.trader,
                maker_id     : arg1.order_id,
                maker        : arg1.trader,
                exec_price   : arg1.price,
                exec_qty     : v4,
                taker_fee    : fee(v4, arg4),
                maker_fee    : fee(v4, arg5),
                expired      : arg1.status == 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::expired(),
                completed    : arg1.status == 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::filled(),
                nft_id       : *0x1::option::borrow<0x2::object::ID>(&arg0.nft_id),
            };
            0x1::vector::push_back<Fill>(arg2, v5);
            return false
        };
        if (arg0.price > arg1.price) {
            return false
        };
        if (arg1.remain_balance < arg1.price) {
            0x1::vector::push_back<u128>(arg3, arg1.order_id);
            return true
        };
        arg0.remain_balance = 0;
        arg0.filled_balance = 1;
        arg0.match_price = arg1.price;
        update_order_state(arg0, arg6);
        let v6 = arg1.price;
        arg1.match_price = median_price(arg1.match_price, arg1.filled_balance, v6);
        arg1.remain_balance = arg1.remain_balance - v6;
        arg1.filled_balance = arg1.filled_balance + v6;
        update_order_state(arg1, arg6);
        let v7 = Fill{
            taker_is_bid : false,
            taker_id     : arg0.order_id,
            taker        : arg0.trader,
            maker_id     : arg1.order_id,
            maker        : arg1.trader,
            exec_price   : arg1.price,
            exec_qty     : v6,
            taker_fee    : fee(v6, arg4),
            maker_fee    : fee(v6, arg5),
            expired      : arg1.status == 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::expired(),
            completed    : arg1.status == 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::filled(),
            nft_id       : *0x1::option::borrow<0x2::object::ID>(&arg0.nft_id),
        };
        0x1::vector::push_back<Fill>(arg2, v7);
        false
    }

    fun median_price(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 == 0) {
            arg2
        } else {
            0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::math::div(0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::math::mul(arg1 + arg2, arg0), arg1 + arg0)
        }
    }

    public fun min_size(arg0: &Book) : u64 {
        arg0.min_size
    }

    fun modifyPrice(arg0: &mut Order, arg1: u64, arg2: u64) {
        assert!(arg2 <= arg0.expire_timestamp, 14);
        arg0.price = arg1;
        0x2::event::emit<OrderEvent>(make_event(arg0));
    }

    fun modifyQty(arg0: &mut Order, arg1: u64, arg2: u64) {
        assert!(arg1 > arg0.filled_balance && arg1 < arg0.origin_balance, 15);
        assert!(arg2 <= arg0.expire_timestamp, 14);
        arg0.origin_balance = arg1;
        arg0.remain_balance = arg0.origin_balance - arg0.filled_balance;
        0x2::event::emit<OrderEvent>(make_event(arg0));
    }

    public fun modify_order_price(arg0: &mut Book, arg1: u128, arg2: u64, arg3: u64) {
        let v0 = 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::big_vector::borrow_mut<Order>(book_side_mut(arg0, arg1), arg1);
        modifyPrice(v0, arg2, arg3);
    }

    public fun modify_order_qty(arg0: &mut Book, arg1: u128, arg2: u64, arg3: u64) : (u64, &Order) {
        assert!(arg2 >= arg0.min_size, 5);
        let v0 = 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::big_vector::borrow_mut<Order>(book_side_mut(arg0, arg1), arg1);
        assert!(arg2 < v0.origin_balance, 7);
        let v1 = v0.origin_balance - arg2;
        modifyQty(v0, arg2, arg3);
        0x2::event::emit<OrderEvent>(make_event(v0));
        (v1, v0)
    }

    public fun order_id(arg0: &TradeProof) : u128 {
        arg0.order_id
    }

    public fun owner(arg0: &Book, arg1: u128) : address {
        0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::big_vector::borrow<Order>(book_side(arg0, arg1), arg1).trader
    }

    public fun remain_balance(arg0: &Order) : u64 {
        arg0.remain_balance
    }

    public fun tick_size(arg0: &Book) : u64 {
        arg0.tick_size
    }

    fun to_order(arg0: u128, arg1: &OrderInfo) : Order {
        Order{
            market_id        : arg1.market_id,
            trader           : arg1.trader,
            order_id         : arg0,
            origin_balance   : arg1.balance,
            remain_balance   : arg1.balance,
            filled_balance   : 0,
            is_bid           : arg1.is_bid,
            nft_id           : arg1.nft_id,
            price            : arg1.price,
            match_price      : 0,
            ord_type         : arg1.ord_type,
            status           : 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::live(),
            expire_timestamp : arg1.expire_timestamp,
            fill_mode        : arg1.fill_mode,
        }
    }

    public fun trade_info(arg0: &TradeProof) : (address, u128, bool, u64, u64, bool, 0x1::option::Option<0x2::object::ID>, u8) {
        (arg0.taker, arg0.order_id, arg0.inject, arg0.exec_balance, arg0.remain_balance, arg0.taker_is_bid, arg0.taker_nft, arg0.taker_status)
    }

    fun update_order_state(arg0: &mut Order, arg1: u64) {
        if (arg0.status >= 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::expired()) {
            return
        };
        if (arg0.expire_timestamp <= arg1) {
            arg0.status = 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::expired();
            return
        };
        if (arg0.is_bid) {
            if (arg0.ord_type == 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::ord_limit()) {
                if (arg0.filled_balance > 0) {
                    let v0 = if (arg0.remain_balance < arg0.price) {
                        0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::filled()
                    } else {
                        0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::partially_filled()
                    };
                    arg0.status = v0;
                } else {
                    arg0.status = 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::live();
                };
            } else if (arg0.filled_balance > 0) {
                let v1 = if (arg0.remain_balance == 0) {
                    0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::filled()
                } else {
                    0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::partially_filled()
                };
                arg0.status = v1;
            } else {
                arg0.status = 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::live();
            };
        } else if (arg0.ord_type == 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::ord_limit()) {
            if (arg0.filled_balance > 0) {
                let v2 = if (arg0.remain_balance == 0) {
                    0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::filled()
                } else {
                    0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::partially_filled()
                };
                arg0.status = v2;
            } else {
                arg0.status = 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::live();
            };
        } else if (arg0.filled_balance > 0) {
            let v3 = if (arg0.remain_balance == 0) {
                0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::filled()
            } else {
                0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::partially_filled()
            };
            arg0.status = v3;
        } else {
            arg0.status = 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::live();
        };
    }

    fun validate_inputs(arg0: &OrderInfo, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg0.fill_mode <= 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::ice_berge(), 8);
        assert!(arg0.ord_type <= 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::ord_limit(), 12);
        assert!(arg0.is_bid && arg0.fill_mode == 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::ice_berge() || !arg0.is_bid && arg0.fill_mode == 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::atomic(), 9);
        if (arg0.fill_mode == 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::ice_berge()) {
            assert!(arg0.balance >= arg2, 5);
        } else {
            assert!(arg0.balance == 1, 5);
            assert!(0x1::option::is_some<0x2::object::ID>(&arg0.nft_id), 16);
        };
        assert!(arg3 < arg0.expire_timestamp, 11);
        assert!(arg0.price >= 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::min_price() && arg0.price <= 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::constants::max_price(), 13);
        assert!(arg0.price % arg1 == 0, 13);
    }

    // decompiled from Move bytecode v6
}

