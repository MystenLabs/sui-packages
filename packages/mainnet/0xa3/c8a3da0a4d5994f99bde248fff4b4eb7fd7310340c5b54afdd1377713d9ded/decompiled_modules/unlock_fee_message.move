module 0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::unlock_fee_message {
    struct UnlockFeeMessage has drop {
        cctp_nonce: u64,
        cctp_domain: u32,
        addr_unlocker: address,
        gas_drop: u64,
    }

    public(friend) fun new(arg0: u64, arg1: u32, arg2: address, arg3: u64) : UnlockFeeMessage {
        UnlockFeeMessage{
            cctp_nonce    : arg0,
            cctp_domain   : arg1,
            addr_unlocker : arg2,
            gas_drop      : arg3,
        }
    }

    public(friend) fun to_hash(arg0: &UnlockFeeMessage) : address {
        let v0 = 0x1::vector::empty<u8>();
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, 4);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, 1);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.cctp_nonce);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u32_be(&mut v0, arg0.cctp_domain);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.addr_unlocker));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.gas_drop);
        0x2::address::from_bytes(0x2::hash::keccak256(&v0))
    }

    public fun unlock_fee_message_payload_type() : u8 {
        1
    }

    public(friend) fun unpack(arg0: UnlockFeeMessage) : (u64, u32, address, u64) {
        let UnlockFeeMessage {
            cctp_nonce    : v0,
            cctp_domain   : v1,
            addr_unlocker : v2,
            gas_drop      : v3,
        } = arg0;
        (v0, v1, v2, v3)
    }

    // decompiled from Move bytecode v6
}

