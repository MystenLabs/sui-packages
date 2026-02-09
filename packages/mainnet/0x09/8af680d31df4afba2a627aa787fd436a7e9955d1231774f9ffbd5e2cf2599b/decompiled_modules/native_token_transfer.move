module 0x98af680d31df4afba2a627aa787fd436a7e9955d1231774f9ffbd5e2cf2599b::native_token_transfer {
    struct NativeTokenTransfer has copy, drop, store {
        amount: 0x98af680d31df4afba2a627aa787fd436a7e9955d1231774f9ffbd5e2cf2599b::trimmed_amount::TrimmedAmount,
        source_token: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        to: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        to_chain: u16,
        payload: 0x1::option::Option<vector<u8>>,
    }

    public fun to_bytes(arg0: NativeTokenTransfer) : vector<u8> {
        let NativeTokenTransfer {
            amount       : v0,
            source_token : v1,
            to           : v2,
            to_chain     : v3,
            payload      : v4,
        } = arg0;
        let v5 = v4;
        let v6 = v0;
        let v7 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v7, x"994e5454");
        0x1::vector::append<u8>(&mut v7, 0x98af680d31df4afba2a627aa787fd436a7e9955d1231774f9ffbd5e2cf2599b::trimmed_amount::to_bytes(&v6));
        0x1::vector::append<u8>(&mut v7, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(v1));
        0x1::vector::append<u8>(&mut v7, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(v2));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v7, v3);
        if (0x1::option::is_some<vector<u8>>(&v5)) {
            let v8 = 0x1::option::destroy_some<vector<u8>>(v5);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v7, (0x1::vector::length<u8>(&v8) as u16));
            0x1::vector::append<u8>(&mut v7, v8);
        };
        v7
    }

    public fun borrow_payload(arg0: &NativeTokenTransfer) : &0x1::option::Option<vector<u8>> {
        &arg0.payload
    }

    public fun destruct(arg0: NativeTokenTransfer) : (0x98af680d31df4afba2a627aa787fd436a7e9955d1231774f9ffbd5e2cf2599b::trimmed_amount::TrimmedAmount, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, u16, 0x1::option::Option<vector<u8>>) {
        let NativeTokenTransfer {
            amount       : v0,
            source_token : v1,
            to           : v2,
            to_chain     : v3,
            payload      : v4,
        } = arg0;
        (v0, v1, v2, v3, v4)
    }

    public fun get_to_chain(arg0: &NativeTokenTransfer) : u16 {
        arg0.to_chain
    }

    public fun new(arg0: 0x98af680d31df4afba2a627aa787fd436a7e9955d1231774f9ffbd5e2cf2599b::trimmed_amount::TrimmedAmount, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, arg2: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, arg3: u16, arg4: 0x1::option::Option<vector<u8>>) : NativeTokenTransfer {
        NativeTokenTransfer{
            amount       : arg0,
            source_token : arg1,
            to           : arg2,
            to_chain     : arg3,
            payload      : arg4,
        }
    }

    public fun parse(arg0: vector<u8>) : NativeTokenTransfer {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        let v1 = &mut v0;
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        take_bytes(v1)
    }

    public fun take_bytes(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::Cursor<u8>) : NativeTokenTransfer {
        assert!(0x98af680d31df4afba2a627aa787fd436a7e9955d1231774f9ffbd5e2cf2599b::bytes4::to_bytes(0x98af680d31df4afba2a627aa787fd436a7e9955d1231774f9ffbd5e2cf2599b::bytes4::take(arg0)) == x"994e5454", 13906834603840176130);
        let v0 = if (!0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::is_empty<u8>(arg0)) {
            0x1::option::some<vector<u8>>(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(arg0, (0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(arg0) as u64)))
        } else {
            0x1::option::none<vector<u8>>()
        };
        NativeTokenTransfer{
            amount       : 0x98af680d31df4afba2a627aa787fd436a7e9955d1231774f9ffbd5e2cf2599b::trimmed_amount::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u64_be(arg0), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(arg0)),
            source_token : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::take_bytes(arg0),
            to           : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::take_bytes(arg0),
            to_chain     : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(arg0),
            payload      : v0,
        }
    }

    // decompiled from Move bytecode v6
}

