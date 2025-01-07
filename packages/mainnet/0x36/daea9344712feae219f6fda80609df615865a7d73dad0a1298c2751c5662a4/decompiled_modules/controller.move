module 0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::controller {
    public entry fun modify_add_register(arg0: &mut 0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::modify_add_register(arg0, arg1);
    }

    public entry fun modify_admin(arg0: &mut 0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::modify_admin(arg0, arg1);
    }

    public entry fun modify_burn_amount(arg0: &mut 0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::modify_burn_amount(arg0, arg1);
    }

    public entry fun modify_config<T0, T1>(arg0: &mut 0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::Global, arg1: bool, arg2: address, arg3: address, arg4: u8, arg5: 0x1::ascii::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::admin(arg0) == 0x2::tx_context::sender(arg6), 201);
        0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::modify_pool_config<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun modify_controller(arg0: &mut 0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::modify_controller(arg0, arg1);
    }

    public entry fun modify_last_time<T0, T1>(arg0: &mut 0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::modify_last_time<T0, T1>(arg0, arg1);
    }

    public entry fun modify_pool_fee(arg0: &mut 0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::modify_pool_fee(arg0, arg1);
    }

    public entry fun modify_rebot_addr<T0, T1>(arg0: &mut 0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::modify_rebot_addr<T0, T1>(arg0, arg1);
    }

    public entry fun modify_register_flag(arg0: &mut 0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::Global, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::modify_register_flag(arg0, arg1);
    }

    public entry fun modify_remove_register(arg0: &mut 0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::modify_remove_register(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::is_emergency(arg0), 202);
        assert!(0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::is_emergency(arg0), 203);
        assert!(0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

