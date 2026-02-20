module 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::cancel {
    public fun cancel_wish<T0: copy + drop + store>(arg0: &mut 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::DragonBallCollector, arg1: &0x2::tx_context::TxContext) {
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_functional(arg0);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::wish_event::emit_cancel_wish_event<T0>(0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::into_inner<T0>(0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::take_locked_update<0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::TimeLock<T0>>(arg0, 0x1::type_name::with_defining_ids<T0>())));
    }

    // decompiled from Move bytecode v6
}

