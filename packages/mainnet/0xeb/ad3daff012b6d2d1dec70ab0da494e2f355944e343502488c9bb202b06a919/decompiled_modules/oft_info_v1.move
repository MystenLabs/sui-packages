module 0xebad3daff012b6d2d1dec70ab0da494e2f355944e343502488c9bb202b06a919::oft_info_v1 {
    struct OFTInfoV1 has copy, drop, store {
        oft_package: address,
        oft_object: address,
    }

    public fun create(arg0: address, arg1: address) : OFTInfoV1 {
        OFTInfoV1{
            oft_package : arg0,
            oft_object  : arg1,
        }
    }

    public fun decode(arg0: vector<u8>) : OFTInfoV1 {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::create(arg0);
        assert!(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u16(&mut v0) == 1, 2);
        let v1 = 0x2::bcs::new(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_bytes_until_end(&mut v0));
        let v2 = 0x2::bcs::into_remainder_bytes(v1);
        assert!(0x1::vector::is_empty<u8>(&v2), 1);
        OFTInfoV1{
            oft_package : 0x2::bcs::peel_address(&mut v1),
            oft_object  : 0x2::bcs::peel_address(&mut v1),
        }
    }

    public fun encode(arg0: &OFTInfoV1) : vector<u8> {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::new();
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u16(&mut v0, 1), 0x2::bcs::to_bytes<OFTInfoV1>(arg0));
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v0)
    }

    public fun oft_object(arg0: &OFTInfoV1) : address {
        arg0.oft_object
    }

    public fun oft_package(arg0: &OFTInfoV1) : address {
        arg0.oft_package
    }

    // decompiled from Move bytecode v6
}

