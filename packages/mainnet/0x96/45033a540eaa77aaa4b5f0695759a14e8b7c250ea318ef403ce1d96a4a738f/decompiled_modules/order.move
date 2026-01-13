module 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order {
    struct OrderFillEvent has copy, drop {
        tx_index: u128,
        order_hash: vector<u8>,
        order: Order,
        sig_maker: address,
        fill_price: u128,
        fill_qty: u128,
        new_filled_quantity: u128,
    }

    struct OrderCancelEvent has copy, drop {
        tx_index: u128,
        caller: address,
        sig_maker: address,
        perpetual: address,
        order_hash: vector<u8>,
    }

    struct OrderFlags has copy, drop {
        ioc: bool,
        post_only: bool,
        reduce_only: bool,
        is_long: bool,
        orderbook_only: bool,
    }

    struct Order has copy, drop {
        market: address,
        creator: address,
        is_long: bool,
        reduce_only: bool,
        post_only: bool,
        orderbook_only: bool,
        ioc: bool,
        flags: u8,
        price: u128,
        quantity: u128,
        leverage: u128,
        expiration: u64,
        salt: u128,
    }

    struct OrderStatus has store {
        status: bool,
        filled_qty: u128,
    }

    entry fun cancel_order(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg3: &mut 0x2::table::Table<vector<u8>, OrderStatus>, arg4: address, arg5: u8, arg6: u128, arg7: u128, arg8: u128, arg9: u64, arg10: u128, arg11: address, arg12: vector<u8>, arg13: vector<u8>, arg14: vector<u8>, arg15: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        let v0 = 0x2::tx_context::sender(arg15);
        assert!(v0 == arg11 || 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::is_sub_account(arg1, arg11, v0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::sender_does_not_have_permission_for_account(2));
        let v1 = get_serialized_order(pack_order(arg4, arg5, arg6, arg7, arg8, arg11, arg9, arg10));
        let v2 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_hash(v1);
        create_order(arg3, v2);
        let v3 = 0x2::table::borrow_mut<vector<u8>, OrderStatus>(arg3, v2);
        assert!(v3.status, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::order_is_canceled(0));
        v3.status = false;
        let v4 = OrderCancelEvent{
            tx_index   : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::validate_unique_tx(arg2, arg14),
            caller     : v0,
            sig_maker  : verify_order_signature(arg1, arg11, v1, arg12, arg13, 0),
            perpetual  : arg4,
            order_hash : v2,
        };
        0x2::event::emit<OrderCancelEvent>(v4);
    }

    public(friend) fun create_order(arg0: &mut 0x2::table::Table<vector<u8>, OrderStatus>, arg1: vector<u8>) {
        if (!0x2::table::contains<vector<u8>, OrderStatus>(arg0, arg1)) {
            let v0 = OrderStatus{
                status     : true,
                filled_qty : 0,
            };
            0x2::table::add<vector<u8>, OrderStatus>(arg0, arg1, v0);
        };
    }

    public(friend) fun creator(arg0: Order) : address {
        arg0.creator
    }

    fun decode_order_flags(arg0: u8) : OrderFlags {
        OrderFlags{
            ioc            : arg0 & 1 > 0,
            post_only      : arg0 & 2 > 0,
            reduce_only    : arg0 & 4 > 0,
            is_long        : arg0 & 8 > 0,
            orderbook_only : arg0 & 16 > 0,
        }
    }

    public(friend) fun expiration(arg0: Order) : u64 {
        arg0.expiration
    }

    public(friend) fun flag_orderbook_only(arg0: u8) : bool {
        arg0 & 16 > 0
    }

    public(friend) fun flags(arg0: Order) : u8 {
        arg0.flags
    }

    public(friend) fun get_filled_qty(arg0: &OrderStatus) : u128 {
        arg0.filled_qty
    }

    public(friend) fun get_serialized_order(arg0: Order) : vector<u8> {
        let v0 = 0x1::string::utf8(x"7b0a");
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\"market\":\"0x"));
        0x1::string::append(&mut v0, 0x2::address::to_string(arg0.market));
        0x1::string::append(&mut v0, 0x1::string::utf8(x"222c0a"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\"creator\":\"0x"));
        0x1::string::append(&mut v0, 0x2::address::to_string(arg0.creator));
        0x1::string::append(&mut v0, 0x1::string::utf8(x"222c0a"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\"isLong\":"));
        if (arg0.is_long) {
            0x1::string::append(&mut v0, 0x1::string::utf8(b"\"true\""));
        } else {
            0x1::string::append(&mut v0, 0x1::string::utf8(b"\"false\""));
        };
        0x1::string::append(&mut v0, 0x1::string::utf8(x"2c0a"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\"reduceOnly\":"));
        if (arg0.reduce_only) {
            0x1::string::append(&mut v0, 0x1::string::utf8(b"\"true\""));
        } else {
            0x1::string::append(&mut v0, 0x1::string::utf8(b"\"false\""));
        };
        0x1::string::append(&mut v0, 0x1::string::utf8(x"2c0a"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\"postOnly\":"));
        if (arg0.post_only) {
            0x1::string::append(&mut v0, 0x1::string::utf8(b"\"true\""));
        } else {
            0x1::string::append(&mut v0, 0x1::string::utf8(b"\"false\""));
        };
        0x1::string::append(&mut v0, 0x1::string::utf8(x"2c0a"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\"orderbookOnly\":"));
        if (arg0.orderbook_only) {
            0x1::string::append(&mut v0, 0x1::string::utf8(b"\"true\""));
        } else {
            0x1::string::append(&mut v0, 0x1::string::utf8(b"\"false\""));
        };
        0x1::string::append(&mut v0, 0x1::string::utf8(x"2c0a"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\"ioc\":"));
        if (arg0.ioc) {
            0x1::string::append(&mut v0, 0x1::string::utf8(b"\"true\""));
        } else {
            0x1::string::append(&mut v0, 0x1::string::utf8(b"\"false\""));
        };
        0x1::string::append(&mut v0, 0x1::string::utf8(x"2c0a"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\"quantity\":\""));
        0x1::string::append(&mut v0, 0x1::u128::to_string(arg0.quantity));
        0x1::string::append(&mut v0, 0x1::string::utf8(x"222c0a"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\"price\":\""));
        0x1::string::append(&mut v0, 0x1::u128::to_string(arg0.price));
        0x1::string::append(&mut v0, 0x1::string::utf8(x"222c0a"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\"leverage\":\""));
        0x1::string::append(&mut v0, 0x1::u128::to_string(arg0.leverage));
        0x1::string::append(&mut v0, 0x1::string::utf8(x"222c0a"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\"expiration\":\""));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg0.expiration));
        0x1::string::append(&mut v0, 0x1::string::utf8(x"222c0a"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\"salt\":\""));
        0x1::string::append(&mut v0, 0x1::u128::to_string(arg0.salt));
        0x1::string::append(&mut v0, 0x1::string::utf8(x"222c0a"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\"orderFlag\":\""));
        0x1::string::append(&mut v0, 0x1::u8::to_string(arg0.flags));
        0x1::string::append(&mut v0, 0x1::string::utf8(x"222c0a"));
        0x1::string::append(&mut v0, 0x1::string::utf8(x"22646f6d61696e223a22646970636f696e2e696f220a"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"}"));
        0x1::string::into_bytes(v0)
    }

    public(friend) fun ioc(arg0: Order) : bool {
        arg0.ioc
    }

    public(friend) fun is_long(arg0: Order) : bool {
        arg0.is_long
    }

    public(friend) fun leverage(arg0: Order) : u128 {
        arg0.leverage
    }

    public(friend) fun market(arg0: Order) : address {
        arg0.market
    }

    public(friend) fun orderbook_only(arg0: Order) : bool {
        arg0.orderbook_only
    }

    public(friend) fun pack_order(arg0: address, arg1: u8, arg2: u128, arg3: u128, arg4: u128, arg5: address, arg6: u64, arg7: u128) : Order {
        let v0 = decode_order_flags(arg1);
        Order{
            market         : arg0,
            creator        : arg5,
            is_long        : v0.is_long,
            reduce_only    : v0.reduce_only,
            post_only      : v0.post_only,
            orderbook_only : v0.orderbook_only,
            ioc            : v0.ioc,
            flags          : arg1,
            price          : arg2,
            quantity       : arg3,
            leverage       : arg4,
            expiration     : arg6,
            salt           : arg7,
        }
    }

    public(friend) fun post_only(arg0: Order) : bool {
        arg0.post_only
    }

    public(friend) fun price(arg0: Order) : u128 {
        arg0.price
    }

    public(friend) fun quantity(arg0: Order) : u128 {
        arg0.quantity
    }

    public(friend) fun reduce_only(arg0: Order) : bool {
        arg0.reduce_only
    }

    public(friend) fun salt(arg0: Order) : u128 {
        arg0.salt
    }

    public(friend) fun set_leverage(arg0: &mut Order, arg1: u128) {
        arg0.leverage = arg1;
    }

    public(friend) fun set_price(arg0: &mut Order, arg1: u128) {
        arg0.price = arg1;
    }

    public(friend) fun to_1x9(arg0: Order) : Order {
        Order{
            market         : arg0.market,
            creator        : arg0.creator,
            is_long        : arg0.is_long,
            reduce_only    : arg0.reduce_only,
            post_only      : arg0.post_only,
            orderbook_only : arg0.orderbook_only,
            ioc            : arg0.ioc,
            flags          : arg0.flags,
            price          : arg0.price / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(),
            quantity       : arg0.quantity / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(),
            leverage       : arg0.leverage / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(),
            expiration     : arg0.expiration,
            salt           : arg0.salt,
        }
    }

    public(friend) fun verify_and_fill_order_qty(arg0: &mut 0x2::table::Table<vector<u8>, OrderStatus>, arg1: Order, arg2: vector<u8>, arg3: u128, arg4: u128, arg5: bool, arg6: u128, arg7: address, arg8: u64, arg9: u128) {
        assert!(arg1.is_long && arg3 <= arg1.price || arg3 >= arg1.price, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::fill_price_invalid(arg8));
        if (arg1.reduce_only) {
            assert!(arg1.is_long != arg5 && arg4 <= arg6, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::fill_does_not_decrease_size(arg8));
        };
        let v0 = 0x2::table::borrow_mut<vector<u8>, OrderStatus>(arg0, arg2);
        v0.filled_qty = v0.filled_qty + arg4;
        assert!(v0.filled_qty <= arg1.quantity, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::cannot_overfill_order(arg8));
        let v1 = OrderFillEvent{
            tx_index            : arg9,
            order_hash          : arg2,
            order               : arg1,
            sig_maker           : arg7,
            fill_price          : arg3,
            fill_qty            : arg4,
            new_filled_quantity : v0.filled_qty,
        };
        0x2::event::emit<OrderFillEvent>(v1);
    }

    public(friend) fun verify_order_expiry(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 == 0 || arg0 > arg1 - 1800000, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::order_expired(arg2));
    }

    public(friend) fun verify_order_leverage(arg0: u128, arg1: u128, arg2: u64) {
        assert!(arg1 > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::leverage_must_be_greater_than_zero(arg2));
        assert!(arg0 == 0 || 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::compute_mro(arg1) == arg0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_leverage(arg2));
    }

    public(friend) fun verify_order_signature(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64) : address {
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::verify_signature(arg3, arg4, arg2);
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_result_status(v0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::order_has_invalid_signature(arg5));
        let v1 = if (0x1::vector::pop_back<u8>(&mut arg3) == 3) {
            0x2::address::from_bytes(arg4)
        } else {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_public_address(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_result_public_key(v0))
        };
        assert!(arg1 == v1 || 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::is_sub_account(arg0, arg1, v1), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::order_has_invalid_signature(arg5));
        v1
    }

    public(friend) fun verify_order_state(arg0: &0x2::table::Table<vector<u8>, OrderStatus>, arg1: vector<u8>, arg2: u64) {
        assert!(0x2::table::borrow<vector<u8>, OrderStatus>(arg0, arg1).status, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::order_is_canceled(arg2));
    }

    // decompiled from Move bytecode v6
}

