module 0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::cancel {
    struct OrderCancelled has copy, drop {
        hash: address,
    }

    public fun cancel_order(arg0: &mut 0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::state::State, arg1: &0x2::clock::Clock, arg2: address, arg3: u8, arg4: address, arg5: u16, arg6: address, arg7: address, arg8: u16, arg9: address, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u16, arg16: address, arg17: u8, arg18: u8, arg19: u8, arg20: u64, arg21: u64, arg22: address, arg23: address) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::state::assert_valid_version(arg0);
        let v0 = 0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::order::new(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23);
        let v1 = 0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::order::to_hash(&v0);
        assert!(!0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::state::has_dest_order(arg0, v1), 0);
        assert!(arg8 == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 1);
        assert!(arg14 <= 0x2::clock::timestamp_ms(arg1) / 1000, 2);
        0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::state::cancel_order_dest(arg0, v1, arg5, arg6);
        let v2 = OrderCancelled{hash: v1};
        0x2::event::emit<OrderCancelled>(v2);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::state::borrow_mut_emitter_cap(arg0), 0, 0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::cancel_message::serialize(0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::cancel_message::new(v1, arg5, arg6, arg4, arg2, arg12, arg13)))
    }

    // decompiled from Move bytecode v6
}

