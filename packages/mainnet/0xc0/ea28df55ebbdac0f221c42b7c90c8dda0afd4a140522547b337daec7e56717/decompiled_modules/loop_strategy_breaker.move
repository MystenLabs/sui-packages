module 0xc0ea28df55ebbdac0f221c42b7c90c8dda0afd4a140522547b337daec7e56717::loop_strategy_breaker {
    public fun toggle_deposit(arg0: &0xc0ea28df55ebbdac0f221c42b7c90c8dda0afd4a140522547b337daec7e56717::loop_strategy_manage::BreakerCap, arg1: &mut 0xc0ea28df55ebbdac0f221c42b7c90c8dda0afd4a140522547b337daec7e56717::loop_strategy_core::Strategy, arg2: bool) {
        0xc0ea28df55ebbdac0f221c42b7c90c8dda0afd4a140522547b337daec7e56717::loop_strategy_core::assert_version(arg1);
        0xc0ea28df55ebbdac0f221c42b7c90c8dda0afd4a140522547b337daec7e56717::loop_strategy_core::toggle_deposit(arg1, arg2);
    }

    public fun toggle_withdraw(arg0: &0xc0ea28df55ebbdac0f221c42b7c90c8dda0afd4a140522547b337daec7e56717::loop_strategy_manage::BreakerCap, arg1: &mut 0xc0ea28df55ebbdac0f221c42b7c90c8dda0afd4a140522547b337daec7e56717::loop_strategy_core::Strategy, arg2: bool) {
        0xc0ea28df55ebbdac0f221c42b7c90c8dda0afd4a140522547b337daec7e56717::loop_strategy_core::assert_version(arg1);
        0xc0ea28df55ebbdac0f221c42b7c90c8dda0afd4a140522547b337daec7e56717::loop_strategy_core::toggle_withdraw(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

