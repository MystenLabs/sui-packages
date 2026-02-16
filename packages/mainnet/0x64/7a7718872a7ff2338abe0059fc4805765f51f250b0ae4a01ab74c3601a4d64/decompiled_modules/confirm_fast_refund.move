module 0x647a7718872a7ff2338abe0059fc4805765f51f250b0ae4a01ab74c3601a4d64::confirm_fast_refund {
    public fun confirm_fast_refund(arg0: &mut 0x647a7718872a7ff2338abe0059fc4805765f51f250b0ae4a01ab74c3601a4d64::state::State, arg1: vector<u8>, arg2: vector<u8>, arg3: u8) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        let v0 = 0x647a7718872a7ff2338abe0059fc4805765f51f250b0ae4a01ab74c3601a4d64::verify_ir::verify_and_extract_payload(arg1, arg2, arg3);
        let (v1, _, _, _, _, _, _) = 0x647a7718872a7ff2338abe0059fc4805765f51f250b0ae4a01ab74c3601a4d64::refund_message::unpack(0x647a7718872a7ff2338abe0059fc4805765f51f250b0ae4a01ab74c3601a4d64::refund_message::deserialize(v0));
        0x647a7718872a7ff2338abe0059fc4805765f51f250b0ae4a01ab74c3601a4d64::state::add_refunded_order(arg0, v1);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(0x647a7718872a7ff2338abe0059fc4805765f51f250b0ae4a01ab74c3601a4d64::state::borrow_mut_emitter_cap(arg0), 0, v0)
    }

    // decompiled from Move bytecode v6
}

