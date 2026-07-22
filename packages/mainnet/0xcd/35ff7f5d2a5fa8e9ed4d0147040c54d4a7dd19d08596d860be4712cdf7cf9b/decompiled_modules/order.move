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

    struct OrderV2 has copy, drop {
        market: address,
        creator: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress,
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

    public(friend) fun cancel(arg0: &mut 0x2::table::Table<vector<u8>, OrderStatus>, arg1: vector<u8>, arg2: address, arg3: address, arg4: u128) {
        create_order(arg0, arg1);
        let v0 = 0x2::table::borrow_mut<vector<u8>, OrderStatus>(arg0, arg1);
        assert!(v0.status, 28);
        v0.status = false;
        let v1 = OrderCancelEvent{
            tx_index   : arg4,
            caller     : arg3,
            sig_maker  : arg3,
            perpetual  : arg2,
            order_hash : arg1,
        };
        0x2::event::emit<OrderCancelEvent>(v1);
    }

    entry fun cancel_order(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg3: &mut 0x2::table::Table<vector<u8>, OrderStatus>, arg4: address, arg5: u8, arg6: u128, arg7: u128, arg8: u128, arg9: u64, arg10: u128, arg11: address, arg12: vector<u8>, arg13: vector<u8>, arg14: vector<u8>, arg15: &0x2::tx_context::TxContext) {
        abort 999
    }

    entry fun cancel_order_v2(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg3: &mut 0x2::table::Table<vector<u8>, OrderStatus>, arg4: address, arg5: u8, arg6: u128, arg7: u128, arg8: u128, arg9: u64, arg10: u128, arg11: address, arg12: &0x2::tx_context::TxContext) {
        abort 999
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

    public(friend) fun creator(arg0: OrderV2) : 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress {
        arg0.creator
    }

    public(friend) fun creator_identifier(arg0: &OrderV2) : address {
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&arg0.creator)
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

    public(friend) fun expiration(arg0: OrderV2) : u64 {
        arg0.expiration
    }

    public(friend) fun flag_orderbook_only(arg0: u8) : bool {
        arg0 & 16 > 0
    }

    public(friend) fun flags(arg0: OrderV2) : u8 {
        arg0.flags
    }

    public(friend) fun get_filled_qty(arg0: &OrderStatus) : u128 {
        arg0.filled_qty
    }

    public(friend) fun ioc(arg0: OrderV2) : bool {
        arg0.ioc
    }

    public(friend) fun is_long(arg0: &OrderV2) : bool {
        arg0.is_long
    }

    public(friend) fun leverage(arg0: OrderV2) : u128 {
        arg0.leverage
    }

    public(friend) fun market(arg0: OrderV2) : address {
        arg0.market
    }

    public(friend) fun order_v2_to_order(arg0: OrderV2) : Order {
        Order{
            market         : arg0.market,
            creator        : 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&arg0.creator),
            is_long        : arg0.is_long,
            reduce_only    : arg0.reduce_only,
            post_only      : arg0.post_only,
            orderbook_only : arg0.orderbook_only,
            ioc            : arg0.ioc,
            flags          : arg0.flags,
            price          : arg0.price,
            quantity       : arg0.quantity,
            leverage       : arg0.leverage,
            expiration     : arg0.expiration,
            salt           : arg0.salt,
        }
    }

    public(friend) fun orderbook_only(arg0: OrderV2) : bool {
        arg0.orderbook_only
    }

    public(friend) fun pack_order(arg0: address, arg1: u8, arg2: u128, arg3: u128, arg4: u128, arg5: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg6: u64, arg7: u128) : OrderV2 {
        let v0 = decode_order_flags(arg1);
        OrderV2{
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

    public(friend) fun post_only(arg0: OrderV2) : bool {
        arg0.post_only
    }

    public(friend) fun price(arg0: OrderV2) : u128 {
        arg0.price
    }

    public(friend) fun quantity(arg0: OrderV2) : u128 {
        arg0.quantity
    }

    public(friend) fun reduce_only(arg0: OrderV2) : bool {
        arg0.reduce_only
    }

    public(friend) fun salt(arg0: OrderV2) : u128 {
        arg0.salt
    }

    public(friend) fun set_leverage(arg0: &mut OrderV2, arg1: u128) {
        arg0.leverage = arg1;
    }

    public(friend) fun set_price(arg0: &mut OrderV2, arg1: u128) {
        arg0.price = arg1;
    }

    public(friend) fun to_1x9(arg0: OrderV2) : OrderV2 {
        OrderV2{
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

    public(friend) fun to_json_bytes(arg0: OrderV2, arg1: u32) : vector<u8> {
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::new_builder();
        if (arg1 == 2) {
            0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::add_bytes(&mut v0, b"action", b"PlaceOrder");
        };
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::add_address(&mut v0, b"market", arg0.market);
        if (arg1 == 1) {
            assert!(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::is_sui(&arg0.creator), 2100);
            0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::add_address(&mut v0, b"creator", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&arg0.creator));
        } else {
            assert!(arg1 == 2, 2101);
            0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::add_bytes(&mut v0, b"creator", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::display_bytes(&arg0.creator));
        };
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::add_bool(&mut v0, b"isLong", arg0.is_long);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::add_bool(&mut v0, b"reduceOnly", arg0.reduce_only);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::add_bool(&mut v0, b"postOnly", arg0.post_only);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::add_bool(&mut v0, b"orderbookOnly", arg0.orderbook_only);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::add_bool(&mut v0, b"ioc", arg0.ioc);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::add_u128(&mut v0, b"quantity", arg0.quantity);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::add_u128(&mut v0, b"price", arg0.price);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::add_u128(&mut v0, b"leverage", arg0.leverage);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::add_u64(&mut v0, b"expiration", arg0.expiration);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::add_u128(&mut v0, b"salt", arg0.salt);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::add_u8(&mut v0, b"orderFlag", arg0.flags);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::build(v0)
    }

    public(friend) fun verify_and_fill_order_qty(arg0: &mut 0x2::table::Table<vector<u8>, OrderStatus>, arg1: OrderV2, arg2: vector<u8>, arg3: u128, arg4: u128, arg5: bool, arg6: u128, arg7: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg8: u64, arg9: u128) {
        assert!(arg1.is_long && arg3 <= arg1.price || arg3 >= arg1.price, arg8 + 34);
        if (arg1.reduce_only) {
            assert!(arg1.is_long != arg5 && arg4 <= arg6, arg8 + 38);
        };
        let v0 = 0x2::table::borrow_mut<vector<u8>, OrderStatus>(arg0, arg2);
        v0.filled_qty = v0.filled_qty + arg4;
        assert!(v0.filled_qty <= arg1.quantity, arg8 + 44);
        let v1 = OrderFillEvent{
            tx_index            : arg9,
            order_hash          : arg2,
            order               : order_v2_to_order(arg1),
            sig_maker           : 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&arg7),
            fill_price          : arg3,
            fill_qty            : arg4,
            new_filled_quantity : v0.filled_qty,
        };
        0x2::event::emit<OrderFillEvent>(v1);
    }

    public(friend) fun verify_order_expiry(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 == 0 || arg0 > arg1, arg2 + 32);
    }

    public(friend) fun verify_order_leverage(arg0: u128, arg1: u128, arg2: u64) {
        assert!(arg1 > 0, arg2 + 42);
        assert!(arg0 == 0 || 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::compute_mro(arg1) == arg0, arg2 + 40);
    }

    public(friend) fun verify_order_state(arg0: &0x2::table::Table<vector<u8>, OrderStatus>, arg1: vector<u8>, arg2: u64) {
        assert!(0x2::table::borrow<vector<u8>, OrderStatus>(arg0, arg1).status, arg2 + 28);
    }

    // decompiled from Move bytecode v7
}

