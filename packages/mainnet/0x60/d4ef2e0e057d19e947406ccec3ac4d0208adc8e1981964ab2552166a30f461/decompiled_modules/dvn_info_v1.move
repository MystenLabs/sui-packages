module 0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::dvn_info_v1 {
    struct DVNInfoV1 has copy, drop, store {
        dvn_object: address,
    }

    public fun create(arg0: address) : DVNInfoV1 {
        DVNInfoV1{dvn_object: arg0}
    }

    public fun decode(arg0: vector<u8>) : DVNInfoV1 {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::create(arg0);
        assert!(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u16(&mut v0) == 1, 2);
        let v1 = 0x2::bcs::new(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_bytes_until_end(&mut v0));
        let v2 = 0x2::bcs::into_remainder_bytes(v1);
        assert!(0x1::vector::is_empty<u8>(&v2), 1);
        DVNInfoV1{dvn_object: 0x2::bcs::peel_address(&mut v1)}
    }

    public fun dvn_object(arg0: &DVNInfoV1) : address {
        arg0.dvn_object
    }

    public fun encode(arg0: &DVNInfoV1) : vector<u8> {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::new();
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u16(&mut v0, 1), 0x2::bcs::to_bytes<DVNInfoV1>(arg0));
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v0)
    }

    // decompiled from Move bytecode v6
}

