module 0x1065ab063f42e795ce5bb99d05558a3e27dcefebc76fc4aac73f714ffb5078cf::dA {
    public fun dC<T0, T1>(arg0: &mut 0x1065ab063f42e795ce5bb99d05558a3e27dcefebc76fc4aac73f714ffb5078cf::cB::AC, arg1: &mut 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::GlobalConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5);
        if (arg3) {
            dD<T0, T1>(arg0, arg1, arg2, v0, arg4, arg5);
        } else {
            eF<T0, T1>(arg0, arg1, arg2, v0, arg4, arg5);
        };
    }

    public fun dD<T0, T1>(arg0: &mut 0x1065ab063f42e795ce5bb99d05558a3e27dcefebc76fc4aac73f714ffb5078cf::cB::AC, arg1: &mut 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::GlobalConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1065ab063f42e795ce5bb99d05558a3e27dcefebc76fc4aac73f714ffb5078cf::cB::gO<T0>(arg0);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x1065ab063f42e795ce5bb99d05558a3e27dcefebc76fc4aac73f714ffb5078cf::cB::gD<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, arg5);
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v1, v2, v3) = 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::deepbook_v3::swap_a2b_<T0, T1>(arg1, arg2, 0x2::coin::from_balance<T0>(v0, arg5), arg3, arg4, arg5);
        0x1065ab063f42e795ce5bb99d05558a3e27dcefebc76fc4aac73f714ffb5078cf::cB::gD<T0>(v1, arg5);
        0x1065ab063f42e795ce5bb99d05558a3e27dcefebc76fc4aac73f714ffb5078cf::cB::eA<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
        0x1065ab063f42e795ce5bb99d05558a3e27dcefebc76fc4aac73f714ffb5078cf::cB::gD<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v3, arg5);
    }

    public fun eF<T0, T1>(arg0: &mut 0x1065ab063f42e795ce5bb99d05558a3e27dcefebc76fc4aac73f714ffb5078cf::cB::AC, arg1: &mut 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::GlobalConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1065ab063f42e795ce5bb99d05558a3e27dcefebc76fc4aac73f714ffb5078cf::cB::gO<T1>(arg0);
        if (0x2::balance::value<T1>(&v0) == 0) {
            0x1065ab063f42e795ce5bb99d05558a3e27dcefebc76fc4aac73f714ffb5078cf::cB::gD<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, arg5);
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v1, v2, v3) = 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::deepbook_v3::swap_b2a_<T0, T1>(arg1, arg2, 0x2::coin::from_balance<T1>(v0, arg5), arg3, arg4, arg5);
        0x1065ab063f42e795ce5bb99d05558a3e27dcefebc76fc4aac73f714ffb5078cf::cB::gD<T1>(v2, arg5);
        0x1065ab063f42e795ce5bb99d05558a3e27dcefebc76fc4aac73f714ffb5078cf::cB::eA<T0>(arg0, 0x2::coin::into_balance<T0>(v1));
        0x1065ab063f42e795ce5bb99d05558a3e27dcefebc76fc4aac73f714ffb5078cf::cB::gD<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v3, arg5);
    }

    // decompiled from Move bytecode v6
}

