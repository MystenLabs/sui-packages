module 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::beneficiary {
    public entry fun withdraw<T0, T1>(arg0: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::is_emergency(arg0), 302);
        assert!(0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::beneficiary(arg0) == 0x2::tx_context::sender(arg1), 301);
        let v0 = 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::get_mut_pool<T0, T1>(arg0, 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::is_order<T0, T1>());
        let (v1, v2, v3, v4) = 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::withdraw<T0, T1>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg1));
        0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::event::withdrew_event(0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::global_id<T0, T1>(v0), 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::generate_lp_name<T0, T1>(), v3, v4);
    }

    // decompiled from Move bytecode v6
}

