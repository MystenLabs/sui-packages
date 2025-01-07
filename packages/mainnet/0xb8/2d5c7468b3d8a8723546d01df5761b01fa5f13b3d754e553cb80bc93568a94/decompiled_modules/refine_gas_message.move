module 0xb82d5c7468b3d8a8723546d01df5761b01fa5f13b3d754e553cb80bc93568a94::refine_gas_message {
    struct RefineGasMessage has drop {
        cctp_nonce: u64,
        cctp_domain: u32,
        addr_unlocker: address,
        gas_drop: u64,
        addr_dest: address,
    }

    public(friend) fun new(arg0: u64, arg1: u32, arg2: address, arg3: u64, arg4: address) : RefineGasMessage {
        RefineGasMessage{
            cctp_nonce    : arg0,
            cctp_domain   : arg1,
            addr_unlocker : arg2,
            gas_drop      : arg3,
            addr_dest     : arg4,
        }
    }

    public(friend) fun refine_gas_message_payload_type() : u8 {
        1
    }

    public(friend) fun to_hash(arg0: RefineGasMessage) : address {
        let v0 = 0x1::vector::empty<u8>();
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, 5);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, 1);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.cctp_nonce);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u32_be(&mut v0, arg0.cctp_domain);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.addr_unlocker));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.gas_drop);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.addr_dest));
        0x2::address::from_bytes(0x2::hash::keccak256(&v0))
    }

    public(friend) fun unpack(arg0: RefineGasMessage) : (u64, u32, address, u64, address) {
        let RefineGasMessage {
            cctp_nonce    : v0,
            cctp_domain   : v1,
            addr_unlocker : v2,
            gas_drop      : v3,
            addr_dest     : v4,
        } = arg0;
        (v0, v1, v2, v3, v4)
    }

    // decompiled from Move bytecode v6
}

