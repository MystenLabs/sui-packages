module 0xa6fa883edc2cdb0aeec04b03349c89e4ed5be2063cf75cb4f09246edb82af9ad::xd {
    public fun qs<T0, T1>(arg0: &mut 0xa6fa883edc2cdb0aeec04b03349c89e4ed5be2063cf75cb4f09246edb82af9ad::m::M, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock) {
        if (!0xa6fa883edc2cdb0aeec04b03349c89e4ed5be2063cf75cb4f09246edb82af9ad::m::live(arg0)) {
            return
        };
        let v0 = 0xa6fa883edc2cdb0aeec04b03349c89e4ed5be2063cf75cb4f09246edb82af9ad::m::cy(arg0);
        let v1 = if (v0 == 0) {
            0
        } else if (arg2) {
            let (_, v3, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg1, v0, arg3);
            v3
        } else {
            let (v5, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg1, v0, arg3);
            v5
        };
        0xa6fa883edc2cdb0aeec04b03349c89e4ed5be2063cf75cb4f09246edb82af9ad::m::fd(arg0, v1);
    }

    public fun sa<T0, T1>(arg0: &mut 0xa6fa883edc2cdb0aeec04b03349c89e4ed5be2063cf75cb4f09246edb82af9ad::m::M, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        if (0x2::balance::value<T0>(&arg2) == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return 0x2::balance::zero<T1>()
        };
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg1, 0x2::coin::from_balance<T0>(arg2, arg4), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), 0, arg3, arg4);
        settle<T0>(v0, v2, arg4);
        let v3 = 0x2::coin::into_balance<T1>(v1);
        0xa6fa883edc2cdb0aeec04b03349c89e4ed5be2063cf75cb4f09246edb82af9ad::m::hp<T1>(arg0, &v3);
        v3
    }

    public fun sb<T0, T1>(arg0: &mut 0xa6fa883edc2cdb0aeec04b03349c89e4ed5be2063cf75cb4f09246edb82af9ad::m::M, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<T1>(&arg2) == 0) {
            0x2::balance::destroy_zero<T1>(arg2);
            return 0x2::balance::zero<T0>()
        };
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg1, 0x2::coin::from_balance<T1>(arg2, arg4), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), 0, arg3, arg4);
        settle<T1>(v1, v2, arg4);
        let v3 = 0x2::coin::into_balance<T0>(v0);
        0xa6fa883edc2cdb0aeec04b03349c89e4ed5be2063cf75cb4f09246edb82af9ad::m::hp<T0>(arg0, &v3);
        v3
    }

    fun settle<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg0);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
        } else {
            0x2::balance::send_funds<T0>(v0, 0x2::tx_context::sender(arg2));
        };
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1);
    }

    // decompiled from Move bytecode v7
}

