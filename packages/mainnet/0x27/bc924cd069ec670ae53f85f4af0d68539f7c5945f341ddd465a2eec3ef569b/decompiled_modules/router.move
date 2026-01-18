module 0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::router {
    fun assert_min_output<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    fun assert_path_2(arg0: &vector<u8>, arg1: u8, arg2: u8) {
        assert!(0x1::vector::length<u8>(arg0) == 2, 0);
        let v0 = 0x1::vector::borrow<u8>(arg0, 1);
        assert!(*0x1::vector::borrow<u8>(arg0, 0) == arg1, 0);
        assert!(*v0 == arg2, 0);
    }

    public fun dex_bluefin() : u8 {
        3
    }

    public fun dex_cetus() : u8 {
        1
    }

    public fun dex_flowx() : u8 {
        2
    }

    public fun swap_path_bluefin_cetus<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_path_2(&arg1, 3, 1);
        let v0 = 0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::cetus_adapter::swap_a2b<T1, T2>(0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::bluefin_adapter::swap_a2b<T0, T1>(arg0, arg2, arg3, arg6, arg8), arg4, arg5, arg6, arg8);
        assert_min_output<T2>(&v0, arg7);
        v0
    }

    entry fun swap_path_bluefin_cetus_entry<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_path_bluefin_cetus<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg8));
    }

    public fun swap_path_bluefin_cetus_reverse<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_path_2(&arg1, 3, 1);
        let v0 = 0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::cetus_adapter::swap_b2a<T2, T1>(0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::bluefin_adapter::swap_b2a<T1, T0>(arg0, arg2, arg3, arg6, arg8), arg4, arg5, arg6, arg8);
        assert_min_output<T2>(&v0, arg7);
        v0
    }

    entry fun swap_path_bluefin_cetus_reverse_entry<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_path_bluefin_cetus_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg8));
    }

    public fun swap_path_bluefin_flowx<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T1, T2>, arg5: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_path_2(&arg1, 3, 2);
        let v0 = 0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::flowx_adapter::swap_x_to_y<T1, T2>(0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::bluefin_adapter::swap_a2b<T0, T1>(arg0, arg2, arg3, arg6, arg8), arg4, arg5, arg6, arg8);
        assert_min_output<T2>(&v0, arg7);
        v0
    }

    entry fun swap_path_bluefin_flowx_entry<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T1, T2>, arg5: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_path_bluefin_flowx<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg8));
    }

    public fun swap_path_bluefin_flowx_reverse<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T2, T1>, arg5: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_path_2(&arg1, 3, 2);
        let v0 = 0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::flowx_adapter::swap_y_to_x<T2, T1>(0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::bluefin_adapter::swap_b2a<T1, T0>(arg0, arg2, arg3, arg6, arg8), arg4, arg5, arg6, arg8);
        assert_min_output<T2>(&v0, arg7);
        v0
    }

    entry fun swap_path_bluefin_flowx_reverse_entry<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T2, T1>, arg5: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_path_bluefin_flowx_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg8));
    }

    public fun swap_path_cetus_bluefin<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_path_2(&arg1, 1, 3);
        let v0 = 0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::bluefin_adapter::swap_a2b<T1, T2>(0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::cetus_adapter::swap_a2b<T0, T1>(arg0, arg2, arg3, arg6, arg8), arg4, arg5, arg6, arg8);
        assert_min_output<T2>(&v0, arg7);
        v0
    }

    entry fun swap_path_cetus_bluefin_entry<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_path_cetus_bluefin<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg8));
    }

    public fun swap_path_cetus_bluefin_reverse<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_path_2(&arg1, 1, 3);
        let v0 = 0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::bluefin_adapter::swap_b2a<T2, T1>(0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::cetus_adapter::swap_b2a<T1, T0>(arg0, arg2, arg3, arg6, arg8), arg4, arg5, arg6, arg8);
        assert_min_output<T2>(&v0, arg7);
        v0
    }

    entry fun swap_path_cetus_bluefin_reverse_entry<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_path_cetus_bluefin_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg8));
    }

    public fun swap_path_cetus_flowx<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T1, T2>, arg5: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_path_2(&arg1, 1, 2);
        let v0 = 0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::flowx_adapter::swap_x_to_y<T1, T2>(0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::cetus_adapter::swap_a2b<T0, T1>(arg0, arg2, arg3, arg6, arg8), arg4, arg5, arg6, arg8);
        assert_min_output<T2>(&v0, arg7);
        v0
    }

    entry fun swap_path_cetus_flowx_entry<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T1, T2>, arg5: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_path_cetus_flowx<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg8));
    }

    public fun swap_path_cetus_flowx_reverse<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T2, T1>, arg5: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_path_2(&arg1, 1, 2);
        let v0 = 0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::flowx_adapter::swap_y_to_x<T2, T1>(0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::cetus_adapter::swap_b2a<T1, T0>(arg0, arg2, arg3, arg6, arg8), arg4, arg5, arg6, arg8);
        assert_min_output<T2>(&v0, arg7);
        v0
    }

    entry fun swap_path_cetus_flowx_reverse_entry<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T2, T1>, arg5: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_path_cetus_flowx_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg8));
    }

    public fun swap_path_flowx_bluefin<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_path_2(&arg1, 2, 3);
        let v0 = 0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::bluefin_adapter::swap_a2b<T1, T2>(0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::flowx_adapter::swap_x_to_y<T0, T1>(arg0, arg2, arg3, arg6, arg8), arg4, arg5, arg6, arg8);
        assert_min_output<T2>(&v0, arg7);
        v0
    }

    entry fun swap_path_flowx_bluefin_entry<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_path_flowx_bluefin<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg8));
    }

    public fun swap_path_flowx_bluefin_reverse<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T1, T0>, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_path_2(&arg1, 2, 3);
        let v0 = 0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::bluefin_adapter::swap_b2a<T2, T1>(0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::flowx_adapter::swap_y_to_x<T1, T0>(arg0, arg2, arg3, arg6, arg8), arg4, arg5, arg6, arg8);
        assert_min_output<T2>(&v0, arg7);
        v0
    }

    entry fun swap_path_flowx_bluefin_reverse_entry<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T1, T0>, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_path_flowx_bluefin_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg8));
    }

    public fun swap_path_flowx_cetus<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_path_2(&arg1, 2, 1);
        let v0 = 0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::cetus_adapter::swap_a2b<T1, T2>(0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::flowx_adapter::swap_x_to_y<T0, T1>(arg0, arg2, arg3, arg6, arg8), arg4, arg5, arg6, arg8);
        assert_min_output<T2>(&v0, arg7);
        v0
    }

    entry fun swap_path_flowx_cetus_entry<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_path_flowx_cetus<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg8));
    }

    public fun swap_path_flowx_cetus_reverse<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T1, T0>, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_path_2(&arg1, 2, 1);
        let v0 = 0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::cetus_adapter::swap_b2a<T2, T1>(0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::flowx_adapter::swap_y_to_x<T1, T0>(arg0, arg2, arg3, arg6, arg8), arg4, arg5, arg6, arg8);
        assert_min_output<T2>(&v0, arg7);
        v0
    }

    entry fun swap_path_flowx_cetus_reverse_entry<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T1, T0>, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_path_flowx_cetus_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg8));
    }

    public fun swap_single_cetus_a2b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::cetus_adapter::swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg5);
        assert_min_output<T1>(&v0, arg4);
        v0
    }

    entry fun swap_single_cetus_a2b_entry<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_single_cetus_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun swap_single_cetus_b2a<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::cetus_adapter::swap_b2a<T1, T0>(arg0, arg1, arg2, arg3, arg5);
        assert_min_output<T1>(&v0, arg4);
        v0
    }

    entry fun swap_single_cetus_b2a_entry<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_single_cetus_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun swap_single_flowx_exact_in<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: u64, arg6: u128, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<T0, T1>(arg1, arg2, arg0, 0, arg6, arg7, arg3, arg4, arg8);
        assert_min_output<T1>(&v0, arg5);
        v0
    }

    entry fun swap_single_flowx_exact_in_entry<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: u64, arg6: u128, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_single_flowx_exact_in<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg8));
    }

    public fun swap_single_flowx_x_to_y<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::flowx_adapter::swap_x_to_y<T0, T1>(arg0, arg1, arg2, arg3, arg5);
        assert_min_output<T1>(&v0, arg4);
        v0
    }

    entry fun swap_single_flowx_x_to_y_entry<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_single_flowx_x_to_y<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun swap_single_flowx_y_to_x<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T1, T0>, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::flowx_adapter::swap_y_to_x<T1, T0>(arg0, arg1, arg2, arg3, arg5);
        assert_min_output<T1>(&v0, arg4);
        v0
    }

    entry fun swap_single_flowx_y_to_x_entry<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T1, T0>, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_single_flowx_y_to_x<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

