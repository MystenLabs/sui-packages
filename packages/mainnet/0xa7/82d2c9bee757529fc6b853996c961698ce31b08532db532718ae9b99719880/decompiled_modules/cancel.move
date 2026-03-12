module 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::cancel {
    public fun cancel_wish<T0: copy + drop + store>(arg0: &mut 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::DragonBallCollector, arg1: &0x2::tx_context::TxContext) {
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::ensure_functional(arg0);
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::wish_event::emit_cancel_wish_event<T0>(0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::time_lock::into_inner<T0>(0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::take_locked_update<0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::time_lock::TimeLock<T0>>(arg0, 0x1::type_name::with_defining_ids<T0>())));
    }

    // decompiled from Move bytecode v6
}

