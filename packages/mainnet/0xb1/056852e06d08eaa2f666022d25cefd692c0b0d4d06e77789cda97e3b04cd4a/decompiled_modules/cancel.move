module 0xb1056852e06d08eaa2f666022d25cefd692c0b0d4d06e77789cda97e3b04cd4a::cancel {
    struct OrderCancelled has copy, drop {
        hash: address,
    }

    public fun cancel_order(arg0: &mut 0xb1056852e06d08eaa2f666022d25cefd692c0b0d4d06e77789cda97e3b04cd4a::state::State, arg1: &0x2::clock::Clock, arg2: address, arg3: address, arg4: u16, arg5: address, arg6: address, arg7: u16, arg8: address, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: address, arg15: u8, arg16: u8, arg17: u8, arg18: address) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        let v0 = 0xb1056852e06d08eaa2f666022d25cefd692c0b0d4d06e77789cda97e3b04cd4a::order::new(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
        let v1 = 0xb1056852e06d08eaa2f666022d25cefd692c0b0d4d06e77789cda97e3b04cd4a::order::to_hash(&v0);
        assert!(!0xb1056852e06d08eaa2f666022d25cefd692c0b0d4d06e77789cda97e3b04cd4a::state::has_dest_order(arg0, v1), 0);
        assert!(arg7 == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 1);
        assert!(arg13 <= 0x2::clock::timestamp_ms(arg1) / 1000, 2);
        0xb1056852e06d08eaa2f666022d25cefd692c0b0d4d06e77789cda97e3b04cd4a::state::cancel_order_dest(arg0, v1, arg4, arg5);
        let v2 = OrderCancelled{hash: v1};
        0x2::event::emit<OrderCancelled>(v2);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(0xb1056852e06d08eaa2f666022d25cefd692c0b0d4d06e77789cda97e3b04cd4a::state::borrow_mut_emitter_cap(arg0), 0, 0xb1056852e06d08eaa2f666022d25cefd692c0b0d4d06e77789cda97e3b04cd4a::cancel_message::serialize(0xb1056852e06d08eaa2f666022d25cefd692c0b0d4d06e77789cda97e3b04cd4a::cancel_message::new(v1, arg4, arg5, arg3, arg2, arg11, arg12)))
    }

    // decompiled from Move bytecode v6
}

