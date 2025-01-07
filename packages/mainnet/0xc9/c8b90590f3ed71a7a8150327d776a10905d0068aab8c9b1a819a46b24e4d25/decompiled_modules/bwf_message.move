module 0xc9c8b90590f3ed71a7a8150327d776a10905d0068aab8c9b1a819a46b24e4d25::bwf_message {
    struct BWFMessage has drop {
        payload_type: u8,
        cctp_nonce: u64,
        cctp_domain: u32,
        addr_dest: address,
        gas_drop: u64,
        fee_redeem: u64,
        amount: u64,
        token_burned: address,
        custom_payload_hash: address,
    }

    public(friend) fun bwf_message_payload_type_custom() : u8 {
        2
    }

    public(friend) fun bwf_message_payload_type_default() : u8 {
        1
    }

    public(friend) fun new(arg0: u8, arg1: u64, arg2: u32, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: address) : BWFMessage {
        assert!(arg0 == 1 || arg0 == 2, 0);
        BWFMessage{
            payload_type        : arg0,
            cctp_nonce          : arg1,
            cctp_domain         : arg2,
            addr_dest           : arg3,
            gas_drop            : arg4,
            fee_redeem          : arg5,
            amount              : arg6,
            token_burned        : arg7,
            custom_payload_hash : arg8,
        }
    }

    public(friend) fun to_hash(arg0: &BWFMessage) : address {
        let v0 = 0x1::vector::empty<u8>();
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, 3);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, arg0.payload_type);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.cctp_nonce);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u32_be(&mut v0, arg0.cctp_domain);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.addr_dest));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.gas_drop);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.fee_redeem);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.amount);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.token_burned));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.custom_payload_hash));
        0x2::address::from_bytes(0x2::hash::keccak256(&v0))
    }

    public(friend) fun unpack(arg0: BWFMessage) : (u8, u64, u32, address, u64, u64, u64, address, address) {
        let BWFMessage {
            payload_type        : v0,
            cctp_nonce          : v1,
            cctp_domain         : v2,
            addr_dest           : v3,
            gas_drop            : v4,
            fee_redeem          : v5,
            amount              : v6,
            token_burned        : v7,
            custom_payload_hash : v8,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8)
    }

    // decompiled from Move bytecode v6
}

