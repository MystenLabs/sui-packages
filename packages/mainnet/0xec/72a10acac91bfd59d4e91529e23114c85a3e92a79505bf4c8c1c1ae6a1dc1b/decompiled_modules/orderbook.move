module 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::orderbook {
    struct RestingOrder has store, key {
        id: 0x2::object::UID,
        owner: address,
        market_id: 0x2::object::ID,
        symbol: vector<u8>,
        direction: u8,
        size: u64,
        price: u64,
        expires_at_checkpoint: u64,
        placed_at_checkpoint: u64,
    }

    struct OrderPlaced has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        market_id: 0x2::object::ID,
        symbol: vector<u8>,
        direction: u8,
        size: u64,
        price: u64,
        placed_at_checkpoint: u64,
        expires_at_checkpoint: u64,
    }

    struct OrderMatched has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        market_id: 0x2::object::ID,
        symbol: vector<u8>,
        direction: u8,
        size: u64,
        price: u64,
        matched_at_checkpoint: u64,
    }

    struct OrderExpiryRefreshed has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        market_id: 0x2::object::ID,
        old_expires_at_checkpoint: u64,
        new_expires_at_checkpoint: u64,
    }

    struct OrderCancelled has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        market_id: 0x2::object::ID,
        symbol: vector<u8>,
    }

    struct RestingOrderExpired has copy, drop {
        order_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        expired_at_checkpoint: u64,
        current_checkpoint: u64,
    }

    struct SelfTradeCancelled has copy, drop {
        owner: address,
        resting_order_id: 0x2::object::ID,
        incoming_order_id: u64,
        market_id: 0x2::object::ID,
        current_checkpoint: u64,
    }

    public fun admin_refresh_expiry(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::AdminCap, arg1: &mut RestingOrder, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_not_expired(arg1, arg2);
        let v0 = default_expiry_checkpoint(arg2);
        arg1.expires_at_checkpoint = v0;
        let v1 = OrderExpiryRefreshed{
            order_id                  : 0x2::object::id<RestingOrder>(arg1),
            owner                     : arg1.owner,
            market_id                 : arg1.market_id,
            old_expires_at_checkpoint : arg1.expires_at_checkpoint,
            new_expires_at_checkpoint : v0,
        };
        0x2::event::emit<OrderExpiryRefreshed>(v1);
    }

    fun assert_not_expired(arg0: &RestingOrder, arg1: u64) {
        if (arg0.expires_at_checkpoint < arg1) {
            emit_expired_event(arg0, arg1);
            abort 0
        };
    }

    fun assert_session_allows_order(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::MarketRegistry, arg1: vector<u8>, arg2: bool) {
        if (arg2) {
            return
        };
        assert!(0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::market_session_flag(0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::borrow_market(arg0, arg1)) == 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::session_open(), 7);
    }

    fun assert_valid_order_inputs(arg0: u8, arg1: u64, arg2: u64) {
        assert!(arg1 > 0, 2);
        assert!(arg2 > 0, 3);
        assert!(arg0 == 0 || arg0 == 1, 4);
    }

    public fun cancel_expired(arg0: RestingOrder, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.expires_at_checkpoint < arg1, 5);
        emit_expired_event(&arg0, arg1);
        let RestingOrder {
            id                    : v0,
            owner                 : v1,
            market_id             : v2,
            symbol                : v3,
            direction             : _,
            size                  : _,
            price                 : _,
            expires_at_checkpoint : _,
            placed_at_checkpoint  : _,
        } = arg0;
        let v9 = v0;
        let v10 = OrderCancelled{
            order_id  : 0x2::object::uid_to_inner(&v9),
            owner     : v1,
            market_id : v2,
            symbol    : v3,
        };
        0x2::event::emit<OrderCancelled>(v10);
        0x2::object::delete(v9);
    }

    public fun cancel_order(arg0: RestingOrder, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        if (arg0.expires_at_checkpoint < arg1) {
            emit_expired_event(&arg0, arg1);
        };
        let RestingOrder {
            id                    : v0,
            owner                 : v1,
            market_id             : v2,
            symbol                : v3,
            direction             : _,
            size                  : _,
            price                 : _,
            expires_at_checkpoint : _,
            placed_at_checkpoint  : _,
        } = arg0;
        let v9 = v0;
        let v10 = OrderCancelled{
            order_id  : 0x2::object::uid_to_inner(&v9),
            owner     : v1,
            market_id : v2,
            symbol    : v3,
        };
        0x2::event::emit<OrderCancelled>(v10);
        0x2::object::delete(v9);
    }

    fun default_expiry_checkpoint(arg0: u64) : u64 {
        arg0 + 60
    }

    public fun e_not_allowed_during_depeg() : u64 {
        6
    }

    public fun e_not_order_owner() : u64 {
        1
    }

    public fun e_order_expired() : u64 {
        0
    }

    public fun e_order_not_expired() : u64 {
        5
    }

    public fun e_session_closed() : u64 {
        7
    }

    fun emit_expired_event(arg0: &RestingOrder, arg1: u64) {
        let v0 = RestingOrderExpired{
            order_id              : 0x2::object::id<RestingOrder>(arg0),
            market_id             : arg0.market_id,
            expired_at_checkpoint : arg0.expires_at_checkpoint,
            current_checkpoint    : arg1,
        };
        0x2::event::emit<RestingOrderExpired>(v0);
    }

    public fun expires_at_checkpoint(arg0: &RestingOrder) : u64 {
        arg0.expires_at_checkpoint
    }

    public fun expiry_window_checkpoints() : u64 {
        60
    }

    public fun match_order(arg0: RestingOrder, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_not_expired(&arg0, arg1);
        let RestingOrder {
            id                    : v0,
            owner                 : v1,
            market_id             : v2,
            symbol                : v3,
            direction             : v4,
            size                  : v5,
            price                 : v6,
            expires_at_checkpoint : _,
            placed_at_checkpoint  : _,
        } = arg0;
        let v9 = v0;
        let v10 = OrderMatched{
            order_id              : 0x2::object::uid_to_inner(&v9),
            owner                 : v1,
            market_id             : v2,
            symbol                : v3,
            direction             : v4,
            size                  : v5,
            price                 : v6,
            matched_at_checkpoint : arg1,
        };
        0x2::event::emit<OrderMatched>(v10);
        0x2::object::delete(v9);
    }

    public fun match_order_stp(arg0: RestingOrder, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : bool {
        assert_not_expired(&arg0, arg3);
        if (arg1 == arg0.owner) {
            let v0 = arg0.owner;
            let v1 = arg0.market_id;
            let RestingOrder {
                id                    : v2,
                owner                 : _,
                market_id             : _,
                symbol                : _,
                direction             : _,
                size                  : _,
                price                 : _,
                expires_at_checkpoint : _,
                placed_at_checkpoint  : _,
            } = arg0;
            let v11 = v2;
            let v12 = SelfTradeCancelled{
                owner              : v0,
                resting_order_id   : 0x2::object::id<RestingOrder>(&arg0),
                incoming_order_id  : arg2,
                market_id          : v1,
                current_checkpoint : arg3,
            };
            0x2::event::emit<SelfTradeCancelled>(v12);
            let v13 = OrderCancelled{
                order_id  : 0x2::object::uid_to_inner(&v11),
                owner     : v0,
                market_id : v1,
                symbol    : arg0.symbol,
            };
            0x2::event::emit<OrderCancelled>(v13);
            0x2::object::delete(v11);
            return false
        };
        let RestingOrder {
            id                    : v14,
            owner                 : v15,
            market_id             : v16,
            symbol                : v17,
            direction             : v18,
            size                  : v19,
            price                 : v20,
            expires_at_checkpoint : _,
            placed_at_checkpoint  : _,
        } = arg0;
        let v23 = v14;
        let v24 = OrderMatched{
            order_id              : 0x2::object::uid_to_inner(&v23),
            owner                 : v15,
            market_id             : v16,
            symbol                : v17,
            direction             : v18,
            size                  : v19,
            price                 : v20,
            matched_at_checkpoint : arg3,
        };
        0x2::event::emit<OrderMatched>(v24);
        0x2::object::delete(v23);
        true
    }

    fun new_resting_order(arg0: address, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : RestingOrder {
        RestingOrder{
            id                    : 0x2::object::new(arg8),
            owner                 : arg0,
            market_id             : arg1,
            symbol                : arg2,
            direction             : arg3,
            size                  : arg4,
            price                 : arg5,
            expires_at_checkpoint : arg7,
            placed_at_checkpoint  : arg6,
        }
    }

    public fun order_direction(arg0: &RestingOrder) : u8 {
        arg0.direction
    }

    public fun order_market_id(arg0: &RestingOrder) : 0x2::object::ID {
        arg0.market_id
    }

    public fun order_owner(arg0: &RestingOrder) : address {
        arg0.owner
    }

    public fun order_price(arg0: &RestingOrder) : u64 {
        arg0.price
    }

    public fun order_size(arg0: &RestingOrder) : u64 {
        arg0.size
    }

    public fun order_symbol(arg0: &RestingOrder) : vector<u8> {
        arg0.symbol
    }

    public fun place_order(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::MarketRegistry, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::depeg_state::DepegStateMachine, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        place_order_with_expiry(arg0, arg1, arg2, arg3, arg4, arg5, arg6, default_expiry_checkpoint(arg6), arg7, arg8, arg9);
    }

    public fun place_order_with_expiry(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::MarketRegistry, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::depeg_state::DepegStateMachine, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        assert_valid_order_inputs(arg3, arg4, arg5);
        assert!(0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::depeg_state::is_order_entry_allowed(arg8, arg9), 6);
        assert_session_allows_order(arg0, arg2, arg9);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = new_resting_order(v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10);
        let v2 = OrderPlaced{
            order_id              : 0x2::object::id<RestingOrder>(&v1),
            owner                 : v0,
            market_id             : arg1,
            symbol                : arg2,
            direction             : arg3,
            size                  : arg4,
            price                 : arg5,
            placed_at_checkpoint  : arg6,
            expires_at_checkpoint : arg7,
        };
        0x2::event::emit<OrderPlaced>(v2);
        0x2::transfer::transfer<RestingOrder>(v1, v0);
    }

    public fun placed_at_checkpoint(arg0: &RestingOrder) : u64 {
        arg0.placed_at_checkpoint
    }

    public fun refresh_expiry(arg0: &mut RestingOrder, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert_not_expired(arg0, arg1);
        let v0 = default_expiry_checkpoint(arg1);
        arg0.expires_at_checkpoint = v0;
        let v1 = OrderExpiryRefreshed{
            order_id                  : 0x2::object::id<RestingOrder>(arg0),
            owner                     : arg0.owner,
            market_id                 : arg0.market_id,
            old_expires_at_checkpoint : arg0.expires_at_checkpoint,
            new_expires_at_checkpoint : v0,
        };
        0x2::event::emit<OrderExpiryRefreshed>(v1);
    }

    public fun resting_order_expired_current_checkpoint(arg0: &RestingOrderExpired) : u64 {
        arg0.current_checkpoint
    }

    public fun resting_order_expired_expired_at_checkpoint(arg0: &RestingOrderExpired) : u64 {
        arg0.expired_at_checkpoint
    }

    public fun resting_order_expired_market_id(arg0: &RestingOrderExpired) : 0x2::object::ID {
        arg0.market_id
    }

    public fun resting_order_expired_order_id(arg0: &RestingOrderExpired) : 0x2::object::ID {
        arg0.order_id
    }

    // decompiled from Move bytecode v7
}

