module 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order {
    struct Order has drop, store {
        balance_manager_id: 0x2::object::ID,
        order_id: u128,
        client_order_id: u64,
        quantity: u64,
        filled_quantity: u64,
        fee_is_deep: bool,
        order_deep_price: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::OrderDeepPrice,
        epoch: u64,
        status: u8,
        expire_timestamp: u64,
    }

    struct OrderCanceled has copy, drop, store {
        balance_manager_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        order_id: u128,
        client_order_id: u64,
        trader: address,
        price: u64,
        is_bid: bool,
        original_quantity: u64,
        base_asset_quantity_canceled: u64,
        timestamp: u64,
    }

    struct OrderModified has copy, drop, store {
        balance_manager_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        order_id: u128,
        client_order_id: u64,
        trader: address,
        price: u64,
        is_bid: bool,
        previous_quantity: u64,
        filled_quantity: u64,
        new_quantity: u64,
        timestamp: u64,
    }

    public(friend) fun new(arg0: u128, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::OrderDeepPrice, arg7: u64, arg8: u8, arg9: u64) : Order {
        Order{
            balance_manager_id : arg1,
            order_id           : arg0,
            client_order_id    : arg2,
            quantity           : arg3,
            filled_quantity    : arg4,
            fee_is_deep        : arg5,
            order_deep_price   : arg6,
            epoch              : arg7,
            status             : arg8,
            expire_timestamp   : arg9,
        }
    }

    public fun balance_manager_id(arg0: &Order) : 0x2::object::ID {
        arg0.balance_manager_id
    }

    public(friend) fun calculate_cancel_refund(arg0: &Order, arg1: u64, arg2: 0x1::option::Option<u64>) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::Balances {
        let v0 = 0x1::option::get_with_default<u64>(&arg2, arg0.quantity - arg0.filled_quantity);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::fee_quantity(&arg0.order_deep_price, v0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v0, price(arg0)), is_bid(arg0));
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::mul(&mut v1, arg1);
        let v2 = 0;
        let v3 = 0;
        if (is_bid(arg0)) {
            v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v0, price(arg0));
        } else {
            v2 = v0;
        };
        let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::new(v2, v3, 0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::add_balances(&mut v4, v1);
        v4
    }

    public fun client_order_id(arg0: &Order) : u64 {
        arg0.client_order_id
    }

    public(friend) fun copy_order(arg0: &Order) : Order {
        Order{
            balance_manager_id : arg0.balance_manager_id,
            order_id           : arg0.order_id,
            client_order_id    : arg0.client_order_id,
            quantity           : arg0.quantity,
            filled_quantity    : arg0.filled_quantity,
            fee_is_deep        : arg0.fee_is_deep,
            order_deep_price   : arg0.order_deep_price,
            epoch              : arg0.epoch,
            status             : arg0.status,
            expire_timestamp   : arg0.expire_timestamp,
        }
    }

    public(friend) fun emit_cancel_maker(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u128, arg3: u64, arg4: address, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = OrderCanceled{
            balance_manager_id           : arg0,
            pool_id                      : arg1,
            order_id                     : arg2,
            client_order_id              : arg3,
            trader                       : arg4,
            price                        : arg5,
            is_bid                       : arg6,
            original_quantity            : arg7,
            base_asset_quantity_canceled : arg8,
            timestamp                    : arg9,
        };
        0x2::event::emit<OrderCanceled>(v0);
    }

    public(friend) fun emit_order_canceled(arg0: &Order, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = OrderCanceled{
            balance_manager_id           : arg0.balance_manager_id,
            pool_id                      : arg1,
            order_id                     : arg0.order_id,
            client_order_id              : arg0.client_order_id,
            trader                       : arg2,
            price                        : price(arg0),
            is_bid                       : is_bid(arg0),
            original_quantity            : arg0.quantity,
            base_asset_quantity_canceled : arg0.quantity - arg0.filled_quantity,
            timestamp                    : arg3,
        };
        0x2::event::emit<OrderCanceled>(v0);
    }

    public(friend) fun emit_order_modified(arg0: &Order, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: u64) {
        let v0 = OrderModified{
            balance_manager_id : arg0.balance_manager_id,
            pool_id            : arg1,
            order_id           : arg0.order_id,
            client_order_id    : arg0.client_order_id,
            trader             : arg3,
            price              : price(arg0),
            is_bid             : is_bid(arg0),
            previous_quantity  : arg2,
            filled_quantity    : arg0.filled_quantity,
            new_quantity       : arg0.quantity,
            timestamp          : arg4,
        };
        0x2::event::emit<OrderModified>(v0);
    }

    public fun epoch(arg0: &Order) : u64 {
        arg0.epoch
    }

    public fun expire_timestamp(arg0: &Order) : u64 {
        arg0.expire_timestamp
    }

    public fun fee_is_deep(arg0: &Order) : bool {
        arg0.fee_is_deep
    }

    public fun filled_quantity(arg0: &Order) : u64 {
        arg0.filled_quantity
    }

    public(friend) fun generate_fill(arg0: &mut Order, arg1: u64, arg2: u64, arg3: bool, arg4: bool, arg5: bool) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::fill::Fill {
        let v0 = arg0.quantity - arg0.filled_quantity;
        let v1 = 0x1::u64::min(v0, arg2);
        let v2 = v1;
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v1, price(arg0));
        let v4 = arg1 > arg0.expire_timestamp || arg4;
        if (v4) {
            arg0.status = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::expired();
            v2 = v0;
            v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v0, price(arg0));
        } else {
            arg0.filled_quantity = arg0.filled_quantity + v1;
            let v5 = if (arg0.quantity == arg0.filled_quantity) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::filled()
            } else {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::partially_filled()
            };
            arg0.status = v5;
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::fill::new(arg0.order_id, arg0.client_order_id, price(arg0), arg0.balance_manager_id, v4, arg0.quantity == arg0.filled_quantity, arg0.quantity, v2, v3, arg3, arg0.epoch, arg0.order_deep_price, arg5, arg0.fee_is_deep)
    }

    public(friend) fun is_bid(arg0: &Order) : bool {
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::utils::decode_order_id(arg0.order_id);
        v0
    }

    public(friend) fun locked_balance(arg0: &Order, arg1: u64) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::Balances {
        let (v0, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::utils::decode_order_id(order_id(arg0));
        let v3 = 0;
        let v4 = v3;
        let v5 = 0;
        let v6 = v5;
        let v7 = quantity(arg0) - filled_quantity(arg0);
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v7, v1);
        if (v0) {
            v6 = v5 + v8;
        } else {
            v4 = v3 + v7;
        };
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::fee_quantity(order_deep_price(arg0), v7, v8, v0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::mul(&mut v9, arg1);
        let v10 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::new(v4, v6, 0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::add_balances(&mut v10, v9);
        v10
    }

    public(friend) fun modify(arg0: &mut Order, arg1: u64, arg2: u64) {
        assert!(arg1 > arg0.filled_quantity && arg1 < arg0.quantity, 0);
        assert!(arg2 <= arg0.expire_timestamp, 1);
        arg0.quantity = arg1;
    }

    public fun order_deep_price(arg0: &Order) : &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::OrderDeepPrice {
        &arg0.order_deep_price
    }

    public fun order_id(arg0: &Order) : u128 {
        arg0.order_id
    }

    public fun price(arg0: &Order) : u64 {
        let (_, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::utils::decode_order_id(arg0.order_id);
        v1
    }

    public fun quantity(arg0: &Order) : u64 {
        arg0.quantity
    }

    public(friend) fun set_canceled(arg0: &mut Order) {
        arg0.status = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::canceled();
    }

    public fun status(arg0: &Order) : u8 {
        arg0.status
    }

    // decompiled from Move bytecode v6
}

