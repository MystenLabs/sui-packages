module 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::book {
    struct Order has drop, store {
        market_id: 0x2::object::ID,
        trader: address,
        order_id: u128,
        origin_qty: u64,
        remain_qty: u64,
        filled_qty: u64,
        is_bid: bool,
        nft_id: 0x1::option::Option<0x2::object::ID>,
        price: u64,
        match_price: u64,
        ord_type: u8,
        cross_id: u128,
        status: u8,
        expire_timestamp: u64,
        fill_mode: u8,
    }

    struct OrderEvent has copy, drop, store {
        market: 0x2::object::ID,
        owner: address,
        order_id: u128,
        ord_type: u8,
        nft_id: 0x1::option::Option<0x2::object::ID>,
        is_bid: bool,
        remain_qty: u64,
        filled_qty: u64,
        origin_qty: u64,
        price: u64,
        match_price: u64,
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
        cross_id: u128,
        fill_mode: u8,
        expire_timestamp: u64,
    }

    struct Bill has copy, drop, store {
        taker_is_bid: bool,
        taker_ordid: u128,
        maker_ordid: u128,
        taker: address,
        maker: address,
        exec_price: u64,
        exec_qty: u64,
        timestamp: u64,
        nft: 0x2::object::ID,
        maker_filled: bool,
    }

    struct Filled has copy, drop, store {
        market_id: 0x2::object::ID,
        taker_is_bid: bool,
        taker_ordid: u128,
        maker_ordid: u128,
        taker: address,
        maker: address,
        filled_value: u64,
        nft: 0x2::object::ID,
        timestamp: u64,
    }

    struct ExpiredBill has copy, drop, store {
        maker_is_bid: bool,
        maker_order_id: u128,
        maker: address,
        exec_price: u64,
        exec_qty: u64,
        nft_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct TradeProof {
        taker: address,
        fills: vector<Bill>,
        delists: vector<ExpiredBill>,
        fill_limit_reached: bool,
        order_id: u128,
        inject: bool,
        remain_qty: u64,
        taker_is_bid: bool,
        taker_nft: 0x1::option::Option<0x2::object::ID>,
    }

    struct Book has store {
        base_fee: u64,
        tick_size: u64,
        min_size: u64,
        asks: 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::BigVector<Order>,
        bids: 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::BigVector<Order>,
        next_bid_order_id: u64,
        next_ask_order_id: u64,
    }

    public(friend) fun empty(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Book {
        Book{
            base_fee          : arg0,
            tick_size         : arg1,
            min_size          : arg2,
            asks              : 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::empty<Order>(0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::max_slice_size(), 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::max_fan_out(), arg3),
            bids              : 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::empty<Order>(0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::max_slice_size(), 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::max_fan_out(), arg3),
            next_bid_order_id : 18446744073709551615,
            next_ask_order_id : 1,
        }
    }

    public fun asks(arg0: &Book) : &0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::BigVector<Order> {
        &arg0.asks
    }

    public fun assert_owner(arg0: &Book, arg1: u128, arg2: address) {
        assert!(arg2 == 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::borrow<Order>(book_side(arg0, arg1), arg1).trader, 17);
    }

    public fun bids(arg0: &Book) : &0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::BigVector<Order> {
        &arg0.bids
    }

    public fun bill_info(arg0: &TradeProof) : (&vector<Bill>, &vector<ExpiredBill>) {
        (&arg0.fills, &arg0.delists)
    }

    fun book_side(arg0: &Book, arg1: u128) : &0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::BigVector<Order> {
        let (v0, _, _) = 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::utils::decode_order_id(arg1);
        if (v0) {
            &arg0.bids
        } else {
            &arg0.asks
        }
    }

    fun book_side_mut(arg0: &mut Book, arg1: u128) : &mut 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::BigVector<Order> {
        let (v0, _, _) = 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::utils::decode_order_id(arg1);
        if (v0) {
            &mut arg0.bids
        } else {
            &mut arg0.asks
        }
    }

    public fun book_size(arg0: &Book) : (u64, u64) {
        (0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::length<Order>(bids(arg0)), 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::length<Order>(asks(arg0)))
    }

    public fun cancel_order(arg0: &mut Book, arg1: u128) : Order {
        let v0 = 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::remove<Order>(book_side_mut(arg0, arg1), arg1);
        let v1 = &mut v0;
        setStatus(v1, 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::canceled());
        v0
    }

    public fun confirm_proof(arg0: TradeProof) {
        let TradeProof {
            taker              : _,
            fills              : _,
            delists            : _,
            fill_limit_reached : _,
            order_id           : _,
            inject             : _,
            remain_qty         : _,
            taker_is_bid       : _,
            taker_nft          : _,
        } = arg0;
    }

    public fun expired_info(arg0: &ExpiredBill) : (bool, address, u64, 0x1::option::Option<0x2::object::ID>) {
        (arg0.maker_is_bid, arg0.maker, arg0.exec_qty, arg0.nft_id)
    }

    public fun fill_info(arg0: &Bill) : (bool, address, u64, u64, 0x2::object::ID) {
        (arg0.taker_is_bid, arg0.maker, arg0.exec_qty, arg0.exec_price, arg0.nft)
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
            0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::insert<Order>(&mut arg0.bids, arg1.order_id, arg1);
        } else {
            0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::insert<Order>(&mut arg0.asks, arg1.order_id, arg1);
        };
    }

    fun inject_taker_order(arg0: &Order, arg1: &TradeProof) : bool {
        let v0 = arg0.ord_type <= 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::ord_cross() || arg0.status >= 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::filled() || arg1.fill_limit_reached;
        !v0
    }

    fun make_event(arg0: &Order) : OrderEvent {
        OrderEvent{
            market      : arg0.market_id,
            owner       : arg0.trader,
            order_id    : arg0.order_id,
            ord_type    : arg0.ord_type,
            nft_id      : arg0.nft_id,
            is_bid      : arg0.is_bid,
            remain_qty  : arg0.remain_qty,
            filled_qty  : arg0.filled_qty,
            origin_qty  : arg0.origin_qty,
            price       : arg0.price,
            match_price : arg0.match_price,
            state       : arg0.status,
        }
    }

    fun make_event_filled(arg0: 0x2::object::ID, arg1: &Bill) : Filled {
        Filled{
            market_id    : arg0,
            taker_is_bid : arg1.taker_is_bid,
            taker_ordid  : arg1.taker_ordid,
            maker_ordid  : arg1.maker_ordid,
            taker        : arg1.taker,
            maker        : arg1.maker,
            filled_value : arg1.exec_qty,
            nft          : arg1.nft,
            timestamp    : arg1.timestamp,
        }
    }

    public(friend) fun make_order_info(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: bool, arg4: 0x1::option::Option<0x2::object::ID>, arg5: u64, arg6: u8, arg7: u128, arg8: u64, arg9: u8) : OrderInfo {
        OrderInfo{
            market_id        : arg0,
            trader           : arg1,
            balance          : arg2,
            is_bid           : arg3,
            nft_id           : arg4,
            price            : arg5,
            ord_type         : arg6,
            cross_id         : arg7,
            fill_mode        : arg9,
            expire_timestamp : arg8,
        }
    }

    fun match_against_book(arg0: &mut Book, arg1: &mut Order, arg2: &mut TradeProof, arg3: u64) {
        let v0 = &mut arg2.fills;
        let v1 = &mut arg2.delists;
        let v2 = arg1.is_bid;
        let v3 = if (v2) {
            &mut arg0.asks
        } else {
            &mut arg0.bids
        };
        let (v4, v5) = if (v2) {
            0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::min_slice<Order>(v3)
        } else {
            0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::max_slice<Order>(v3)
        };
        let v6 = v5;
        let v7 = v4;
        while (!0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::slice_is_null(&v7) && 0x1::vector::length<Bill>(v0) < 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::max_fills()) {
            let v8 = 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::slice_borrow_mut<Order>(0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::borrow_slice_mut<Order>(v3, v7), v6);
            let v9 = match_maker(arg1, v8, v0, v1, arg3);
            if (!v9) {
                break
            };
            let (v10, v11) = if (v2) {
                0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::next_slice<Order>(v3, v7, v6)
            } else {
                0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::prev_slice<Order>(v3, v7, v6)
            };
            v6 = v11;
            v7 = v10;
        };
        let v12 = 0x1::vector::length<Bill>(v0);
        while (v12 > 0) {
            v12 = v12 - 1;
            let v13 = 0x1::vector::borrow_mut<Bill>(v0, v12);
            0x2::event::emit<Filled>(make_event_filled(arg1.market_id, v13));
            if (v13.maker_filled) {
                0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::remove<Order>(v3, v13.maker_ordid);
                continue
            };
        };
        let v14 = 0x1::vector::length<ExpiredBill>(v1);
        while (v14 > 0) {
            v14 = v14 - 1;
            0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::remove<Order>(v3, 0x1::vector::borrow_mut<ExpiredBill>(v1, v14).maker_order_id);
        };
        if (0x1::vector::length<Bill>(v0) == 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::max_fills()) {
            arg2.fill_limit_reached = true;
        };
    }

    fun match_maker(arg0: &mut Order, arg1: &mut Order, arg2: &mut vector<Bill>, arg3: &mut vector<ExpiredBill>, arg4: u64) : bool {
        if (arg1.expire_timestamp <= arg4) {
            setStatus(arg1, 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::expired());
            let v0 = ExpiredBill{
                maker_is_bid   : !arg0.is_bid,
                maker_order_id : arg1.order_id,
                maker          : arg1.trader,
                exec_price     : arg1.price,
                exec_qty       : arg1.remain_qty,
                nft_id         : arg1.nft_id,
            };
            0x1::vector::push_back<ExpiredBill>(arg3, v0);
            return true
        };
        if (arg0.is_bid) {
            assert!(arg1.remain_qty == 1, 10);
            if (arg0.ord_type == 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::ord_market()) {
                if (arg0.remain_qty < arg1.price) {
                    setStatus(arg0, 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::completed());
                    return false
                };
                arg1.remain_qty = 0;
                arg1.filled_qty = 1;
                arg1.match_price = arg1.price;
                update_order_state(arg1, arg4);
                let v1 = arg1.price;
                arg0.match_price = median_price(arg0.match_price, arg0.filled_qty, v1);
                arg0.remain_qty = arg0.remain_qty - v1;
                arg0.filled_qty = arg0.filled_qty + v1;
                update_order_state(arg0, arg4);
                let v2 = Bill{
                    taker_is_bid : true,
                    taker_ordid  : arg0.order_id,
                    maker_ordid  : arg1.order_id,
                    taker        : arg0.trader,
                    maker        : arg1.trader,
                    exec_price   : arg1.price,
                    exec_qty     : v1,
                    timestamp    : arg4,
                    nft          : *0x1::option::borrow<0x2::object::ID>(&arg1.nft_id),
                    maker_filled : true,
                };
                0x1::vector::push_back<Bill>(arg2, v2);
                return true
            };
            if (arg0.remain_qty < arg0.price) {
                setStatus(arg0, 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::completed());
                return false
            };
            if (arg0.price < arg1.price) {
                update_order_state(arg0, arg4);
                return false
            };
            let v3 = arg1.price;
            arg0.match_price = median_price(arg0.match_price, arg0.filled_qty, v3);
            arg0.remain_qty = arg0.remain_qty - v3;
            arg0.filled_qty = arg0.filled_qty + v3;
            update_order_state(arg0, arg4);
            arg1.remain_qty = 0;
            arg1.filled_qty = 1;
            arg1.match_price = arg1.price;
            update_order_state(arg1, arg4);
            let v4 = Bill{
                taker_is_bid : true,
                taker_ordid  : arg0.order_id,
                maker_ordid  : arg1.order_id,
                taker        : arg0.trader,
                maker        : arg1.trader,
                exec_price   : arg1.price,
                exec_qty     : v3,
                timestamp    : arg4,
                nft          : *0x1::option::borrow<0x2::object::ID>(&arg1.nft_id),
                maker_filled : true,
            };
            0x1::vector::push_back<Bill>(arg2, v4);
            return true
        };
        assert!(arg0.remain_qty == 1, 10);
        if (arg0.ord_type == 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::ord_market()) {
            let v5 = arg1.price;
            arg1.match_price = median_price(arg1.match_price, arg1.filled_qty, v5);
            arg1.remain_qty = arg1.remain_qty - v5;
            arg1.filled_qty = arg1.filled_qty + v5;
            update_order_state(arg1, arg4);
            arg0.remain_qty = 0;
            arg0.filled_qty = 1;
            arg0.match_price = arg1.price;
            update_order_state(arg0, arg4);
            let v6 = Bill{
                taker_is_bid : false,
                taker_ordid  : arg0.order_id,
                maker_ordid  : arg1.order_id,
                taker        : arg0.trader,
                maker        : arg1.trader,
                exec_price   : arg1.price,
                exec_qty     : v5,
                timestamp    : arg4,
                nft          : *0x1::option::borrow<0x2::object::ID>(&arg0.nft_id),
                maker_filled : arg1.status == 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::filled(),
            };
            0x1::vector::push_back<Bill>(arg2, v6);
            return false
        };
        if (arg0.price > arg1.price) {
            setStatus(arg0, 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::live());
            return false
        };
        arg0.remain_qty = 0;
        arg0.filled_qty = 1;
        arg0.match_price = arg1.price;
        update_order_state(arg0, arg4);
        let v7 = arg1.price;
        arg1.match_price = median_price(arg1.match_price, arg1.filled_qty, v7);
        arg1.remain_qty = arg1.remain_qty - v7;
        arg1.filled_qty = arg1.filled_qty + v7;
        update_order_state(arg1, arg4);
        let v8 = Bill{
            taker_is_bid : false,
            taker_ordid  : arg0.order_id,
            maker_ordid  : arg1.order_id,
            taker        : arg0.trader,
            maker        : arg1.trader,
            exec_price   : arg1.price,
            exec_qty     : v7,
            timestamp    : arg4,
            nft          : *0x1::option::borrow<0x2::object::ID>(&arg0.nft_id),
            maker_filled : arg1.status == 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::filled(),
        };
        0x1::vector::push_back<Bill>(arg2, v8);
        false
    }

    fun median_price(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 == 0) {
            arg2
        } else {
            0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::math::div(0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::math::mul(arg1 + arg2, arg0), arg1 + arg0)
        }
    }

    public fun min_size(arg0: &Book) : u64 {
        arg0.min_size
    }

    public fun order(arg0: &Book, arg1: u128) : &Order {
        0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::borrow<Order>(book_side(arg0, arg1), arg1)
    }

    public fun order_expiretime(arg0: &Book, arg1: u128) : u64 {
        0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::borrow<Order>(book_side(arg0, arg1), arg1).expire_timestamp
    }

    public fun order_id(arg0: &TradeProof) : u128 {
        arg0.order_id
    }

    public(friend) fun order_info(arg0: &Order) : (bool, address, u64, 0x1::option::Option<0x2::object::ID>) {
        (arg0.is_bid, arg0.trader, arg0.remain_qty, arg0.nft_id)
    }

    public fun order_mut(arg0: &mut Book, arg1: u128) : &mut Order {
        0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::borrow_mut<Order>(book_side_mut(arg0, arg1), arg1)
    }

    public fun owner(arg0: &Book, arg1: u128) : address {
        0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::borrow<Order>(book_side(arg0, arg1), arg1).trader
    }

    public fun place_cross(arg0: &mut Book, arg1: &mut OrderInfo, arg2: u64) : (0x1::option::Option<Bill>, 0x1::option::Option<ExpiredBill>, address, u64) {
        let v0 = get_order_id(arg0, arg1.is_bid);
        let v1 = arg1.cross_id;
        let v2 = order_mut(arg0, v1);
        assert!(arg1.ord_type == 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::ord_cross() && arg1.nft_id == v2.nft_id && arg1.balance >= v2.price && v2.remain_qty == 1, 18);
        let v3 = to_order(0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::utils::encode_order_id(arg1.is_bid, arg1.price, v0), arg1);
        let v4 = &mut v3;
        setStatus(v4, 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::live());
        if (v2.expire_timestamp <= arg2) {
            setStatus(v2, 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::expired());
            let v9 = ExpiredBill{
                maker_is_bid   : !v3.is_bid,
                maker_order_id : v2.order_id,
                maker          : v2.trader,
                exec_price     : v2.price,
                exec_qty       : v2.remain_qty,
                nft_id         : v2.nft_id,
            };
            0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::remove<Order>(book_side_mut(arg0, v1), v1);
            (0x1::option::none<Bill>(), 0x1::option::some<ExpiredBill>(v9), v3.trader, v3.remain_qty)
        } else {
            v2.remain_qty = 0;
            v2.filled_qty = 1;
            v2.match_price = v2.price;
            setStatus(v2, 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::filled());
            let v10 = v2.price;
            v3.match_price = median_price(v3.match_price, v3.filled_qty, v10);
            v3.remain_qty = v3.remain_qty - v10;
            v3.filled_qty = v3.filled_qty + v10;
            let v11 = &mut v3;
            setStatus(v11, 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::completed());
            let v12 = Bill{
                taker_is_bid : true,
                taker_ordid  : v3.order_id,
                maker_ordid  : v2.order_id,
                taker        : v3.trader,
                maker        : v2.trader,
                exec_price   : v2.price,
                exec_qty     : v10,
                timestamp    : arg2,
                nft          : *0x1::option::borrow<0x2::object::ID>(&v2.nft_id),
                maker_filled : true,
            };
            0x2::event::emit<Filled>(make_event_filled(arg1.market_id, &v12));
            0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::big_vector::remove<Order>(book_side_mut(arg0, v1), v1);
            (0x1::option::some<Bill>(v12), 0x1::option::none<ExpiredBill>(), v3.trader, v3.remain_qty)
        }
    }

    public fun place_order(arg0: &mut Book, arg1: &mut OrderInfo, arg2: u64) : TradeProof {
        validate_inputs(arg1, arg0.tick_size, arg0.min_size, arg2);
        assert!(arg1.ord_type <= 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::ord_limit(), 9);
        let v0 = get_order_id(arg0, arg1.is_bid);
        let v1 = 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::utils::encode_order_id(arg1.is_bid, arg1.price, v0);
        let v2 = to_order(v1, arg1);
        let v3 = TradeProof{
            taker              : v2.trader,
            fills              : 0x1::vector::empty<Bill>(),
            delists            : 0x1::vector::empty<ExpiredBill>(),
            fill_limit_reached : false,
            order_id           : v1,
            inject             : false,
            remain_qty         : v2.origin_qty,
            taker_is_bid       : v2.is_bid,
            taker_nft          : v2.nft_id,
        };
        let v4 = &mut v2;
        setStatus(v4, 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::live());
        let v5 = &mut v2;
        let v6 = &mut v3;
        match_against_book(arg0, v5, v6, arg2);
        v3.inject = inject_taker_order(&v2, &v3);
        v3.remain_qty = v2.remain_qty;
        if (v3.inject) {
            inject_limit_order(arg0, v2);
        } else {
            let v7 = &mut v2;
            setStatus(v7, 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::completed());
        };
        v3
    }

    public fun remain_balance(arg0: &Order) : u64 {
        arg0.remain_qty
    }

    fun setStatus(arg0: &mut Order, arg1: u8) {
        arg0.status = arg1;
        0x2::event::emit<OrderEvent>(make_event(arg0));
    }

    public fun tick_size(arg0: &Book) : u64 {
        arg0.tick_size
    }

    fun to_order(arg0: u128, arg1: &OrderInfo) : Order {
        Order{
            market_id        : arg1.market_id,
            trader           : arg1.trader,
            order_id         : arg0,
            origin_qty       : arg1.balance,
            remain_qty       : arg1.balance,
            filled_qty       : 0,
            is_bid           : arg1.is_bid,
            nft_id           : arg1.nft_id,
            price            : arg1.price,
            match_price      : 0,
            ord_type         : arg1.ord_type,
            cross_id         : arg1.cross_id,
            status           : 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::live(),
            expire_timestamp : arg1.expire_timestamp,
            fill_mode        : arg1.fill_mode,
        }
    }

    public fun trade_info(arg0: &TradeProof) : (address, u128, bool, u64, bool, 0x1::option::Option<0x2::object::ID>) {
        (arg0.taker, arg0.order_id, arg0.inject, arg0.remain_qty, arg0.taker_is_bid, arg0.taker_nft)
    }

    fun update_order_state(arg0: &mut Order, arg1: u64) {
        if (arg0.status >= 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::expired()) {
            return
        };
        if (arg0.expire_timestamp <= arg1) {
            setStatus(arg0, 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::expired());
            return
        };
        if (arg0.is_bid) {
            if (arg0.ord_type == 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::ord_limit()) {
                if (arg0.filled_qty > 0) {
                    let v0 = if (arg0.remain_qty < arg0.price) {
                        0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::filled()
                    } else {
                        0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::partially_filled()
                    };
                    setStatus(arg0, v0);
                };
            } else if (arg0.filled_qty > 0) {
                let v1 = if (arg0.remain_qty == 0) {
                    0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::filled()
                } else {
                    0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::partially_filled()
                };
                setStatus(arg0, v1);
            };
        } else if (arg0.filled_qty > 0) {
            setStatus(arg0, 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::filled());
        };
    }

    fun validate_inputs(arg0: &OrderInfo, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg0.fill_mode <= 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::ice_berge(), 8);
        assert!(arg0.ord_type <= 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::ord_limit(), 12);
        assert!(arg0.is_bid && arg0.fill_mode == 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::ice_berge() || !arg0.is_bid && arg0.fill_mode == 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::atomic(), 9);
        if (arg0.fill_mode == 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::ice_berge()) {
            assert!(arg0.balance >= arg2, 5);
        } else {
            assert!(arg0.balance == 1, 5);
            assert!(0x1::option::is_some<0x2::object::ID>(&arg0.nft_id), 16);
        };
        assert!(arg3 < arg0.expire_timestamp, 11);
        assert!(arg0.ord_type < 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::ord_limit() && arg0.price == 0 || arg0.ord_type == 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::ord_limit() && arg0.price >= 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::min_price() && arg0.price <= 0x7a42d920bfcad88772f775858deb4e23762ea31c3f6d491de52018d1398be56b::constants::max_price(), 13);
        assert!(arg0.price % arg1 == 0, 13);
    }

    // decompiled from Move bytecode v6
}

