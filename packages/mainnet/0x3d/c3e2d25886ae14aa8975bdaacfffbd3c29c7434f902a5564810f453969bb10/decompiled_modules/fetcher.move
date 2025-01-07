module 0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::fetcher {
    struct PendingReward has copy, drop {
        position: 0x2::object::ID,
        pending_ostr_reward: u64,
    }

    public entry fun fetch_pending_reward(arg0: &0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::state::State, arg1: u64, arg2: address, arg3: &0x2::clock::Clock) {
        let v0 = 0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::position_registry::borrow_position(0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::state::borrow_position_registry(arg0), arg1, arg2);
        let v1 = PendingReward{
            position            : 0x2::object::id<0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::position::Position>(v0),
            pending_ostr_reward : 0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::pool::pending_ostr(0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::pool_registry::borrow_pool(0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::state::borrow_pool_registry(arg0), arg1), v0, 0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::state::total_alloc_point(arg0), 0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::state::ostr_per_ms(arg0), arg3),
        };
        0x2::event::emit<PendingReward>(v1);
    }

    // decompiled from Move bytecode v6
}

