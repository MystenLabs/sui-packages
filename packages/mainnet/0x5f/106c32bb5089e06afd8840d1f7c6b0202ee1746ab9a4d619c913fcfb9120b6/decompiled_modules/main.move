module 0x5f106c32bb5089e06afd8840d1f7c6b0202ee1746ab9a4d619c913fcfb9120b6::main {
    struct PriceData has store {
        feed_id: vector<u8>,
        value: u256,
        timestamp: u64,
    }

    struct Config has copy, drop, store {
        owner: address,
        signer_count_threshold: u8,
        signers: vector<vector<u8>>,
        max_timestamp_delay_ms: u64,
        max_timestamp_ahead_ms: u64,
    }

    struct PriceOracle has key {
        id: 0x2::object::UID,
        prices: 0x2::table::Table<vector<u8>, PriceData>,
        config: Config,
    }

    struct DataPoint has copy, drop {
        feed_id: vector<u8>,
        value: vector<u8>,
    }

    struct DataPackage has copy, drop {
        signer_address: vector<u8>,
        timestamp: u64,
        data_points: vector<DataPoint>,
    }

    struct Payload has copy, drop {
        data_packages: vector<DataPackage>,
    }

    fun extract_values(arg0: &Payload, arg1: &vector<u8>) : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<DataPackage>(&arg0.data_packages)) {
            let v2 = 0x1::vector::borrow<DataPackage>(&arg0.data_packages, v1);
            let v3 = 0;
            while (v3 < 0x1::vector::length<DataPoint>(&v2.data_points)) {
                let v4 = 0x1::vector::borrow<DataPoint>(&v2.data_points, v3);
                if (&v4.feed_id == arg1) {
                    0x1::vector::push_back<vector<u8>>(&mut v0, v4.value);
                };
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_price(arg0: &PriceOracle, arg1: vector<u8>) : u256 {
        if (!0x2::table::contains<vector<u8>, PriceData>(&arg0.prices, arg1)) {
            abort 7
        };
        0x2::table::borrow<vector<u8>, PriceData>(&arg0.prices, arg1).value
    }

    public fun initialize(arg0: vector<vector<u8>>, arg1: u8, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            owner                  : 0x2::tx_context::sender(arg4),
            signer_count_threshold : arg1,
            signers                : arg0,
            max_timestamp_delay_ms : arg2,
            max_timestamp_ahead_ms : arg3,
        };
        let v1 = PriceOracle{
            id     : 0x2::object::new(arg4),
            prices : 0x2::table::new<vector<u8>, PriceData>(arg4),
            config : v0,
        };
        0x2::transfer::share_object<PriceOracle>(v1);
    }

    fun parse_data_point(arg0: &mut vector<u8>, arg1: u64) : DataPoint {
        let v0 = trim_end(arg0, arg1);
        DataPoint{
            feed_id : trim_end(arg0, 32),
            value   : v0,
        }
    }

    fun parse_data_points(arg0: &mut vector<u8>, arg1: u64, arg2: u64) : vector<DataPoint> {
        let v0 = 0x1::vector::empty<DataPoint>();
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<DataPoint>(&mut v0, parse_data_point(arg0, arg2));
            v1 = v1 + 1;
        };
        v0
    }

    fun parse_raw_payload(arg0: vector<u8>) : Payload {
        let v0 = &mut arg0;
        trim_redstone_marker(v0);
        let v1 = &mut arg0;
        trim_payload(v1)
    }

    public fun process_redstone_payload(arg0: &mut PriceOracle, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        assert!(arg0.config.owner != @0x0, 8);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        verify_redstone_marker(&arg2);
        let v1 = parse_raw_payload(arg2);
        verify_data_packages(&v1, &arg0.config, v0);
        let v2 = vector[];
        let v3 = extract_values(&v1, &arg1);
        0x1::vector::reverse<vector<u8>>(&mut v3);
        while (!0x1::vector::is_empty<vector<u8>>(&v3)) {
            let v4 = 0x1::vector::pop_back<vector<u8>>(&mut v3);
            0x1::vector::push_back<u256>(&mut v2, 0x5f106c32bb5089e06afd8840d1f7c6b0202ee1746ab9a4d619c913fcfb9120b6::conv::from_bytes_to_u256(&v4));
        };
        0x1::vector::destroy_empty<vector<u8>>(v3);
        if (!0x2::table::contains<vector<u8>, PriceData>(&arg0.prices, arg1)) {
            let v5 = PriceData{
                feed_id   : arg1,
                value     : 0,
                timestamp : 0,
            };
            0x2::table::add<vector<u8>, PriceData>(&mut arg0.prices, arg1, v5);
        };
        let v6 = 0x2::table::borrow_mut<vector<u8>, PriceData>(&mut arg0.prices, arg1);
        v6.value = 0x5f106c32bb5089e06afd8840d1f7c6b0202ee1746ab9a4d619c913fcfb9120b6::median::calculate_median(&mut v2);
        v6.timestamp = v0;
    }

    public fun recover_address(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(arg1) == 65, 5);
        let v0 = *arg1;
        let v1 = *0x1::vector::borrow<u8>(&v0, 64);
        let v2 = if (v1 >= 27) {
            v1 - 27
        } else {
            v1
        };
        assert!(v2 < 4, 6);
        *0x1::vector::borrow_mut<u8>(&mut v0, 64) = v2;
        let v3 = 0x2::ecdsa_k1::secp256k1_ecrecover(&v0, arg0, 0);
        let v4 = 0x2::ecdsa_k1::decompress_pubkey(&v3);
        let v5 = 0x1::vector::empty<u8>();
        let v6 = 1;
        while (v6 < 0x1::vector::length<u8>(&v4)) {
            0x1::vector::push_back<u8>(&mut v5, *0x1::vector::borrow<u8>(&v4, v6));
            v6 = v6 + 1;
        };
        let v7 = 0x2::hash::keccak256(&v5);
        let v8 = 0x1::vector::empty<u8>();
        let v9 = 0x1::vector::length<u8>(&v7);
        let v10 = v9 - 20;
        while (v10 < v9) {
            0x1::vector::push_back<u8>(&mut v8, *0x1::vector::borrow<u8>(&v7, v10));
            v10 = v10 + 1;
        };
        v8
    }

    fun trim_data_package(arg0: &mut vector<u8>) : DataPackage {
        let v0 = trim_end(arg0, 65);
        let v1 = *arg0;
        let v2 = trim_data_point_count(arg0);
        let v3 = trim_data_point_value_size(arg0);
        let v4 = trim_timestamp(arg0);
        let v5 = &mut v1;
        let v6 = trim_end(v5, v2 * (v3 + 32) + 4 + 6 + 3);
        DataPackage{
            signer_address : recover_address(&v6, &v0),
            timestamp      : v4,
            data_points    : parse_data_points(arg0, v2, v3),
        }
    }

    fun trim_data_packages(arg0: &mut vector<u8>, arg1: u64) : vector<DataPackage> {
        let v0 = 0x1::vector::empty<DataPackage>();
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<DataPackage>(&mut v0, trim_data_package(arg0));
            v1 = v1 + 1;
        };
        v0
    }

    fun trim_data_point_count(arg0: &mut vector<u8>) : u64 {
        let v0 = trim_end(arg0, 3);
        0x5f106c32bb5089e06afd8840d1f7c6b0202ee1746ab9a4d619c913fcfb9120b6::conv::from_bytes_to_u64(&v0)
    }

    fun trim_data_point_value_size(arg0: &mut vector<u8>) : u64 {
        let v0 = trim_end(arg0, 4);
        0x5f106c32bb5089e06afd8840d1f7c6b0202ee1746ab9a4d619c913fcfb9120b6::conv::from_bytes_to_u64(&v0)
    }

    fun trim_end(arg0: &mut vector<u8>, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (arg1 >= v0) {
            *arg0
        } else {
            let v2 = 0x1::vector::empty<u8>();
            while (0x1::vector::length<u8>(arg0) > v0 - arg1) {
                0x1::vector::push_back<u8>(&mut v2, 0x1::vector::pop_back<u8>(arg0));
            };
            0x1::vector::reverse<u8>(&mut v2);
            v2
        }
    }

    fun trim_metadata(arg0: &mut vector<u8>) : u64 {
        let v0 = trim_end(arg0, 3);
        trim_end(arg0, 0x5f106c32bb5089e06afd8840d1f7c6b0202ee1746ab9a4d619c913fcfb9120b6::conv::from_bytes_to_u64(&v0));
        let v1 = trim_end(arg0, 2);
        0x5f106c32bb5089e06afd8840d1f7c6b0202ee1746ab9a4d619c913fcfb9120b6::conv::from_bytes_to_u64(&v1)
    }

    fun trim_payload(arg0: &mut vector<u8>) : Payload {
        let v0 = trim_metadata(arg0);
        Payload{data_packages: trim_data_packages(arg0, v0)}
    }

    fun trim_redstone_marker(arg0: &mut vector<u8>) {
        let v0 = 0;
        while (v0 < 9) {
            0x1::vector::pop_back<u8>(arg0);
            v0 = v0 + 1;
        };
    }

    fun trim_timestamp(arg0: &mut vector<u8>) : u64 {
        let v0 = trim_end(arg0, 6);
        0x5f106c32bb5089e06afd8840d1f7c6b0202ee1746ab9a4d619c913fcfb9120b6::conv::from_bytes_to_u64(&v0)
    }

    public fun update_config(arg0: &mut PriceOracle, arg1: 0x1::option::Option<vector<vector<u8>>>, arg2: 0x1::option::Option<u8>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.config.owner, 0);
        if (0x1::option::is_some<vector<vector<u8>>>(&arg1)) {
            arg0.config.signers = 0x1::option::extract<vector<vector<u8>>>(&mut arg1);
        };
        if (0x1::option::is_some<u8>(&arg2)) {
            arg0.config.signer_count_threshold = 0x1::option::extract<u8>(&mut arg2);
        };
        if (0x1::option::is_some<u64>(&arg3)) {
            arg0.config.max_timestamp_delay_ms = 0x1::option::extract<u64>(&mut arg3);
        };
        if (0x1::option::is_some<u64>(&arg4)) {
            arg0.config.max_timestamp_ahead_ms = 0x1::option::extract<u64>(&mut arg4);
        };
    }

    fun verify_data_packages(arg0: &Payload, arg1: &Config, arg2: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<DataPackage>(&arg0.data_packages)) {
            verify_timestamp(0x1::vector::borrow<DataPackage>(&arg0.data_packages, v0).timestamp, arg1, arg2);
            v0 = v0 + 1;
        };
        verify_signer_count(&arg0.data_packages, arg1.signer_count_threshold, &arg1.signers);
    }

    fun verify_redstone_marker(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) >= 9, 1);
        let v0 = x"000002ed57011e0000";
        let v1 = 0x1::vector::length<u8>(arg0) - 9;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            assert!(*0x1::vector::borrow<u8>(arg0, v1) == *0x1::vector::borrow<u8>(&v0, v1 - 0x1::vector::length<u8>(arg0) - 9), 1);
            v1 = v1 + 1;
        };
    }

    fun verify_signer_count(arg0: &vector<DataPackage>, arg1: u8, arg2: &vector<vector<u8>>) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<DataPackage>(arg0)) {
            if (0x1::vector::contains<vector<u8>>(arg2, &0x1::vector::borrow<DataPackage>(arg0, v1).signer_address)) {
                v0 = v0 + 1;
            };
            if (v0 >= arg1) {
                return
            };
            v1 = v1 + 1;
        };
        abort 4
    }

    fun verify_timestamp(arg0: u64, arg1: &Config, arg2: u64) {
        assert!(arg0 + arg1.max_timestamp_delay_ms >= arg2, 2);
        assert!(arg0 <= arg2 + arg1.max_timestamp_ahead_ms, 3);
    }

    // decompiled from Move bytecode v6
}

