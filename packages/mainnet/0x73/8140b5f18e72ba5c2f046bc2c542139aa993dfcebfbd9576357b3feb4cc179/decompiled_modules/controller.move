module 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::controller {
    public fun add_black_list(arg0: &mut 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::add_black_list(arg0, arg1);
    }

    public fun add_white_list<T0, T1>(arg0: &mut 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::add_white_list<T0, T1>(arg0, arg1);
    }

    public fun create_swap_cap(arg0: &0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::owner::OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::SwapCap>(0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::create_swap_cap(arg1), 0x2::tx_context::sender(arg1));
    }

    public fun modify_buy_tax<T0, T1>(arg0: &mut 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::Global, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::modify_buy_tax<T0, T1>(arg0, arg1, arg2);
    }

    public fun modify_config<T0, T1>(arg0: &0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::owner::OwnerCap, arg1: &mut 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::Global, arg2: address, arg3: 0x1::ascii::String, arg4: &mut 0x2::tx_context::TxContext) {
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::modify_pool_config<T0, T1>(arg1, arg2, arg3);
    }

    public fun modify_controller(arg0: &0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::owner::OwnerCap, arg1: &mut 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::Global, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::modify_controller(arg1, arg2);
    }

    public fun modify_rebot_addr<T0, T1>(arg0: &0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::owner::OwnerCap, arg1: &mut 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::Global, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::modify_rebot_addr<T0, T1>(arg1, arg2);
    }

    public fun modify_sell_tax<T0, T1>(arg0: &mut 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::Global, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::modify_sell_tax<T0, T1>(arg0, arg1, arg2);
    }

    public fun modify_swap_caller<T0, T1>(arg0: &0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::owner::OwnerCap, arg1: &mut 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::Global, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::modify_swap_caller<T0, T1>(arg1, arg2);
    }

    public fun modify_switch_config<T0, T1>(arg0: &mut 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::Global, arg1: bool, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::controller(arg0) == 0x2::tx_context::sender(arg3), 201);
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::modify_switch_config<T0, T1>(arg0, arg1, arg2);
    }

    public fun pause(arg0: &0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::owner::OwnerCap, arg1: &mut 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::Global, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::is_emergency(arg1), 202);
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::pause(arg1);
    }

    public fun remove_black_list(arg0: &mut 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::remove_black_list(arg0, arg1);
    }

    public fun remove_white_list<T0, T1>(arg0: &mut 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::remove_white_list<T0, T1>(arg0, arg1);
    }

    public fun resume(arg0: &0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::owner::OwnerCap, arg1: &mut 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::Global, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::is_emergency(arg1), 203);
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::resume(arg1);
    }

    public fun upgrade_version(arg0: &0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::owner::OwnerCap, arg1: &mut 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::Global, arg2: &mut 0x2::tx_context::TxContext) {
        0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::implements::upgrade_version(arg1);
    }

    // decompiled from Move bytecode v7
}

