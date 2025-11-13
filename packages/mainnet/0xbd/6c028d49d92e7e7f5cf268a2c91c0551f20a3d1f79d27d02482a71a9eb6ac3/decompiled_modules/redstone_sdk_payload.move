module 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_payload {
    struct Payload has copy, drop {
        data_packages: vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>,
    }

    struct ParsedPayload has copy, drop {
        aggregated_value: u256,
        new_package_timestamp: u64,
    }

    fun contains_zero_value_point(arg0: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage) : bool {
        let v0 = 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::data_points(arg0);
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPoint>(v0)) {
            if (is_zero_vec(0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::value(0x1::vector::borrow<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPoint>(v0, v1)))) {
                v2 = true;
                return v2
            };
            v1 = v1 + 1;
        };
        v2 = false;
        v2
    }

    public fun data_packages(arg0: &Payload) : vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage> {
        arg0.data_packages
    }

    fun data_points_contains_feed_id(arg0: &vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPoint>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPoint>(arg0)) {
            if (0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::feed_id(0x1::vector::borrow<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPoint>(arg0, v0)) == arg1) {
                v1 = true;
                return v1
            };
            v0 = v0 + 1;
        };
        v1 = false;
        v1
    }

    public fun destroy_processed_payload(arg0: ParsedPayload) : (u256, u64) {
        (arg0.aggregated_value, arg0.new_package_timestamp)
    }

    public fun extract_values_by_feed_id(arg0: &Payload, arg1: &vector<u8>) : vector<vector<u8>> {
        abort 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::constants::deprecated_code()
    }

    fun extract_values_by_feed_id_from_packages(arg0: vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>, arg1: &vector<u8>) : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPoint>>();
        0x1::vector::reverse<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>(&arg0)) {
            let v2 = 0x1::vector::pop_back<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>(&mut arg0);
            0x1::vector::push_back<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPoint>>(&mut v0, *0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::data_points(&v2));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>(arg0);
        let v3 = 0x1::vector::empty<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPoint>();
        let v4 = 0x1::vector::flatten<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPoint>(v0);
        0x1::vector::reverse<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPoint>(&mut v4);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPoint>(&v4)) {
            let v6 = 0x1::vector::pop_back<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPoint>(&mut v4);
            if (0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::feed_id(&v6) == arg1) {
                0x1::vector::push_back<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPoint>(&mut v3, v6);
            };
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPoint>(v4);
        let v7 = vector[];
        0x1::vector::reverse<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPoint>(&mut v3);
        let v8 = 0;
        while (v8 < 0x1::vector::length<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPoint>(&v3)) {
            let v9 = 0x1::vector::pop_back<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPoint>(&mut v3);
            0x1::vector::push_back<vector<u8>>(&mut v7, *0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::value(&v9));
            v8 = v8 + 1;
        };
        0x1::vector::destroy_empty<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPoint>(v3);
        v7
    }

    fun filter_out_data_packages_with_zero_values(arg0: vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>) : vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage> {
        let v0 = 0x1::vector::empty<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>();
        0x1::vector::reverse<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>(&arg0)) {
            let v2 = 0x1::vector::pop_back<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>(&mut arg0);
            if (!contains_zero_value_point(&v2)) {
                0x1::vector::push_back<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>(arg0);
        v0
    }

    fun filter_packages_by_feed_id(arg0: &vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>, arg1: &vector<u8>) : vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage> {
        let v0 = 0x1::vector::empty<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>(arg0)) {
            let v2 = 0x1::vector::borrow<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>(arg0, v1);
            if (data_points_contains_feed_id(0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::data_points(v2), arg1)) {
                0x1::vector::push_back<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>(&mut v0, *v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun is_zero_vec(arg0: &vector<u8>) : bool {
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v2 = 0;
            if (!(0x1::vector::borrow<u8>(arg0, v0) == &v2)) {
                v1 = false;
                return v1
            };
            v0 = v0 + 1;
        };
        v1 = true;
        v1
    }

    fun parse_raw_payload(arg0: vector<u8>) : 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::Result<Payload> {
        let v0 = 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_validate::try_verify_redstone_marker(&arg0);
        if (!0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::is_ok<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::unit::Unit>(&v0)) {
            return 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::error<Payload>(0x1::string::into_bytes(0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::unwrap_err<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::unit::Unit>(v0)))
        };
        let v1 = &mut arg0;
        trim_redstone_marker(v1);
        let v2 = &mut arg0;
        trim_payload(v2)
    }

    public fun process_payload(arg0: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_config::Config, arg1: u64, arg2: vector<u8>, arg3: vector<u8>) : (u256, u64) {
        abort 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::constants::deprecated_code()
    }

    fun trim_data_package(arg0: &mut vector<u8>) : 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::Result<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage> {
        let v0 = trim_end(arg0, 65);
        let v1 = *arg0;
        let v2 = trim_data_point_count(arg0);
        let v3 = trim_data_point_value_size(arg0);
        let v4 = trim_timestamp(arg0);
        let v5 = &mut v1;
        let v6 = trim_end(v5, v2 * (v3 + 32) + 4 + 6 + 3);
        let v7 = 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_crypto::try_recover_address(&v6, &v0);
        if (0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::is_ok<vector<u8>>(&v7)) {
            0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::ok<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>(0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::new_data_package(0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::unwrap<vector<u8>>(v7), v4, trim_data_points(arg0, v2, v3)))
        } else {
            0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::error<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>(0x1::string::into_bytes(0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::unwrap_err<vector<u8>>(v7)))
        }
    }

    fun trim_data_packages(arg0: &mut vector<u8>, arg1: u64) : 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::Result<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>> {
        let v0 = 0x1::vector::empty<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>();
        let v1 = 0;
        while (v1 < arg1) {
            let v2 = trim_data_package(arg0);
            if (!0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::is_ok<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>(&v2)) {
                return 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::error<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>>(0x1::string::into_bytes(0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::unwrap_err<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>(v2)))
            };
            0x1::vector::push_back<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>(&mut v0, 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::unwrap<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>(v2));
            v1 = v1 + 1;
        };
        0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::ok<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>>(v0)
    }

    fun trim_data_point(arg0: &mut vector<u8>, arg1: u64) : 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPoint {
        let v0 = trim_end(arg0, arg1);
        0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::new_data_point(trim_end(arg0, 32), v0)
    }

    fun trim_data_point_count(arg0: &mut vector<u8>) : u64 {
        let v0 = trim_end(arg0, 3);
        0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_conv::from_bytes_to_u64(&v0)
    }

    fun trim_data_point_value_size(arg0: &mut vector<u8>) : u64 {
        let v0 = trim_end(arg0, 4);
        0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_conv::from_bytes_to_u64(&v0)
    }

    fun trim_data_points(arg0: &mut vector<u8>, arg1: u64, arg2: u64) : vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPoint> {
        let v0 = 0x1::vector::empty<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPoint>();
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPoint>(&mut v0, trim_data_point(arg0, arg2));
            v1 = v1 + 1;
        };
        v0
    }

    fun trim_end(arg0: &mut vector<u8>, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (arg1 >= v0) {
            *arg0 = 0x1::vector::empty<u8>();
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
        trim_end(arg0, 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_conv::from_bytes_to_u64(&v0));
        let v1 = trim_end(arg0, 2);
        0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_conv::from_bytes_to_u64(&v1)
    }

    fun trim_payload(arg0: &mut vector<u8>) : 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::Result<Payload> {
        let v0 = trim_metadata(arg0);
        let v1 = trim_data_packages(arg0, v0);
        if (!0x1::vector::is_empty<u8>(arg0)) {
            return 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::error<Payload>(b"Data inconsistent, leftover bytes after parsing")
        };
        if (0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::is_ok<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>>(&v1)) {
            let v3 = Payload{data_packages: 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::unwrap<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>>(v1)};
            0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::ok<Payload>(v3)
        } else {
            0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::error<Payload>(0x1::string::into_bytes(0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::unwrap_err<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>>(v1)))
        }
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
        0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_conv::from_bytes_to_u64(&v0)
    }

    public fun try_process_payload(arg0: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_config::Config, arg1: u64, arg2: vector<u8>, arg3: vector<u8>) : 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::Result<ParsedPayload> {
        let v0 = parse_raw_payload(arg3);
        let v1 = if (0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::is_ok<Payload>(&v0)) {
            let v2 = data_packages(0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::borrow<Payload>(&v0));
            0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::ok<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>>(filter_packages_by_feed_id(&v2, &arg2))
        } else {
            0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::error<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>>(0x1::string::into_bytes(0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::unwrap_err<Payload>(v0)))
        };
        let v3 = v1;
        let v4 = if (0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::is_ok<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>>(&v3)) {
            let v5 = 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::unwrap<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>>(v3);
            0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_validate::try_verify_feeds_in_data_packages(&v5)
        } else {
            0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::error<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::unit::Unit>(0x1::string::into_bytes(0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::unwrap_err<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>>(v3)))
        };
        let v6 = v4;
        if (!0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::is_ok<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::unit::Unit>(&v6)) {
            return 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::error<ParsedPayload>(0x1::string::into_bytes(0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::unwrap_err<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::unit::Unit>(v6)))
        };
        let v7 = v1;
        let v8 = if (0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::is_ok<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>>(&v7)) {
            0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::ok<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>>(filter_out_data_packages_with_zero_values(0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::unwrap<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>>(v7)))
        } else {
            0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::error<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>>(0x1::string::into_bytes(0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::unwrap_err<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>>(v7)))
        };
        let v9 = v8;
        let v10 = if (0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::is_ok<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>>(&v9)) {
            let v11 = 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::unwrap<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>>(v9);
            0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_validate::try_verify_data_packages(&v11, arg0, arg1)
        } else {
            0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::error<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::unit::Unit>(0x1::string::into_bytes(0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::unwrap_err<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>>(v9)))
        };
        let v12 = v10;
        if (!0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::is_ok<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::unit::Unit>(&v12)) {
            return 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::error<ParsedPayload>(0x1::string::into_bytes(0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::unwrap_err<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::unit::Unit>(v12)))
        };
        let v13 = v8;
        let v14 = if (0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::is_ok<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>>(&v13)) {
            0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::ok<vector<vector<u8>>>(extract_values_by_feed_id_from_packages(0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::unwrap<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>>(v13), &arg2))
        } else {
            0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::error<vector<vector<u8>>>(0x1::string::into_bytes(0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::unwrap_err<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>>(v13)))
        };
        let v15 = v14;
        let v16 = if (0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::is_ok<vector<vector<u8>>>(&v15)) {
            let v17 = vector[];
            let v18 = 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::unwrap<vector<vector<u8>>>(v15);
            0x1::vector::reverse<vector<u8>>(&mut v18);
            let v19 = 0;
            while (v19 < 0x1::vector::length<vector<u8>>(&v18)) {
                let v20 = 0x1::vector::pop_back<vector<u8>>(&mut v18);
                0x1::vector::push_back<u256>(&mut v17, 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_conv::from_bytes_to_u256(&v20));
                v19 = v19 + 1;
            };
            0x1::vector::destroy_empty<vector<u8>>(v18);
            0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_median::try_calculate_median(&mut v17)
        } else {
            0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::error<u256>(0x1::string::into_bytes(0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::unwrap_err<vector<vector<u8>>>(v15)))
        };
        let v21 = v16;
        let v22 = v8;
        if (0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::is_ok<u256>(&v21) && 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::is_ok<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>>(&v22)) {
            let v24 = 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::unwrap<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>>(v22);
            let v25 = ParsedPayload{
                aggregated_value      : 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::unwrap<u256>(v21),
                new_package_timestamp : 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::timestamp(0x1::vector::borrow<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>(&v24, 0)),
            };
            0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::ok<ParsedPayload>(v25)
        } else if (!0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::is_ok<u256>(&v21)) {
            0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::error<ParsedPayload>(0x1::string::into_bytes(0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::unwrap_err<u256>(v21)))
        } else {
            0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::error<ParsedPayload>(0x1::string::into_bytes(0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::unwrap_err<vector<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_data_package::DataPackage>>(v22)))
        }
    }

    // decompiled from Move bytecode v6
}

