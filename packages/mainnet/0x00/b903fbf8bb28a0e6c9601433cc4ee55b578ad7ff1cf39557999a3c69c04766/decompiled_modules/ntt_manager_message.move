module 0xb903fbf8bb28a0e6c9601433cc4ee55b578ad7ff1cf39557999a3c69c04766::ntt_manager_message {
    struct NttManagerMessage<T0> has copy, drop, store {
        id: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32,
        sender: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        payload: T0,
    }

    public fun borrow_payload<T0>(arg0: &NttManagerMessage<T0>) : &T0 {
        &arg0.payload
    }

    public fun destruct<T0>(arg0: NttManagerMessage<T0>) : (0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, T0) {
        let NttManagerMessage {
            id      : v0,
            sender  : v1,
            payload : v2,
        } = arg0;
        (v0, v1, v2)
    }

    public fun get_id<T0>(arg0: &NttManagerMessage<T0>) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32 {
        arg0.id
    }

    public fun new<T0>(arg0: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, arg2: T0) : NttManagerMessage<T0> {
        NttManagerMessage<T0>{
            id      : arg0,
            sender  : arg1,
            payload : arg2,
        }
    }

    public fun parse(arg0: vector<u8>) : NttManagerMessage<vector<u8>> {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        let v1 = &mut v0;
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        take_bytes(v1)
    }

    public fun take_bytes(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::Cursor<u8>) : NttManagerMessage<vector<u8>> {
        NttManagerMessage<vector<u8>>{
            id      : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::take_bytes(arg0),
            sender  : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::take_bytes(arg0),
            payload : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(arg0, (0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(arg0) as u64)),
        }
    }

    public fun to_bytes(arg0: NttManagerMessage<vector<u8>>) : vector<u8> {
        let NttManagerMessage {
            id      : v0,
            sender  : v1,
            payload : v2,
        } = arg0;
        let v3 = v2;
        assert!(0x1::vector::length<u8>(&v3) < 65535, 0);
        let v4 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v4, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::to_bytes(v0));
        0x1::vector::append<u8>(&mut v4, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(v1));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v4, (0x1::vector::length<u8>(&v3) as u16));
        0x1::vector::append<u8>(&mut v4, v3);
        v4
    }

    // decompiled from Move bytecode v6
}

