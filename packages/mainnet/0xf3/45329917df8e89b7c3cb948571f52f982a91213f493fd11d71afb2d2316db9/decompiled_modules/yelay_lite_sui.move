module 0xf345329917df8e89b7c3cb948571f52f982a91213f493fd11d71afb2d2316db9::yelay_lite_sui {
    public fun redeem(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap, arg1: u32, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::tx_context::sender(arg3)));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(arg0, arg1, v0)
    }

    // decompiled from Move bytecode v6
}

