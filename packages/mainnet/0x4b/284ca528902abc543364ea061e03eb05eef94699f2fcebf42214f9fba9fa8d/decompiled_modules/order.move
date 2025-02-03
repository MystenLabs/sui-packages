module 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::order {
    struct OrderFill has copy, drop {
        orderHash: vector<u8>,
        order: Order,
        sigMaker: address,
        fillPrice: u128,
        fillQty: u128,
        newFilledQuantity: u128,
    }

    struct OrderCancel has copy, drop {
        caller: address,
        sigMaker: address,
        perpetual: address,
        orderHash: vector<u8>,
    }

    struct OrderFlags has copy, drop {
        ioc: bool,
        postOnly: bool,
        reduceOnly: bool,
        isBuy: bool,
        orderbookOnly: bool,
    }

    struct Order has copy, drop {
        market: address,
        maker: address,
        isBuy: bool,
        reduceOnly: bool,
        postOnly: bool,
        orderbookOnly: bool,
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
        filledQty: u128,
    }

    entry fun cancel_order(arg0: &0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::roles::SubAccounts, arg1: &mut 0x2::table::Table<vector<u8>, OrderStatus>, arg2: address, arg3: u8, arg4: u128, arg5: u128, arg6: u128, arg7: u64, arg8: u128, arg9: address, arg10: vector<u8>, arg11: vector<u8>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg12);
        assert!(v0 == arg9 || 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::roles::is_sub_account(arg0, arg9, v0), 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::error::sender_does_not_have_permission_for_account(2));
        let v1 = get_serialized_order(pack_order(arg2, arg3, arg4, arg5, arg6, arg9, arg7, arg8));
        let v2 = 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::get_hash(v1);
        create_order(arg1, v2);
        let v3 = 0x2::table::borrow_mut<vector<u8>, OrderStatus>(arg1, v2);
        assert!(v3.status, 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::error::order_is_canceled(0));
        v3.status = false;
        let v4 = OrderCancel{
            caller    : v0,
            sigMaker  : verify_order_signature(arg0, arg9, v1, arg10, arg11, 0),
            perpetual : arg2,
            orderHash : v2,
        };
        0x2::event::emit<OrderCancel>(v4);
    }

    public(friend) fun create_order(arg0: &mut 0x2::table::Table<vector<u8>, OrderStatus>, arg1: vector<u8>) {
        if (!0x2::table::contains<vector<u8>, OrderStatus>(arg0, arg1)) {
            let v0 = OrderStatus{
                status    : true,
                filledQty : 0,
            };
            0x2::table::add<vector<u8>, OrderStatus>(arg0, arg1, v0);
        };
    }

    fun decode_order_flags(arg0: u8) : OrderFlags {
        OrderFlags{
            ioc           : arg0 & 1 > 0,
            postOnly      : arg0 & 2 > 0,
            reduceOnly    : arg0 & 4 > 0,
            isBuy         : arg0 & 8 > 0,
            orderbookOnly : arg0 & 16 > 0,
        }
    }

    public fun expiration(arg0: Order) : u64 {
        arg0.expiration
    }

    public fun flag_orderbook_only(arg0: u8) : bool {
        arg0 & 16 > 0
    }

    public fun flags(arg0: Order) : u8 {
        arg0.flags
    }

    public fun get_serialized_order(arg0: Order) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x2::bcs::to_bytes<u128>(&arg0.price);
        let v2 = 0x2::bcs::to_bytes<u128>(&arg0.quantity);
        let v3 = 0x2::bcs::to_bytes<u128>(&arg0.leverage);
        let v4 = 0x2::bcs::to_bytes<u64>(&arg0.expiration);
        let v5 = 0x2::bcs::to_bytes<u128>(&arg0.salt);
        let v6 = 0x2::bcs::to_bytes<u8>(&arg0.flags);
        0x1::vector::reverse<u8>(&mut v1);
        0x1::vector::reverse<u8>(&mut v2);
        0x1::vector::reverse<u8>(&mut v3);
        0x1::vector::reverse<u8>(&mut v4);
        0x1::vector::reverse<u8>(&mut v5);
        0x1::vector::reverse<u8>(&mut v6);
        0x1::vector::append<u8>(&mut v0, v1);
        0x1::vector::append<u8>(&mut v0, v2);
        0x1::vector::append<u8>(&mut v0, v3);
        0x1::vector::append<u8>(&mut v0, v5);
        0x1::vector::append<u8>(&mut v0, v4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0.maker));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0.market));
        0x1::vector::append<u8>(&mut v0, v6);
        0x1::vector::append<u8>(&mut v0, b"Bluefin");
        v0
    }

    public fun ioc(arg0: Order) : bool {
        arg0.ioc
    }

    public fun isBuy(arg0: Order) : bool {
        arg0.isBuy
    }

    public fun leverage(arg0: Order) : u128 {
        arg0.leverage
    }

    public fun maker(arg0: Order) : address {
        arg0.maker
    }

    public fun market(arg0: Order) : address {
        arg0.market
    }

    public fun orderbookOnly(arg0: Order) : bool {
        arg0.orderbookOnly
    }

    public fun pack_order(arg0: address, arg1: u8, arg2: u128, arg3: u128, arg4: u128, arg5: address, arg6: u64, arg7: u128) : Order {
        let v0 = decode_order_flags(arg1);
        Order{
            market        : arg0,
            maker         : arg5,
            isBuy         : v0.isBuy,
            reduceOnly    : v0.reduceOnly,
            postOnly      : v0.postOnly,
            orderbookOnly : v0.orderbookOnly,
            ioc           : v0.ioc,
            flags         : arg1,
            price         : arg2,
            quantity      : arg3,
            leverage      : arg4,
            expiration    : arg6,
            salt          : arg7,
        }
    }

    public fun postOnly(arg0: Order) : bool {
        arg0.postOnly
    }

    public fun price(arg0: Order) : u128 {
        arg0.price
    }

    public fun quantity(arg0: Order) : u128 {
        arg0.quantity
    }

    public fun reduceOnly(arg0: Order) : bool {
        arg0.reduceOnly
    }

    public fun salt(arg0: Order) : u128 {
        arg0.salt
    }

    public(friend) fun set_leverage(arg0: &mut Order, arg1: u128) {
        arg0.leverage = arg1;
    }

    public(friend) fun set_price(arg0: &mut Order, arg1: u128) {
        arg0.price = arg1;
    }

    public fun to_1x9(arg0: Order) : Order {
        Order{
            market        : arg0.market,
            maker         : arg0.maker,
            isBuy         : arg0.isBuy,
            reduceOnly    : arg0.reduceOnly,
            postOnly      : arg0.postOnly,
            orderbookOnly : arg0.orderbookOnly,
            ioc           : arg0.ioc,
            flags         : arg0.flags,
            price         : arg0.price / 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::base_uint(),
            quantity      : arg0.quantity / 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::base_uint(),
            leverage      : arg0.leverage / 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::base_uint(),
            expiration    : arg0.expiration,
            salt          : arg0.salt,
        }
    }

    public(friend) fun verify_and_fill_order_qty(arg0: &mut 0x2::table::Table<vector<u8>, OrderStatus>, arg1: Order, arg2: vector<u8>, arg3: u128, arg4: u128, arg5: bool, arg6: u128, arg7: address, arg8: u64) {
        assert!(arg1.isBuy && arg3 <= arg1.price || arg3 >= arg1.price, 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::error::fill_price_invalid(arg8));
        if (arg1.reduceOnly) {
            assert!(arg1.isBuy != arg5 && arg4 <= arg6, 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::error::fill_does_not_decrease_size(arg8));
        };
        let v0 = 0x2::table::borrow_mut<vector<u8>, OrderStatus>(arg0, arg2);
        v0.filledQty = v0.filledQty + arg4;
        assert!(v0.filledQty <= arg1.quantity, 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::error::cannot_overfill_order(arg8));
        let v1 = OrderFill{
            orderHash         : arg2,
            order             : arg1,
            sigMaker          : arg7,
            fillPrice         : arg3,
            fillQty           : arg4,
            newFilledQuantity : v0.filledQty,
        };
        0x2::event::emit<OrderFill>(v1);
    }

    public(friend) fun verify_order_expiry(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 == 0 || arg0 > arg1, 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::error::order_expired(arg2));
    }

    public(friend) fun verify_order_leverage(arg0: u128, arg1: u128, arg2: u64) {
        assert!(arg1 > 0, 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::error::leverage_must_be_greater_than_zero(arg2));
        assert!(arg0 == 0 || 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::compute_mro(arg1) == arg0, 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::error::invalid_leverage(arg2));
    }

    public(friend) fun verify_order_signature(arg0: &0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::roles::SubAccounts, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64) : address {
        let v0 = 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::verify_signature(arg3, arg4, 0x2::hex::encode(arg2));
        assert!(0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::get_result_status(v0), 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::error::order_has_invalid_signature(arg5));
        let v1 = 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::get_public_address(0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::get_result_public_key(v0));
        assert!(arg1 == v1 || 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::roles::is_sub_account(arg0, arg1, v1), 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::error::order_has_invalid_signature(arg5));
        v1
    }

    public(friend) fun verify_order_state(arg0: &mut 0x2::table::Table<vector<u8>, OrderStatus>, arg1: vector<u8>, arg2: u64) {
        assert!(0x2::table::borrow<vector<u8>, OrderStatus>(arg0, arg1).status, 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::error::order_is_canceled(arg2));
    }

    // decompiled from Move bytecode v6
}

