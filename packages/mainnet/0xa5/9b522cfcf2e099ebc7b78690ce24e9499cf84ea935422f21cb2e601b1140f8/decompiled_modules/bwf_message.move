module 0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::bwf_message {
    struct BWFMessage {
        cctp_nonce: u64,
        cctp_domain: u32,
        addr_dest: address,
        gas_drop: u64,
        fee_redeem: u64,
        amount: u64,
        token_burned: address,
        payload: 0x1::option::Option<vector<u8>>,
    }

    public(friend) fun new(arg0: u64, arg1: u32, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: 0x1::option::Option<vector<u8>>) : BWFMessage {
        BWFMessage{
            cctp_nonce   : arg0,
            cctp_domain  : arg1,
            addr_dest    : arg2,
            gas_drop     : arg3,
            fee_redeem   : arg4,
            amount       : arg5,
            token_burned : arg6,
            payload      : arg7,
        }
    }

    public(friend) fun deserialize(arg0: vector<u8>) : BWFMessage {
        assert!(0x1::vector::length<u8>(&arg0) >= 102, 2);
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0) == 3, 0);
        let v1 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0);
        assert!(v1 == 1 || v1 == 2, 1);
        if (v1 == 1) {
            assert!(0x1::vector::length<u8>(&arg0) == 102, 2);
        };
        let v2 = if (v1 == 2) {
            0x1::option::some<vector<u8>>(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 0x1::vector::length<u8>(&arg0) - 102))
        } else {
            0x1::option::none<vector<u8>>()
        };
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        BWFMessage{
            cctp_nonce   : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u64_be(&mut v0),
            cctp_domain  : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u32_be(&mut v0),
            addr_dest    : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
            gas_drop     : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u64_be(&mut v0),
            fee_redeem   : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u64_be(&mut v0),
            amount       : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u64_be(&mut v0),
            token_burned : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
            payload      : v2,
        }
    }

    public(friend) fun serialize(arg0: BWFMessage) : vector<u8> {
        let (v0, v1, v2, v3, v4, v5, v6, v7) = unpack(arg0);
        let v8 = v7;
        let v9 = 0x1::vector::empty<u8>();
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v9, 3);
        let v10 = if (0x1::option::is_some<vector<u8>>(&v8) && 0x1::vector::length<u8>(0x1::option::borrow<vector<u8>>(&v8)) > 0) {
            2
        } else {
            1
        };
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v9, v10);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v9, v0);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u32_be(&mut v9, v1);
        0x1::vector::append<u8>(&mut v9, 0x2::address::to_bytes(v2));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v9, v3);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v9, v4);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v9, v5);
        0x1::vector::append<u8>(&mut v9, 0x2::address::to_bytes(v6));
        if (v10 == 2) {
            assert!(0x1::vector::length<u8>(&v9) > 102, 2);
        } else {
            assert!(0x1::vector::length<u8>(&v9) == 102, 2);
        };
        v9
    }

    public(friend) fun unpack(arg0: BWFMessage) : (u64, u32, address, u64, u64, u64, address, 0x1::option::Option<vector<u8>>) {
        let BWFMessage {
            cctp_nonce   : v0,
            cctp_domain  : v1,
            addr_dest    : v2,
            gas_drop     : v3,
            fee_redeem   : v4,
            amount       : v5,
            token_burned : v6,
            payload      : v7,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7)
    }

    // decompiled from Move bytecode v6
}

