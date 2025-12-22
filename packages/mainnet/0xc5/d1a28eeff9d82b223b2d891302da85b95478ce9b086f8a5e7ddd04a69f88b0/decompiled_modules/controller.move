module 0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::controller {
    public entry fun modify_add_register(arg0: &mut 0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::modify_add_register(arg0, arg1);
    }

    public entry fun modify_admin(arg0: &mut 0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::modify_admin(arg0, arg1);
    }

    public entry fun modify_burn_amount(arg0: &mut 0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::modify_burn_amount(arg0, arg1);
    }

    public entry fun modify_config<T0, T1>(arg0: &mut 0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::Global, arg1: bool, arg2: bool, arg3: address, arg4: address, arg5: u8, arg6: 0x1::ascii::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::admin(arg0) == 0x2::tx_context::sender(arg7), 201);
        0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::modify_pool_config<T0, T1>(arg0, arg2, arg1, arg3, arg4, arg5, arg6);
    }

    public entry fun modify_controller(arg0: &mut 0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::modify_controller(arg0, arg1);
    }

    public entry fun modify_last_time<T0, T1>(arg0: &mut 0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::modify_last_time<T0, T1>(arg0, arg1);
    }

    public entry fun modify_pool_fee(arg0: &mut 0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::modify_pool_fee(arg0, arg1);
    }

    public entry fun modify_rebot_addr<T0, T1>(arg0: &mut 0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::modify_rebot_addr<T0, T1>(arg0, arg1);
    }

    public entry fun modify_register_flag(arg0: &mut 0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::Global, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::modify_register_flag(arg0, arg1);
    }

    public entry fun modify_remove_register(arg0: &mut 0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::modify_remove_register(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::is_emergency(arg0), 202);
        assert!(0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::is_emergency(arg0), 203);
        assert!(0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xc5d1a28eeff9d82b223b2d891302da85b95478ce9b086f8a5e7ddd04a69f88b0::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

