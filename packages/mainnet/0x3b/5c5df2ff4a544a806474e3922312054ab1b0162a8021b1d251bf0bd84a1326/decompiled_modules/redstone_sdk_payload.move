module 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_payload {
    struct Payload has copy, drop {
        data_packages: vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>,
    }

    struct ParsedPayload has copy, drop {
        aggregated_value: u256,
        new_package_timestamp: u64,
    }

    public fun data_packages(arg0: &Payload) : vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage> {
        arg0.data_packages
    }

    fun data_points_contains_feed_id(arg0: &vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint>(arg0)) {
            if (0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::feed_id(0x1::vector::borrow<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint>(arg0, v0)) == arg1) {
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
        let v0 = 0x1::vector::empty<vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint>>();
        let v1 = data_packages(arg0);
        0x1::vector::reverse<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(&v1)) {
            let v3 = 0x1::vector::pop_back<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(&mut v1);
            0x1::vector::push_back<vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint>>(&mut v0, *0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::data_points(&v3));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(v1);
        let v4 = 0x1::vector::empty<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint>();
        let v5 = 0x1::vector::flatten<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint>(v0);
        0x1::vector::reverse<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint>(&mut v5);
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint>(&v5)) {
            let v7 = 0x1::vector::pop_back<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint>(&mut v5);
            if (0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::feed_id(&v7) == arg1) {
                0x1::vector::push_back<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint>(&mut v4, v7);
            };
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint>(v5);
        let v8 = vector[];
        0x1::vector::reverse<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint>(&mut v4);
        let v9 = 0;
        while (v9 < 0x1::vector::length<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint>(&v4)) {
            let v10 = 0x1::vector::pop_back<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint>(&mut v4);
            0x1::vector::push_back<vector<u8>>(&mut v8, *0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::value(&v10));
            v9 = v9 + 1;
        };
        0x1::vector::destroy_empty<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint>(v4);
        v8
    }

    fun filter_out_zero_values(arg0: vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>) : vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage> {
        let v0 = 0x1::vector::empty<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>();
        0x1::vector::reverse<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(&arg0)) {
            let v2 = filter_zero_from_data_points(0x1::vector::pop_back<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(&mut arg0));
            if (0x1::vector::length<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint>(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::data_points(&v2)) > 0) {
                0x1::vector::push_back<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(arg0);
        v0
    }

    fun filter_packages_by_feed_id(arg0: &vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>, arg1: &vector<u8>) : vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage> {
        let v0 = 0x1::vector::empty<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(arg0)) {
            let v2 = 0x1::vector::borrow<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(arg0, v1);
            if (data_points_contains_feed_id(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::data_points(v2), arg1)) {
                0x1::vector::push_back<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(&mut v0, *v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun filter_zero_from_data_points(arg0: 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage) : 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage {
        let v0 = 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::data_points(&arg0);
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint>(v0)) {
            if (is_zero_vec(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::value(0x1::vector::borrow<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint>(v0, v1)))) {
                v2 = true;
                /* label 6 */
                return if (!v2) {
                    arg0
                } else {
                    let v4 = 0x1::vector::empty<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint>();
                    let v5 = 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::data_points(&arg0);
                    let v6 = 0;
                    while (v6 < 0x1::vector::length<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint>(v5)) {
                        let v7 = 0x1::vector::borrow<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint>(v5, v6);
                        if (!is_zero_vec(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::value(v7))) {
                            0x1::vector::push_back<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint>(&mut v4, *v7);
                        };
                        v6 = v6 + 1;
                    };
                    0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::new_data_package(*0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::signer_address(&arg0), 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::timestamp(&arg0), v4)
                }
            };
            v1 = v1 + 1;
        };
        v2 = false;
        /* goto 6 */
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

    fun parse_raw_payload(arg0: vector<u8>) : 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::Result<Payload> {
        let v0 = 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_validate::try_verify_redstone_marker(&arg0);
        if (!0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::is_ok<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(&v0)) {
            return 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::error<Payload>(0x1::string::into_bytes(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap_err<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(v0)))
        };
        let v1 = &mut arg0;
        trim_redstone_marker(v1);
        let v2 = &mut arg0;
        trim_payload(v2)
    }

    public fun process_payload(arg0: &0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_config::Config, arg1: u64, arg2: vector<u8>, arg3: vector<u8>) : (u256, u64) {
        abort 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::constants::deprecated_code()
    }

    fun trim_data_package(arg0: &mut vector<u8>) : 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::Result<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage> {
        let v0 = trim_end(arg0, 65);
        let v1 = *arg0;
        let v2 = trim_data_point_count(arg0);
        let v3 = trim_data_point_value_size(arg0);
        let v4 = trim_timestamp(arg0);
        let v5 = &mut v1;
        let v6 = trim_end(v5, v2 * (v3 + 32) + 4 + 6 + 3);
        let v7 = 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_crypto::try_recover_address(&v6, &v0);
        if (0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::is_ok<vector<u8>>(&v7)) {
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::ok<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::new_data_package(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap<vector<u8>>(v7), v4, trim_data_points(arg0, v2, v3)))
        } else {
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::error<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(0x1::string::into_bytes(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap_err<vector<u8>>(v7)))
        }
    }

    fun trim_data_packages(arg0: &mut vector<u8>, arg1: u64) : 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::Result<vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>> {
        let v0 = 0x1::vector::empty<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>();
        let v1 = 0;
        while (v1 < arg1) {
            let v2 = trim_data_package(arg0);
            if (!0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::is_ok<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(&v2)) {
                return 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::error<vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>>(0x1::string::into_bytes(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap_err<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(v2)))
            };
            0x1::vector::push_back<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(&mut v0, 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(v2));
            v1 = v1 + 1;
        };
        0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::ok<vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>>(v0)
    }

    fun trim_data_point(arg0: &mut vector<u8>, arg1: u64) : 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint {
        let v0 = trim_end(arg0, arg1);
        0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::new_data_point(trim_end(arg0, 32), v0)
    }

    fun trim_data_point_count(arg0: &mut vector<u8>) : u64 {
        let v0 = trim_end(arg0, 3);
        0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_conv::from_bytes_to_u64(&v0)
    }

    fun trim_data_point_value_size(arg0: &mut vector<u8>) : u64 {
        let v0 = trim_end(arg0, 4);
        0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_conv::from_bytes_to_u64(&v0)
    }

    fun trim_data_points(arg0: &mut vector<u8>, arg1: u64, arg2: u64) : vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint> {
        let v0 = 0x1::vector::empty<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint>();
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPoint>(&mut v0, trim_data_point(arg0, arg2));
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
        trim_end(arg0, 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_conv::from_bytes_to_u64(&v0));
        let v1 = trim_end(arg0, 2);
        0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_conv::from_bytes_to_u64(&v1)
    }

    fun trim_payload(arg0: &mut vector<u8>) : 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::Result<Payload> {
        let v0 = trim_metadata(arg0);
        let v1 = trim_data_packages(arg0, v0);
        if (!0x1::vector::is_empty<u8>(arg0)) {
            return 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::error<Payload>(b"Data inconsistent, leftover bytes after parsing")
        };
        if (0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::is_ok<vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>>(&v1)) {
            let v3 = Payload{data_packages: 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap<vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>>(v1)};
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::ok<Payload>(v3)
        } else {
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::error<Payload>(0x1::string::into_bytes(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap_err<vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>>(v1)))
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
        0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_conv::from_bytes_to_u64(&v0)
    }

    public fun try_process_payload(arg0: &0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_config::Config, arg1: u64, arg2: vector<u8>, arg3: vector<u8>) : 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::Result<ParsedPayload> {
        let v0 = parse_raw_payload(arg3);
        let v1 = if (0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::is_ok<Payload>(&v0)) {
            let v2 = data_packages(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::borrow<Payload>(&v0));
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::ok<vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>>(filter_packages_by_feed_id(&v2, &arg2))
        } else {
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::error<vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>>(0x1::string::into_bytes(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap_err<Payload>(v0)))
        };
        let v3 = v1;
        let v4 = if (0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::is_ok<vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>>(&v3)) {
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::ok<vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>>(filter_out_zero_values(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap<vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>>(v3)))
        } else {
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::error<vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>>(0x1::string::into_bytes(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap_err<vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>>(v3)))
        };
        let v5 = v4;
        let v6 = if (0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::is_ok<vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>>(&v5)) {
            let v7 = 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap<vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>>(v5);
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_validate::try_verify_data_packages(&v7, arg0, arg1)
        } else {
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::error<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(0x1::string::into_bytes(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap_err<vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>>(v5)))
        };
        let v8 = v6;
        if (!0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::is_ok<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(&v8)) {
            return 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::error<ParsedPayload>(0x1::string::into_bytes(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap_err<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(v8)))
        };
        let v9 = if (0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::is_ok<Payload>(&v0)) {
            let v10 = 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap<Payload>(v0);
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::ok<vector<vector<u8>>>(extract_values_by_feed_id(&v10, &arg2))
        } else {
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::error<vector<vector<u8>>>(0x1::string::into_bytes(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap_err<Payload>(v0)))
        };
        let v11 = v9;
        let v12 = if (0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::is_ok<vector<vector<u8>>>(&v11)) {
            let v13 = vector[];
            let v14 = 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap<vector<vector<u8>>>(v11);
            0x1::vector::reverse<vector<u8>>(&mut v14);
            let v15 = 0;
            while (v15 < 0x1::vector::length<vector<u8>>(&v14)) {
                let v16 = 0x1::vector::pop_back<vector<u8>>(&mut v14);
                0x1::vector::push_back<u256>(&mut v13, 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_conv::from_bytes_to_u256(&v16));
                v15 = v15 + 1;
            };
            0x1::vector::destroy_empty<vector<u8>>(v14);
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_median::try_calculate_median(&mut v13)
        } else {
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::error<u256>(0x1::string::into_bytes(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap_err<vector<vector<u8>>>(v11)))
        };
        let v17 = v12;
        let v18 = v4;
        if (0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::is_ok<u256>(&v17) && 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::is_ok<vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>>(&v18)) {
            let v20 = 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap<vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>>(v18);
            let v21 = ParsedPayload{
                aggregated_value      : 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap<u256>(v17),
                new_package_timestamp : 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::timestamp(0x1::vector::borrow<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(&v20, 0)),
            };
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::ok<ParsedPayload>(v21)
        } else if (!0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::is_ok<u256>(&v17)) {
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::error<ParsedPayload>(0x1::string::into_bytes(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap_err<u256>(v17)))
        } else {
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::error<ParsedPayload>(0x1::string::into_bytes(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap_err<vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>>(v18)))
        }
    }

    // decompiled from Move bytecode v6
}

