module 0x2f91559bc7034927968dfb8b1801a98c32dc3632b2100db9fce31c0cc74e0ccf::sevenk {
    public fun swap<T0, T1, T2>(arg0: &mut 0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::SwapContext, arg1: &mut 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::Pool<T0, T1, T2>, arg2: &0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleHolder, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5);
        } else {
            swap_b2a<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5);
        };
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::SwapContext, arg1: &mut 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::Pool<T0, T1, T2>, arg2: &0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleHolder, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::take_balance<T0>(arg0, arg3);
        let v1 = 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::swap_x_to_y<T0, T1, T2>(arg1, arg2, 0x2::coin::from_balance<T0>(v0, arg4), 0, arg4);
        0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v1));
        0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::emit_swap_event<T0, T1>(arg0, b"SEVENK", 0x2::object::id<0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::Pool<T0, T1, T2>>(arg1), 0x2::balance::value<T0>(&v0), 0x2::coin::value<T1>(&v1), 0, true);
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::SwapContext, arg1: &mut 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::Pool<T0, T1, T2>, arg2: &0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleHolder, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::take_balance<T1>(arg0, arg3);
        let v1 = 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::swap_y_to_x<T0, T1, T2>(arg1, arg2, 0x2::coin::from_balance<T1>(v0, arg4), 0, arg4);
        0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1));
        0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::emit_swap_event<T0, T1>(arg0, b"SEVENK", 0x2::object::id<0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::Pool<T0, T1, T2>>(arg1), 0x2::balance::value<T1>(&v0), 0x2::coin::value<T0>(&v1), 0, false);
    }

    // decompiled from Move bytecode v6
}

