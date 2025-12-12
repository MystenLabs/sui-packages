module 0x59f041cc67d468ba52a54b5c698e881e094e3e4578f0142896dc16aa7e09bfdb::flow3 {
    public fun swap_exact_input<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u128, arg5: u64, arg6: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        (v0, 0x2::coin::value<T1>(&v0))
    }

    public fun atob<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let (v0, v1, v2) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(arg0, true, true, arg2, 4295048016, arg4, arg3, arg5);
        let v3 = v1;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0x59f041cc67d468ba52a54b5c698e881e094e3e4578f0142896dc16aa7e09bfdb::help::merge_all<T0>(arg1, arg5);
        0x59f041cc67d468ba52a54b5c698e881e094e3e4578f0142896dc16aa7e09bfdb::help::transfer<T0>(v4, 0x2::tx_context::sender(arg5));
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(arg0, v2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, arg2, arg5)), 0x2::balance::zero<T1>(), arg4, arg5);
        (0x2::coin::from_balance<T1>(v3, arg5), 0x2::balance::value<T1>(&v3))
    }

    public fun atob1<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T1>>, u64) {
        let (v0, v1) = atob<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v2, v0);
        (v2, v1)
    }

    public fun btoa<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let (v0, v1, v2) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(arg0, false, true, arg2, 79226673515401279992447579055, arg4, arg3, arg5);
        let v3 = v0;
        0x2::balance::destroy_zero<T1>(v1);
        let v4 = 0x59f041cc67d468ba52a54b5c698e881e094e3e4578f0142896dc16aa7e09bfdb::help::merge_all<T1>(arg1, arg5);
        0x59f041cc67d468ba52a54b5c698e881e094e3e4578f0142896dc16aa7e09bfdb::help::transfer<T1>(v4, 0x2::tx_context::sender(arg5));
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(arg0, v2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v4, arg2, arg5)), arg4, arg5);
        (0x2::coin::from_balance<T0>(v3, arg5), 0x2::balance::value<T0>(&v3))
    }

    public fun btoa1<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T0>>, u64) {
        let (v0, v1) = btoa<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, v0);
        (v2, v1)
    }

    public fun fswap<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let v0 = 0x59f041cc67d468ba52a54b5c698e881e094e3e4578f0142896dc16aa7e09bfdb::help::merge_all<T0>(arg2, arg9);
        0x59f041cc67d468ba52a54b5c698e881e094e3e4578f0142896dc16aa7e09bfdb::help::transfer<T0>(v0, 0x2::tx_context::sender(arg9));
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<T0, T1>(arg0, arg1, 0x2::coin::split<T0>(&mut v0, arg3, arg9), arg4, arg5, arg6, arg7, arg8, arg9);
        (v1, 0x2::coin::value<T1>(&v1))
    }

    public fun fswap2<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T1>>, u64) {
        let v0 = 0x59f041cc67d468ba52a54b5c698e881e094e3e4578f0142896dc16aa7e09bfdb::help::merge_all<T0>(arg2, arg9);
        0x59f041cc67d468ba52a54b5c698e881e094e3e4578f0142896dc16aa7e09bfdb::help::transfer<T0>(v0, 0x2::tx_context::sender(arg9));
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<T0, T1>(arg0, arg1, 0x2::coin::split<T0>(&mut v0, arg3, arg9), arg4, arg5, arg6, arg7, arg8, arg9);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v2, v1);
        (v2, 0x2::coin::value<T1>(&v1))
    }

    public fun swap_exact<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u128, arg5: u64, arg6: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<T0, T1>(arg0, arg1, 0x59f041cc67d468ba52a54b5c698e881e094e3e4578f0142896dc16aa7e09bfdb::help::merge_all<T0>(arg2, arg8), arg3, arg4, arg5, arg6, arg7, arg8);
        (v0, 0x2::coin::value<T1>(&v0))
    }

    public fun swap_exact2<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u128, arg5: u64, arg6: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T1>>, u64) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<T0, T1>(arg0, arg1, 0x59f041cc67d468ba52a54b5c698e881e094e3e4578f0142896dc16aa7e09bfdb::help::merge_all<T0>(arg2, arg8), arg3, arg4, arg5, arg6, arg7, arg8);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v1, v0);
        (v1, 0x2::coin::value<T1>(&v0))
    }

    public fun swap_exact_input2<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u128, arg5: u64, arg6: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T1>>, u64) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v1, v0);
        (v1, 0x2::coin::value<T1>(&v0))
    }

    // decompiled from Move bytecode v6
}

