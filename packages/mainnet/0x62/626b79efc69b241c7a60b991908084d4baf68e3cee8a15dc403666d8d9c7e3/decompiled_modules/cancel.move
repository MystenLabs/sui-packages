module 0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::cancel {
    public fun cancel_wish<T0: copy + drop + store>(arg0: &mut 0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::DragonBallCollector, arg1: &mut 0x2::tx_context::TxContext) {
        0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::wish_event::emit_cancel_wish_event<T0>(0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::time_lock::into_inner<T0>(0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::take_locked_update<0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::time_lock::TimeLock<T0>>(arg0, 0x1::type_name::with_defining_ids<T0>())));
    }

    // decompiled from Move bytecode v6
}

