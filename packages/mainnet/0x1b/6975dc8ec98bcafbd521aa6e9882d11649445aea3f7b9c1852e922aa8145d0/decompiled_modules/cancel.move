module 0x1b6975dc8ec98bcafbd521aa6e9882d11649445aea3f7b9c1852e922aa8145d0::cancel {
    struct OrderCancelled has copy, drop {
        hash: address,
    }

    public fun cancel_order(arg0: &mut 0x1b6975dc8ec98bcafbd521aa6e9882d11649445aea3f7b9c1852e922aa8145d0::state::State, arg1: &0x2::clock::Clock, arg2: address, arg3: u16, arg4: address, arg5: address, arg6: u16, arg7: address, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: address, arg14: u8, arg15: u8, arg16: u8, arg17: address, arg18: &0x2::tx_context::TxContext) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        let v0 = 0x1b6975dc8ec98bcafbd521aa6e9882d11649445aea3f7b9c1852e922aa8145d0::order::new(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
        let v1 = 0x1b6975dc8ec98bcafbd521aa6e9882d11649445aea3f7b9c1852e922aa8145d0::order::to_hash(&v0);
        assert!(!0x1b6975dc8ec98bcafbd521aa6e9882d11649445aea3f7b9c1852e922aa8145d0::state::has_dest_order(arg0, v1), 0);
        assert!(arg6 == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 1);
        assert!(arg12 <= 0x2::clock::timestamp_ms(arg1) / 1000, 2);
        0x1b6975dc8ec98bcafbd521aa6e9882d11649445aea3f7b9c1852e922aa8145d0::state::cancel_order_dest(arg0, v1, arg3, arg4);
        let v2 = OrderCancelled{hash: v1};
        0x2::event::emit<OrderCancelled>(v2);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(0x1b6975dc8ec98bcafbd521aa6e9882d11649445aea3f7b9c1852e922aa8145d0::state::borrow_mut_emitter_cap(arg0), 0, 0x1b6975dc8ec98bcafbd521aa6e9882d11649445aea3f7b9c1852e922aa8145d0::cancel_message::serialize(0x1b6975dc8ec98bcafbd521aa6e9882d11649445aea3f7b9c1852e922aa8145d0::cancel_message::new(v1, arg3, arg4, arg2, 0x2::tx_context::sender(arg18), arg10, arg11)))
    }

    // decompiled from Move bytecode v6
}

