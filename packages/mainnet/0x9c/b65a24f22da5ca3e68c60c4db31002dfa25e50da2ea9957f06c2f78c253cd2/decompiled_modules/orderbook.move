module 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::orderbook {
    struct Order has copy, drop, store {
        account_id: u64,
        size: u64,
        reduce_only: bool,
        expiration_timestamp_ms: 0x1::option::Option<u64>,
    }

    struct Orderbook has store, key {
        id: 0x2::object::UID,
        counter: u64,
    }

    public fun best_price(arg0: &Orderbook, arg1: bool) : 0x1::option::Option<u64> {
        let v0 = if (arg1 == 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::constants::ask()) {
            get_asks(arg0)
        } else {
            get_bids(arg0)
        };
        if (0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::ordered_map::is_empty<Order>(v0)) {
            0x1::option::none<u64>()
        } else {
            let v2 = if (arg1 == 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::constants::ask()) {
                0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::order_id::price_ask(0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::ordered_map::min_key<Order>(v0))
            } else {
                0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::order_id::price_bid(0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::ordered_map::min_key<Order>(v0))
            };
            0x1::option::some<u64>(v2)
        }
    }

    public fun book_price(arg0: &Orderbook) : 0x1::option::Option<u64> {
        if (0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::ordered_map::is_empty<Order>(get_bids(arg0)) || 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::ordered_map::is_empty<Order>(get_asks(arg0))) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>((0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::order_id::price_ask(0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::ordered_map::min_key<Order>(get_asks(arg0))) + 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::order_id::price_bid(0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::ordered_map::min_key<Order>(get_bids(arg0)))) / 2)
        }
    }

    public(friend) fun cancel_limit_order(arg0: &mut Orderbook, arg1: u64, arg2: u128) : u64 {
        let v0 = if (0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::order_id::is_ask(arg2)) {
            get_asks_mut(arg0)
        } else {
            get_bids_mut(arg0)
        };
        let v1 = 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::ordered_map::remove<Order>(v0, arg2);
        assert!(arg1 == v1.account_id, 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::errors::invalid_user_for_order());
        v1.size
    }

    public(friend) fun change_maps_params(arg0: &mut Orderbook, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = get_asks_mut(arg0);
        0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::ordered_map::change_params<Order>(v0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::ordered_map::change_params<Order>(get_bids_mut(arg0), arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public(friend) fun create_orderbook(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Orderbook {
        let v0 = Orderbook{
            id      : 0x2::object::new(arg6),
            counter : 0,
        };
        0x2::dynamic_object_field::add<0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::keys::AsksMap, 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::ordered_map::Map<Order>>(&mut v0.id, 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::keys::asks_map(), 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::ordered_map::empty<Order>(arg0, arg1, arg2, arg3, arg4, arg5, arg6));
        0x2::dynamic_object_field::add<0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::keys::BidsMap, 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::ordered_map::Map<Order>>(&mut v0.id, 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::keys::bids_map(), 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::ordered_map::empty<Order>(arg0, arg1, arg2, arg3, arg4, arg5, arg6));
        0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::events::emit_created_orderbook(arg0, arg1, arg2, arg3, arg4, arg5);
        v0
    }

    public(friend) fun get_asks(arg0: &Orderbook) : &0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::ordered_map::Map<Order> {
        0x2::dynamic_object_field::borrow<0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::keys::AsksMap, 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::ordered_map::Map<Order>>(&arg0.id, 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::keys::asks_map())
    }

    public(friend) fun get_asks_mut(arg0: &mut Orderbook) : &mut 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::ordered_map::Map<Order> {
        0x2::dynamic_object_field::borrow_mut<0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::keys::AsksMap, 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::ordered_map::Map<Order>>(&mut arg0.id, 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::keys::asks_map())
    }

    public(friend) fun get_bids(arg0: &Orderbook) : &0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::ordered_map::Map<Order> {
        0x2::dynamic_object_field::borrow<0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::keys::BidsMap, 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::ordered_map::Map<Order>>(&arg0.id, 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::keys::bids_map())
    }

    public(friend) fun get_bids_mut(arg0: &mut Orderbook) : &mut 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::ordered_map::Map<Order> {
        0x2::dynamic_object_field::borrow_mut<0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::keys::BidsMap, 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::ordered_map::Map<Order>>(&mut arg0.id, 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::keys::bids_map())
    }

    public(friend) fun get_order_details(arg0: &Order) : (u64, u64, bool, 0x1::option::Option<u64>) {
        (arg0.account_id, arg0.size, arg0.reduce_only, arg0.expiration_timestamp_ms)
    }

    public fun get_order_size(arg0: &Orderbook, arg1: u128) : u64 {
        let v0 = if (0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::order_id::is_ask(arg1) == 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::constants::ask()) {
            0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::ordered_map::borrow<Order>(get_asks(arg0), arg1)
        } else {
            0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::ordered_map::borrow<Order>(get_bids(arg0), arg1)
        };
        v0.size
    }

    fun increase_counter(arg0: &mut u64) : u64 {
        *arg0 = *arg0 + 1;
        *arg0
    }

    public(friend) fun post_order(arg0: &mut Orderbook, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: bool, arg6: 0x1::option::Option<u64>) : u128 {
        let v0 = &mut arg0.counter;
        let (v1, v2) = if (arg2 == 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::constants::ask()) {
            (get_asks_mut(arg0), 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::order_id::order_id_ask(arg4, increase_counter(v0)))
        } else {
            (get_bids_mut(arg0), 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::order_id::order_id_bid(arg4, increase_counter(v0)))
        };
        let v3 = Order{
            account_id              : arg1,
            size                    : arg3,
            reduce_only             : arg5,
            expiration_timestamp_ms : arg6,
        };
        0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::ordered_map::insert<Order>(v1, v2, v3);
        v2
    }

    public(friend) fun reduce_order_size(arg0: &mut Order, arg1: u64) {
        arg0.size = arg0.size - arg1;
    }

    // decompiled from Move bytecode v6
}

