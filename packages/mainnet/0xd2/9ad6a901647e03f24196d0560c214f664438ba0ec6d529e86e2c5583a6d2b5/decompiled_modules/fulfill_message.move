module 0xd29ad6a901647e03f24196d0560c214f664438ba0ec6d529e86e2c5583a6d2b5::fulfill_message {
    struct FulfillMessage {
        hash: address,
        chain_source: u16,
        token_in: address,
        addr_dest: address,
        chain_dest: u16,
        token_out: address,
        amount_promised: u64,
        gas_drop: u64,
        deadline: u64,
        addr_ref: address,
        fee_rate_ref: u8,
        fee_rate_mayan: u8,
        driver: address,
    }

    public(friend) fun new(arg0: address, arg1: u16, arg2: address, arg3: address, arg4: u16, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: address, arg10: u8, arg11: u8, arg12: address) : FulfillMessage {
        FulfillMessage{
            hash            : arg0,
            chain_source    : arg1,
            token_in        : arg2,
            addr_dest       : arg3,
            chain_dest      : arg4,
            token_out       : arg5,
            amount_promised : arg6,
            gas_drop        : arg7,
            deadline        : arg8,
            addr_ref        : arg9,
            fee_rate_ref    : arg10,
            fee_rate_mayan  : arg11,
            driver          : arg12,
        }
    }

    public(friend) fun deserialize(arg0: vector<u8>) : FulfillMessage {
        assert!(0x1::vector::length<u8>(&arg0) == 223, 1);
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0) == 1, 0);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        FulfillMessage{
            hash            : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
            chain_source    : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(&mut v0),
            token_in        : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
            addr_dest       : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
            chain_dest      : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(&mut v0),
            token_out       : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
            amount_promised : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u64_be(&mut v0),
            gas_drop        : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u64_be(&mut v0),
            deadline        : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u64_be(&mut v0),
            addr_ref        : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
            fee_rate_ref    : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0),
            fee_rate_mayan  : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0),
            driver          : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
        }
    }

    public(friend) fun get_chain_dest(arg0: &FulfillMessage) : u16 {
        arg0.chain_dest
    }

    public(friend) fun get_driver(arg0: &FulfillMessage) : address {
        arg0.driver
    }

    public(friend) fun get_hash(arg0: &FulfillMessage) : address {
        arg0.hash
    }

    public(friend) fun unpack(arg0: FulfillMessage) : (address, u16, address, address, u16, address, u64, u64, u64, address, u8, u8, address) {
        let FulfillMessage {
            hash            : v0,
            chain_source    : v1,
            token_in        : v2,
            addr_dest       : v3,
            chain_dest      : v4,
            token_out       : v5,
            amount_promised : v6,
            gas_drop        : v7,
            deadline        : v8,
            addr_ref        : v9,
            fee_rate_ref    : v10,
            fee_rate_mayan  : v11,
            driver          : v12,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12)
    }

    // decompiled from Move bytecode v6
}

