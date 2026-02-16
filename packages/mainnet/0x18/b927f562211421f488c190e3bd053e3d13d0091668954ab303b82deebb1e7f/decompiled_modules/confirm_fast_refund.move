module 0x18b927f562211421f488c190e3bd053e3d13d0091668954ab303b82deebb1e7f::confirm_fast_refund {
    public fun confirm_fast_refund(arg0: &mut 0x18b927f562211421f488c190e3bd053e3d13d0091668954ab303b82deebb1e7f::state::State, arg1: vector<u8>, arg2: vector<u8>, arg3: u8) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        let v0 = 0x18b927f562211421f488c190e3bd053e3d13d0091668954ab303b82deebb1e7f::verify_ir::verify_and_extract_payload(arg1, arg2, arg3);
        let (v1, _, _, _, _, _, _) = 0x18b927f562211421f488c190e3bd053e3d13d0091668954ab303b82deebb1e7f::refund_message::unpack(0x18b927f562211421f488c190e3bd053e3d13d0091668954ab303b82deebb1e7f::refund_message::deserialize(v0));
        0x18b927f562211421f488c190e3bd053e3d13d0091668954ab303b82deebb1e7f::state::add_refunded_order(arg0, v1);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(0x18b927f562211421f488c190e3bd053e3d13d0091668954ab303b82deebb1e7f::state::borrow_mut_emitter_cap(arg0), 0, v0)
    }

    // decompiled from Move bytecode v6
}

