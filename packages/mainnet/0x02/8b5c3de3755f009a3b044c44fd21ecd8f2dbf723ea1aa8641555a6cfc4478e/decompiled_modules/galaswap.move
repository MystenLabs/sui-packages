module 0x28b5c3de3755f009a3b044c44fd21ecd8f2dbf723ea1aa8641555a6cfc4478e::galaswap {
    public entry fun create_pool<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        0x28b5c3de3755f009a3b044c44fd21ecd8f2dbf723ea1aa8641555a6cfc4478e::galapool::create_pool<T0, T1>(arg0);
    }

    public entry fun swap_x_to_y<T0, T1>(arg0: &mut 0x28b5c3de3755f009a3b044c44fd21ecd8f2dbf723ea1aa8641555a6cfc4478e::galapool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T0>(arg3);
        0x2::pay::join_vec<T0>(&mut v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x28b5c3de3755f009a3b044c44fd21ecd8f2dbf723ea1aa8641555a6cfc4478e::galapool::swap_x_to_y<T0, T1>(arg0, 0x2::coin::split<T0>(&mut v0, arg2, arg3), arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_y_to_x<T0, T1>(arg0: &mut 0x28b5c3de3755f009a3b044c44fd21ecd8f2dbf723ea1aa8641555a6cfc4478e::galapool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T1>(arg3);
        0x2::pay::join_vec<T1>(&mut v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x28b5c3de3755f009a3b044c44fd21ecd8f2dbf723ea1aa8641555a6cfc4478e::galapool::swap_y_to_x<T0, T1>(arg0, 0x2::coin::split<T1>(&mut v0, arg2, arg3), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun add_pool_amount<T0, T1>(arg0: &mut 0x28b5c3de3755f009a3b044c44fd21ecd8f2dbf723ea1aa8641555a6cfc4478e::galapool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T0>(arg5);
        0x2::pay::join_vec<T0>(&mut v0, arg1);
        let v1 = 0x2::coin::zero<T1>(arg5);
        0x2::pay::join_vec<T1>(&mut v1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x28b5c3de3755f009a3b044c44fd21ecd8f2dbf723ea1aa8641555a6cfc4478e::galapool::LPCoin<T0, T1>>>(0x28b5c3de3755f009a3b044c44fd21ecd8f2dbf723ea1aa8641555a6cfc4478e::galapool::add_pool<T0, T1>(arg0, 0x2::coin::split<T0>(&mut v0, arg3, arg5), 0x2::coin::split<T1>(&mut v1, arg4, arg5), arg5), 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg5));
    }

    public entry fun remove<T0, T1>(arg0: &mut 0x28b5c3de3755f009a3b044c44fd21ecd8f2dbf723ea1aa8641555a6cfc4478e::galapool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<0x28b5c3de3755f009a3b044c44fd21ecd8f2dbf723ea1aa8641555a6cfc4478e::galapool::LPCoin<T0, T1>>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<0x28b5c3de3755f009a3b044c44fd21ecd8f2dbf723ea1aa8641555a6cfc4478e::galapool::LPCoin<T0, T1>>(arg4);
        0x2::pay::join_vec<0x28b5c3de3755f009a3b044c44fd21ecd8f2dbf723ea1aa8641555a6cfc4478e::galapool::LPCoin<T0, T1>>(&mut v0, arg1);
        let (v1, v2) = 0x28b5c3de3755f009a3b044c44fd21ecd8f2dbf723ea1aa8641555a6cfc4478e::galapool::remove_pool<T0, T1>(arg0, &mut v0, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x28b5c3de3755f009a3b044c44fd21ecd8f2dbf723ea1aa8641555a6cfc4478e::galapool::LPCoin<T0, T1>>>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

