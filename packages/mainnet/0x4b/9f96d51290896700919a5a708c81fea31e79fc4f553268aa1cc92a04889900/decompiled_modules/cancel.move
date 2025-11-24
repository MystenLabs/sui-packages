module 0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::cancel {
    public fun cancel_wish<T0: copy + drop + store>(arg0: &mut 0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::DragonBallCollector, arg1: &mut 0x2::tx_context::TxContext) {
        0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::time_lock::into_inner<T0>(0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::take_locked_update<0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::time_lock::TimeLock<T0>>(arg0, 0x1::type_name::with_defining_ids<T0>()));
        0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::wish_event::emit_cancel_wish_event<T0>();
    }

    // decompiled from Move bytecode v6
}

