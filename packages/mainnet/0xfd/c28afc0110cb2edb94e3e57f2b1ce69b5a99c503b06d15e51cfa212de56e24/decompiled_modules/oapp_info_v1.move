module 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp_info_v1 {
    struct OAppInfoV1 has copy, drop, store {
        oapp_object: address,
        next_nonce_info: vector<u8>,
        lz_receive_info: vector<u8>,
        extra_info: vector<u8>,
    }

    public fun create(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : OAppInfoV1 {
        OAppInfoV1{
            oapp_object     : arg0,
            next_nonce_info : arg1,
            lz_receive_info : arg2,
            extra_info      : arg3,
        }
    }

    public fun decode(arg0: vector<u8>) : OAppInfoV1 {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::create(arg0);
        assert!(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u16(&mut v0) == 1, 2);
        let v1 = 0x2::bcs::new(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_bytes_until_end(&mut v0));
        let v2 = 0x2::bcs::into_remainder_bytes(v1);
        assert!(0x1::vector::is_empty<u8>(&v2), 1);
        OAppInfoV1{
            oapp_object     : 0x2::bcs::peel_address(&mut v1),
            next_nonce_info : 0x2::bcs::peel_vec_u8(&mut v1),
            lz_receive_info : 0x2::bcs::peel_vec_u8(&mut v1),
            extra_info      : 0x2::bcs::peel_vec_u8(&mut v1),
        }
    }

    public fun encode(arg0: &OAppInfoV1) : vector<u8> {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::new();
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u16(&mut v0, 1), 0x2::bcs::to_bytes<OAppInfoV1>(arg0));
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v0)
    }

    public fun extra_info(arg0: &OAppInfoV1) : &vector<u8> {
        &arg0.extra_info
    }

    public fun lz_receive_info(arg0: &OAppInfoV1) : &vector<u8> {
        &arg0.lz_receive_info
    }

    public fun next_nonce_info(arg0: &OAppInfoV1) : &vector<u8> {
        &arg0.next_nonce_info
    }

    public fun oapp_object(arg0: &OAppInfoV1) : address {
        arg0.oapp_object
    }

    // decompiled from Move bytecode v6
}

