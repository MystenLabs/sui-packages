module 0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_payload {
    struct Payload has copy, drop {
        data_packages: vector<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPackage>,
    }

    public fun data_packages(arg0: &Payload) : vector<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPackage> {
        arg0.data_packages
    }

    fun data_points_contains_feed_id(arg0: &vector<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPoint>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPoint>(arg0)) {
            if (0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::feed_id(0x1::vector::borrow<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPoint>(arg0, v0)) == arg1) {
                v1 = true;
                return v1
            };
            v0 = v0 + 1;
        };
        v1 = false;
        v1
    }

    public fun extract_values_by_feed_id(arg0: &Payload, arg1: &vector<u8>) : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPoint>>();
        let v1 = data_packages(arg0);
        0x1::vector::reverse<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPackage>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPackage>(&v1)) {
            let v3 = 0x1::vector::pop_back<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPackage>(&mut v1);
            0x1::vector::push_back<vector<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPoint>>(&mut v0, *0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::data_points(&v3));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPackage>(v1);
        let v4 = 0x1::vector::empty<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPoint>();
        let v5 = 0x1::vector::flatten<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPoint>(v0);
        0x1::vector::reverse<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPoint>(&mut v5);
        let v6 = 0;
        while (v6 < 0x1::vector::length<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPoint>(&v5)) {
            let v7 = 0x1::vector::pop_back<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPoint>(&mut v5);
            if (0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::feed_id(&v7) == arg1) {
                0x1::vector::push_back<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPoint>(&mut v4, v7);
            };
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPoint>(v5);
        let v8 = vector[];
        0x1::vector::reverse<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPoint>(&mut v4);
        let v9 = 0;
        while (v9 < 0x1::vector::length<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPoint>(&v4)) {
            let v10 = 0x1::vector::pop_back<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPoint>(&mut v4);
            0x1::vector::push_back<vector<u8>>(&mut v8, *0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::value(&v10));
            v9 = v9 + 1;
        };
        0x1::vector::destroy_empty<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPoint>(v4);
        v8
    }

    fun filter_packages_by_feed_id(arg0: &vector<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPackage>, arg1: &vector<u8>) : vector<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPackage> {
        let v0 = 0x1::vector::empty<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPackage>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPackage>(arg0)) {
            let v2 = 0x1::vector::borrow<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPackage>(arg0, v1);
            if (data_points_contains_feed_id(0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::data_points(v2), arg1)) {
                0x1::vector::push_back<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPackage>(&mut v0, *v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun package_timestamp(arg0: &Payload) : u64 {
        0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::timestamp(0x1::vector::borrow<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPackage>(&arg0.data_packages, 0))
    }

    fun parse_raw_payload(arg0: vector<u8>) : Payload {
        0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_validate::verify_redstone_marker(&arg0);
        let v0 = &mut arg0;
        trim_redstone_marker(v0);
        let v1 = &mut arg0;
        trim_payload(v1)
    }

    public fun process_payload(arg0: &0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_config::Config, arg1: u64, arg2: vector<u8>, arg3: vector<u8>) : (u256, u64) {
        let v0 = parse_raw_payload(arg3);
        let v1 = data_packages(&v0);
        let v2 = filter_packages_by_feed_id(&v1, &arg2);
        0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_validate::verify_data_packages(&v2, arg0, arg1);
        let v3 = vector[];
        let v4 = extract_values_by_feed_id(&v0, &arg2);
        0x1::vector::reverse<vector<u8>>(&mut v4);
        let v5 = 0;
        while (v5 < 0x1::vector::length<vector<u8>>(&v4)) {
            let v6 = 0x1::vector::pop_back<vector<u8>>(&mut v4);
            0x1::vector::push_back<u256>(&mut v3, 0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_conv::from_bytes_to_u256(&v6));
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(v4);
        (0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_median::calculate_median(&mut v3), package_timestamp(&v0))
    }

    fun trim_data_package(arg0: &mut vector<u8>) : 0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPackage {
        let v0 = trim_end(arg0, 65);
        let v1 = *arg0;
        let v2 = trim_data_point_count(arg0);
        let v3 = trim_data_point_value_size(arg0);
        let v4 = trim_timestamp(arg0);
        let v5 = &mut v1;
        let v6 = trim_end(v5, v2 * (v3 + 32) + 4 + 6 + 3);
        0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::new_data_package(0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_crypto::recover_address(&v6, &v0), v4, trim_data_points(arg0, v2, v3))
    }

    fun trim_data_packages(arg0: &mut vector<u8>, arg1: u64) : vector<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPackage> {
        let v0 = 0x1::vector::empty<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPackage>();
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPackage>(&mut v0, trim_data_package(arg0));
            v1 = v1 + 1;
        };
        v0
    }

    fun trim_data_point(arg0: &mut vector<u8>, arg1: u64) : 0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPoint {
        let v0 = trim_end(arg0, arg1);
        0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::new_data_point(trim_end(arg0, 32), v0)
    }

    fun trim_data_point_count(arg0: &mut vector<u8>) : u64 {
        let v0 = trim_end(arg0, 3);
        0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_conv::from_bytes_to_u64(&v0)
    }

    fun trim_data_point_value_size(arg0: &mut vector<u8>) : u64 {
        let v0 = trim_end(arg0, 4);
        0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_conv::from_bytes_to_u64(&v0)
    }

    fun trim_data_points(arg0: &mut vector<u8>, arg1: u64, arg2: u64) : vector<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPoint> {
        let v0 = 0x1::vector::empty<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPoint>();
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_data_package::DataPoint>(&mut v0, trim_data_point(arg0, arg2));
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
        trim_end(arg0, 0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_conv::from_bytes_to_u64(&v0));
        let v1 = trim_end(arg0, 2);
        0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_conv::from_bytes_to_u64(&v1)
    }

    fun trim_payload(arg0: &mut vector<u8>) : Payload {
        let v0 = trim_metadata(arg0);
        let v1 = trim_data_packages(arg0, v0);
        assert!(0x1::vector::is_empty<u8>(arg0), 0);
        Payload{data_packages: v1}
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
        0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_conv::from_bytes_to_u64(&v0)
    }

    // decompiled from Move bytecode v6
}

