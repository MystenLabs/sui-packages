module 0x7a6f82a3d0940342e0dcea39f5e12758853a74870d1698f80622a27b301586eb::confirm_fast_refund {
    public fun confirm_fast_refund(arg0: &mut 0x7a6f82a3d0940342e0dcea39f5e12758853a74870d1698f80622a27b301586eb::state::State, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: 0x7a6f82a3d0940342e0dcea39f5e12758853a74870d1698f80622a27b301586eb::order_info::OrderInfo) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        let v0 = 0x7a6f82a3d0940342e0dcea39f5e12758853a74870d1698f80622a27b301586eb::verify_ir::verify_and_extract_payload(arg1, arg2, arg3);
        let (v1, v2, v3, v4, _, v6, v7) = 0x7a6f82a3d0940342e0dcea39f5e12758853a74870d1698f80622a27b301586eb::refund_message::unpack(0x7a6f82a3d0940342e0dcea39f5e12758853a74870d1698f80622a27b301586eb::refund_message::deserialize(v0));
        assert!(0x7a6f82a3d0940342e0dcea39f5e12758853a74870d1698f80622a27b301586eb::order_info::compute_hash(&arg4) == v1, 0);
        assert!(0x7a6f82a3d0940342e0dcea39f5e12758853a74870d1698f80622a27b301586eb::order_info::trader(&arg4) == v4, 3);
        assert!(0x7a6f82a3d0940342e0dcea39f5e12758853a74870d1698f80622a27b301586eb::order_info::token_in(&arg4) == v3, 4);
        assert!(0x7a6f82a3d0940342e0dcea39f5e12758853a74870d1698f80622a27b301586eb::order_info::chain_source(&arg4) == v2, 5);
        assert!(v6 <= 0x7a6f82a3d0940342e0dcea39f5e12758853a74870d1698f80622a27b301586eb::order_info::fee_cancel(&arg4), 1);
        assert!(v7 <= 0x7a6f82a3d0940342e0dcea39f5e12758853a74870d1698f80622a27b301586eb::order_info::fee_refund(&arg4), 2);
        0x7a6f82a3d0940342e0dcea39f5e12758853a74870d1698f80622a27b301586eb::state::add_refunded_order(arg0, v1);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(0x7a6f82a3d0940342e0dcea39f5e12758853a74870d1698f80622a27b301586eb::state::borrow_mut_emitter_cap(arg0), 0, v0)
    }

    // decompiled from Move bytecode v6
}

