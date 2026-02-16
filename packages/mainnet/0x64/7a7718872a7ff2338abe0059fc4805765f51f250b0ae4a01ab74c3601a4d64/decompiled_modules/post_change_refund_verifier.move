module 0x647a7718872a7ff2338abe0059fc4805765f51f250b0ae4a01ab74c3601a4d64::post_change_refund_verifier {
    public fun post_change_refund_verifier(arg0: &0x647a7718872a7ff2338abe0059fc4805765f51f250b0ae4a01ab74c3601a4d64::setup::SuperAdminCap, arg1: &mut 0x647a7718872a7ff2338abe0059fc4805765f51f250b0ae4a01ab74c3601a4d64::state::State, arg2: address, arg3: u16, arg4: address) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        let v0 = 0x1::vector::empty<u8>();
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, 6);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg2));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v0, arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg4));
        assert!(0x1::vector::length<u8>(&v0) == 67, 0);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(0x647a7718872a7ff2338abe0059fc4805765f51f250b0ae4a01ab74c3601a4d64::state::borrow_mut_emitter_cap(arg1), 0, v0)
    }

    // decompiled from Move bytecode v6
}

