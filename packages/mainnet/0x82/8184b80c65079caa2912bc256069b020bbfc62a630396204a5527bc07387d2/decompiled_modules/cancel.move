module 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::cancel {
    public fun cancel_wish<T0: copy + drop + store>(arg0: &mut 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::DragonBallCollector, arg1: &0x2::tx_context::TxContext) {
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_functional(arg0);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::wish_event::emit_cancel_wish_event<T0>(0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::into_inner<T0>(0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::take_locked_update<0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::TimeLock<T0>>(arg0, 0x1::type_name::with_defining_ids<T0>())));
    }

    // decompiled from Move bytecode v6
}

