module 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::controller {
    public entry fun modify_add_register(arg0: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::modify_add_register(arg0, arg1);
    }

    public entry fun modify_admin(arg0: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::modify_admin(arg0, arg1);
    }

    public entry fun modify_burn_amount(arg0: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::modify_burn_amount(arg0, arg1);
    }

    public entry fun modify_config<T0, T1>(arg0: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg1: bool, arg2: address, arg3: address, arg4: u8, arg5: 0x1::ascii::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::admin(arg0) == 0x2::tx_context::sender(arg6), 201);
        0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::modify_pool_config<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun modify_controller(arg0: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::modify_controller(arg0, arg1);
    }

    public entry fun modify_last_time<T0, T1>(arg0: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::modify_last_time<T0, T1>(arg0, arg1);
    }

    public entry fun modify_pool_fee(arg0: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::modify_pool_fee(arg0, arg1);
    }

    public entry fun modify_rebot_addr<T0, T1>(arg0: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::modify_rebot_addr<T0, T1>(arg0, arg1);
    }

    public entry fun modify_register_flag(arg0: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::modify_register_flag(arg0, arg1);
    }

    public entry fun modify_remove_register(arg0: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::modify_remove_register(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::is_emergency(arg0), 202);
        assert!(0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::is_emergency(arg0), 203);
        assert!(0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

