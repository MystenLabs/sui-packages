module 0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::cancel {
    struct OrderCancelled has copy, drop {
        hash: address,
    }

    public fun cancel_order(arg0: &mut 0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::state::State, arg1: &0x2::clock::Clock, arg2: address, arg3: u16, arg4: address, arg5: address, arg6: u16, arg7: address, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: address, arg14: u8, arg15: u8, arg16: u8, arg17: address, arg18: &0x2::tx_context::TxContext) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        let v0 = 0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::order::new(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
        let v1 = 0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::order::to_hash(&v0);
        assert!(!0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::state::has_dest_order(arg0, v1), 0);
        assert!(arg6 == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 1);
        assert!(arg12 <= 0x2::clock::timestamp_ms(arg1) / 1000, 2);
        0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::state::cancel_order_dest(arg0, v1, arg3, arg4);
        let v2 = OrderCancelled{hash: v1};
        0x2::event::emit<OrderCancelled>(v2);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::state::borrow_mut_emitter_cap(arg0), 0, 0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::cancel_message::serialize(0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::cancel_message::new(v1, arg3, arg4, arg2, 0x2::tx_context::sender(arg18), arg10, arg11)))
    }

    // decompiled from Move bytecode v6
}

