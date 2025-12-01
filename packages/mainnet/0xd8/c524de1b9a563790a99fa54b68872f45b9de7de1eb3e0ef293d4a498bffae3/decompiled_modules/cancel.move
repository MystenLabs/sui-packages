module 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::cancel {
    public fun cancel_wish<T0: copy + drop + store>(arg0: &mut 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::DragonBallCollector, arg1: &mut 0x2::tx_context::TxContext) {
        0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::time_lock::into_inner<T0>(0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::take_locked_update<0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::time_lock::TimeLock<T0>>(arg0, 0x1::type_name::with_defining_ids<T0>()));
        0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::wish_event::emit_cancel_wish_event<T0>();
    }

    // decompiled from Move bytecode v6
}

