module 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::worker_options {
    struct DVNOptions has copy, drop, store {
        options: vector<u8>,
        dvn_idx: u8,
    }

    fun append_dvn_option(arg0: &mut vector<DVNOptions>, arg1: vector<u8>) {
        let v0 = *0x1::vector::borrow<u8>(&arg1, 3);
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<DVNOptions>(arg0)) {
            if (0x1::vector::borrow<DVNOptions>(arg0, v1).dvn_idx == v0) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 4 */
                if (0x1::option::is_some<u64>(&v2)) {
                    0x1::vector::append<u8>(&mut 0x1::vector::borrow_mut<DVNOptions>(arg0, 0x1::option::destroy_some<u64>(v2)).options, arg1);
                } else {
                    let v3 = DVNOptions{
                        options : arg1,
                        dvn_idx : v0,
                    };
                    0x1::vector::push_back<DVNOptions>(arg0, v3);
                };
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 4 */
    }

    fun append_lz_receive_option(arg0: &mut 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::Writer, arg1: u128) {
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u128(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u8(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u16(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u8(arg0, 1), 17), 1), arg1);
    }

    fun append_native_drop_option(arg0: &mut 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::Writer, arg1: u128, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32) {
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes32(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u128(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u8(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u16(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u8(arg0, 1), 49), 2), arg1), arg2);
    }

    public fun convert_legacy_options(arg0: &mut 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::Reader, arg1: u16) : vector<u8> {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::new();
        let v1 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::remaining_length(arg0);
        if (arg1 == 1) {
            assert!(v1 == 32, 1);
            let v2 = &mut v0;
            append_lz_receive_option(v2, (0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u256(arg0) as u128));
        } else {
            assert!(arg1 == 2, 4);
            assert!(v1 > 64 && v1 <= 96, 2);
            let v3 = &mut v0;
            append_lz_receive_option(v3, (0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u256(arg0) as u128));
            let v4 = &mut v0;
            append_native_drop_option(v4, (0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u256(arg0) as u128), 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes_left_padded(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_bytes_until_end(arg0)));
        };
        assert!(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::remaining_length(arg0) == 0, 3);
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v0)
    }

    public fun extract_type_3_options(arg0: &mut 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::Reader) : (vector<u8>, vector<DVNOptions>) {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::new();
        let v1 = 0x1::vector::empty<DVNOptions>();
        while (0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::remaining_length(arg0) > 0) {
            let v2 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u8(arg0);
            let v3 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_fixed_len_bytes(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::rewind(arg0, 3), 3 + (0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u16(arg0) as u64));
            if (v2 == 1) {
                0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes(&mut v0, v3);
                continue
            };
            assert!(v2 == 2, 5);
            let v4 = &mut v1;
            append_dvn_option(v4, v3);
        };
        (0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v0), v1)
    }

    public fun get_matching_options(arg0: &vector<DVNOptions>, arg1: u8) : vector<u8> {
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<DVNOptions>(arg0)) {
            if (0x1::vector::borrow<DVNOptions>(arg0, v0).dvn_idx == arg1) {
                v1 = 0x1::option::some<u64>(v0);
                /* label 4 */
                return if (0x1::option::is_some<u64>(&v1)) {
                    0x1::vector::borrow<DVNOptions>(arg0, 0x1::option::destroy_some<u64>(v1)).options
                } else {
                    b""
                }
            };
            v0 = v0 + 1;
        };
        v1 = 0x1::option::none<u64>();
        /* goto 4 */
    }

    public fun split_worker_options(arg0: &vector<u8>) : (vector<u8>, vector<DVNOptions>) {
        assert!(0x1::vector::length<u8>(arg0) >= 2, 3);
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::create(*arg0);
        let v1 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u16(&mut v0);
        if (v1 == 3) {
            let v4 = &mut v0;
            extract_type_3_options(v4)
        } else {
            let v5 = &mut v0;
            (convert_legacy_options(v5, v1), 0x1::vector::empty<DVNOptions>())
        }
    }

    public fun unpack(arg0: DVNOptions) : (u8, vector<u8>) {
        (arg0.dvn_idx, arg0.options)
    }

    // decompiled from Move bytecode v6
}

