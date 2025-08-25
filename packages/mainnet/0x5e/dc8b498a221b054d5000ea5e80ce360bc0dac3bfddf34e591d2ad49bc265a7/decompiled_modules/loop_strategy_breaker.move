module 0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_breaker {
    public fun toggle_deposit(arg0: &0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_manage::BreakerCap, arg1: &mut 0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_core::Strategy, arg2: bool) {
        0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_core::assert_version(arg1);
        0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_core::toggle_deposit(arg1, arg2);
    }

    public fun toggle_withdraw(arg0: &0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_manage::BreakerCap, arg1: &mut 0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_core::Strategy, arg2: bool) {
        0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_core::assert_version(arg1);
        0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_core::toggle_withdraw(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

