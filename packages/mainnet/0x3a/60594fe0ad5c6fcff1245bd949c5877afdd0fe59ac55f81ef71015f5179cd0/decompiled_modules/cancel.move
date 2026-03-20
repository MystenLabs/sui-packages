module 0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::cancel {
    public fun cancel_wish<T0: copy + drop + store>(arg0: &mut 0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::DragonBallCollector, arg1: &0x2::tx_context::TxContext) {
        0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::ensure_functional(arg0);
        0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::wish_event::emit_cancel_wish_event<T0>(0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::time_lock::into_inner<T0>(0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::take_locked_update<0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::time_lock::TimeLock<T0>>(arg0, 0x1::type_name::with_defining_ids<T0>())));
    }

    // decompiled from Move bytecode v6
}

