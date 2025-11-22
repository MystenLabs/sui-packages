module 0x85ec5610ec2ecc76921e2a9ee11e83e17ae1c2d42a630e9fd3cae9f99ac4a4f9::options_builder {
    struct OptionsBuilder has drop {
        options: vector<u8>,
    }

    public fun add_dvn_option(arg0: &mut OptionsBuilder, arg1: u8, arg2: u8, arg3: vector<u8>) : &mut OptionsBuilder {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::create(arg0.options);
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u8(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u8(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u16(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u8(&mut v0, 2), (0x1::vector::length<u8>(&arg3) as u16) + 2), arg1), arg2), arg3);
        arg0.options = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v0);
        arg0
    }

    public fun add_dvn_pre_crime_option(arg0: &mut OptionsBuilder, arg1: u8) : &mut OptionsBuilder {
        add_dvn_option(arg0, arg1, 1, b"");
        arg0
    }

    public fun add_executor_lz_compose_option(arg0: &mut OptionsBuilder, arg1: u16, arg2: u128, arg3: u128) : &mut OptionsBuilder {
        add_executor_option(arg0, 3, encode_lz_compose_option(arg1, arg2, arg3));
        arg0
    }

    public fun add_executor_lz_read_option(arg0: &mut OptionsBuilder, arg1: u128, arg2: u32, arg3: u128) : &mut OptionsBuilder {
        add_executor_option(arg0, 5, encode_lz_read_option(arg1, arg2, arg3));
        arg0
    }

    public fun add_executor_lz_receive_option(arg0: &mut OptionsBuilder, arg1: u128, arg2: u128) : &mut OptionsBuilder {
        add_executor_option(arg0, 1, encode_lz_receive_option(arg1, arg2));
        arg0
    }

    public fun add_executor_native_drop_option(arg0: &mut OptionsBuilder, arg1: u128, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32) : &mut OptionsBuilder {
        add_executor_option(arg0, 2, encode_native_drop_option(arg1, arg2));
        arg0
    }

    fun add_executor_option(arg0: &mut OptionsBuilder, arg1: u8, arg2: vector<u8>) {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::create(arg0.options);
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u8(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u16(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u8(&mut v0, 1), (0x1::vector::length<u8>(&arg2) as u16) + 1), arg1), arg2);
        arg0.options = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v0);
    }

    public fun add_executor_ordered_execution_option(arg0: &mut OptionsBuilder) : &mut OptionsBuilder {
        add_executor_option(arg0, 4, b"");
        arg0
    }

    public fun build(arg0: &OptionsBuilder) : vector<u8> {
        arg0.options
    }

    public fun encode_legacy_options_type1(arg0: u256) : vector<u8> {
        assert!(arg0 < 340282366920938463463374607431768211455, 1);
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::new();
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u256(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u16(&mut v0, 1), arg0);
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v0)
    }

    public fun encode_legacy_options_type2(arg0: u256, arg1: u256, arg2: vector<u8>) : vector<u8> {
        assert!(arg0 < 340282366920938463463374607431768211455, 1);
        assert!(arg1 < 340282366920938463463374607431768211455, 1);
        assert!(0x1::vector::length<u8>(&arg2) <= 32, 1);
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::new();
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u256(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u256(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u16(&mut v0, 2), arg0), arg1), arg2);
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v0)
    }

    public fun encode_lz_compose_option(arg0: u16, arg1: u128, arg2: u128) : vector<u8> {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::new();
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u128(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u16(&mut v0, arg0), arg1);
        if (arg2 > 0) {
            0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u128(&mut v0, arg2);
        };
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v0)
    }

    public fun encode_lz_read_option(arg0: u128, arg1: u32, arg2: u128) : vector<u8> {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::new();
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u32(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u128(&mut v0, arg0), arg1);
        if (arg2 > 0) {
            0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u128(&mut v0, arg2);
        };
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v0)
    }

    public fun encode_lz_receive_option(arg0: u128, arg1: u128) : vector<u8> {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::new();
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u128(&mut v0, arg0);
        if (arg1 > 0) {
            0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u128(&mut v0, arg1);
        };
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v0)
    }

    public fun encode_native_drop_option(arg0: u128, arg1: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32) : vector<u8> {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::new();
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes32(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u128(&mut v0, arg0), arg1);
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v0)
    }

    public fun new_builder() : OptionsBuilder {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::new();
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u16(&mut v0, 3);
        OptionsBuilder{options: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v0)}
    }

    public fun type_1() : u16 {
        1
    }

    public fun type_2() : u16 {
        2
    }

    public fun type_3() : u16 {
        3
    }

    // decompiled from Move bytecode v6
}

