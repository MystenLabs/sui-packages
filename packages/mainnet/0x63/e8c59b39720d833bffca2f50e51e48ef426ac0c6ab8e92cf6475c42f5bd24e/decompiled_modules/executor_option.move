module 0x63e8c59b39720d833bffca2f50e51e48ef426ac0c6ab8e92cf6475c42f5bd24e::executor_option {
    struct ExecutorOptionsAgg has copy, drop {
        total_value: u128,
        total_gas: u128,
        ordered: bool,
        num_lz_compose: u64,
    }

    struct LzReceiveOption has copy, drop {
        gas: u128,
        value: u128,
    }

    struct NativeDropOption has copy, drop {
        amount: u128,
        receiver: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
    }

    struct LzComposeOption has copy, drop {
        index: u16,
        gas: u128,
        value: u128,
    }

    public fun decode_lz_compose_option(arg0: vector<u8>) : LzComposeOption {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(v0 == 18 || v0 == 34, 8);
        let v1 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::create(arg0);
        let v2 = if (v0 == 34) {
            0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u128(&mut v1)
        } else {
            0
        };
        LzComposeOption{
            index : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u16(&mut v1),
            gas   : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u128(&mut v1),
            value : v2,
        }
    }

    public fun decode_lz_receive_option(arg0: vector<u8>) : LzReceiveOption {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(v0 == 16 || v0 == 32, 6);
        let v1 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::create(arg0);
        let v2 = if (v0 == 32) {
            0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u128(&mut v1)
        } else {
            0
        };
        LzReceiveOption{
            gas   : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u128(&mut v1),
            value : v2,
        }
    }

    public fun decode_native_drop_option(arg0: vector<u8>) : NativeDropOption {
        assert!(0x1::vector::length<u8>(&arg0) == 48, 7);
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::create(arg0);
        NativeDropOption{
            amount   : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u128(&mut v0),
            receiver : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_bytes32(&mut v0),
        }
    }

    public fun is_ordered(arg0: &ExecutorOptionsAgg) : bool {
        arg0.ordered
    }

    public fun next_executor_option(arg0: &mut 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::Reader) : (u8, vector<u8>) {
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::skip(arg0, 1);
        (0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u8(arg0), 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_fixed_len_bytes(arg0, ((0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u16(arg0) - 1) as u64)))
    }

    public fun num_lz_compose(arg0: &ExecutorOptionsAgg) : u64 {
        arg0.num_lz_compose
    }

    public fun ordered(arg0: &ExecutorOptionsAgg) : bool {
        arg0.ordered
    }

    public fun parse_executor_options(arg0: vector<u8>, arg1: bool, arg2: u128) : ExecutorOptionsAgg {
        assert!(!0x1::vector::is_empty<u8>(&arg0), 1);
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::create(arg0);
        let v1 = ExecutorOptionsAgg{
            total_value    : 0,
            total_gas      : 0,
            ordered        : false,
            num_lz_compose : 0,
        };
        let v2 = 0;
        while (0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::remaining_length(&v0) > 0) {
            let v3 = &mut v0;
            let (v4, v5) = next_executor_option(v3);
            if (v4 == 1) {
                let v6 = decode_lz_receive_option(v5);
                let v7 = arg1 && v6.value > 0;
                assert!(!v7, 2);
                v1.total_value = v1.total_value + v6.value;
                v2 = v2 + v6.gas;
                continue
            };
            if (v4 == 2) {
                let v8 = decode_native_drop_option(v5);
                v1.total_value = v1.total_value + v8.amount;
                continue
            };
            if (v4 == 3) {
                assert!(!arg1, 2);
                let v9 = decode_lz_compose_option(v5);
                assert!(v9.gas != 0, 4);
                v1.total_value = v1.total_value + v9.value;
                v1.total_gas = v1.total_gas + v9.gas;
                v1.num_lz_compose = v1.num_lz_compose + 1;
                continue
            };
            assert!(v4 == 4, 2);
            v1.ordered = true;
        };
        assert!(v1.total_value <= arg2, 5);
        assert!(v2 != 0, 3);
        v1.total_gas = v1.total_gas + v2;
        v1
    }

    public fun total_gas(arg0: &ExecutorOptionsAgg) : u128 {
        arg0.total_gas
    }

    public fun total_value(arg0: &ExecutorOptionsAgg) : u128 {
        arg0.total_value
    }

    // decompiled from Move bytecode v6
}

