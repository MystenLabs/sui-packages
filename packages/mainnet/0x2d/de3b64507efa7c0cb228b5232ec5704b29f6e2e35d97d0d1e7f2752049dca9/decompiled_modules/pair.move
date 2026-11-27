module 0x2dde3b64507efa7c0cb228b5232ec5704b29f6e2e35d97d0d1e7f2752049dca9::pair {
    struct PairFilled has copy, drop {
        pool_id: 0x2::object::ID,
        maker_manager: 0x2::object::ID,
        taker_manager: 0x2::object::ID,
        maker_order_id: u128,
        quantity: u64,
        quote_quantity: u64,
        price: u64,
    }

    public fun assert_pair(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 11);
        assert!(arg2 > 0 && arg3 > 0, 0);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::pool_id(arg0) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::pool_id(arg1), 1);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::balance_manager_id(arg0) != 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::balance_manager_id(arg1), 2);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::is_bid(arg0) != 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::is_bid(arg1), 3);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(arg0) == arg2 && 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(arg1) == arg2, 4);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_inserted(arg0) && 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(arg0) == 0, 5);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::price(arg0) == arg3 && 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(arg1) == arg2, 6);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::fills(arg1);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::fill::Fill>(&v0)) {
            let v4 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::fill::Fill>(&v0, v3);
            if (!0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::fill::expired(v4)) {
                assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::fill::maker_order_id(v4) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(arg0), 7);
                assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::fill::balance_manager_id(v4) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::balance_manager_id(arg0), 8);
                assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::fill::execution_price(v4) == arg3, 9);
                v1 = v1 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::fill::base_quantity(v4);
                v2 = v2 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::fill::quote_quantity(v4);
            };
            v3 = v3 + 1;
        };
        assert!(v1 == arg2, 10);
        let v5 = PairFilled{
            pool_id        : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::pool_id(arg0),
            maker_manager  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::balance_manager_id(arg0),
            taker_manager  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::balance_manager_id(arg1),
            maker_order_id : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(arg0),
            quantity       : arg2,
            quote_quantity : v2,
            price          : arg3,
        };
        0x2::event::emit<PairFilled>(v5);
    }

    // decompiled from Move bytecode v6
}

