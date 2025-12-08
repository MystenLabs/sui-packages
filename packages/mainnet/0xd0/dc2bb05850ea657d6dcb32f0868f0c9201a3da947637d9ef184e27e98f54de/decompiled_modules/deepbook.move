module 0xd0dc2bb05850ea657d6dcb32f0868f0c9201a3da947637d9ef184e27e98f54de::deepbook {
    public fun swap_a2b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::admin::Roles, arg3: &mut 0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::vault::Vault<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg0)) {
            0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5)
        } else {
            0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::vault::withdraw_all<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, arg3, arg5)
        };
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg0, arg1, 0x2::coin::zero<T1>(arg5), v0, 0, arg4, arg5);
        let v4 = v3;
        let v5 = v1;
        if (0x2::coin::value<T0>(&v5) == 0) {
            0x2::coin::destroy_zero<T0>(v5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg5));
        };
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v4) == 0) {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v4);
        } else {
            0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::vault::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, v4);
        };
        v2
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::admin::Roles, arg3: &mut 0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::vault::Vault<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg0)) {
            0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5)
        } else {
            0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::vault::withdraw_all<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, arg3, arg5)
        };
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg0, 0x2::coin::zero<T0>(arg5), arg1, v0, 0, arg4, arg5);
        let v4 = v3;
        let v5 = v2;
        if (0x2::coin::value<T1>(&v5) == 0) {
            0x2::coin::destroy_zero<T1>(v5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, 0x2::tx_context::sender(arg5));
        };
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v4) == 0) {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v4);
        } else {
            0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::vault::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, v4);
        };
        v1
    }

    // decompiled from Move bytecode v6
}

