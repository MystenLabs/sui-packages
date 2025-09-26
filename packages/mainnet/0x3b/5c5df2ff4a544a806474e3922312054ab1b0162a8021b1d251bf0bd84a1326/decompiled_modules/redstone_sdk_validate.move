module 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_validate {
    public fun try_verify_data_packages(arg0: &vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>, arg1: &0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_config::Config, arg2: u64) : 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::Result<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit> {
        let v0 = verify_timestamps_are_the_same(arg0);
        if (!0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::is_ok<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(&v0)) {
            return v0
        };
        let v1 = verify_timestamp(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::timestamp(0x1::vector::borrow<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(arg0, 0)), arg1, arg2);
        if (!0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::is_ok<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(&v1)) {
            return v1
        };
        let v2 = 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_config::signers(arg1);
        verify_signer_count(arg0, 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_config::signer_count_threshold(arg1), &v2)
    }

    public fun try_verify_redstone_marker(arg0: &vector<u8>) : 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::Result<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit> {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 < 9) {
            return 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::error<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(b"Bad redstone marker, not enough bytes")
        };
        let v1 = x"000002ed57011e0000";
        let v2 = 0;
        while (v2 < 9) {
            if (*0x1::vector::borrow<u8>(arg0, v0 - 9 + v2) != *0x1::vector::borrow<u8>(&v1, v2)) {
                return 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::error<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(b"Bad redstone marker, byte missmatch")
            };
            v2 = v2 + 1;
        };
        0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::ok<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::unit())
    }

    public fun verify_data_packages(arg0: &vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>, arg1: &0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_config::Config, arg2: u64) {
        abort 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::constants::deprecated_code()
    }

    public fun verify_redstone_marker(arg0: &vector<u8>) {
        abort 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::constants::deprecated_code()
    }

    fun verify_signer_count(arg0: &vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>, arg1: u8, arg2: &vector<vector<u8>>) : 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::Result<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit> {
        let v0 = 0;
        let v1 = 0x2::vec_set::from_keys<vector<u8>>(*arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(arg0)) {
            let v3 = 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::signer_address(0x1::vector::borrow<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(arg0, v2));
            if (!0x2::vec_set::contains<vector<u8>>(&v1, v3)) {
                return 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::error<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(b"Unknown or duplicated signer")
            };
            0x2::vec_set::remove<vector<u8>>(&mut v1, v3);
            v0 = v0 + 1;
            v2 = v2 + 1;
        };
        if (v0 < (arg1 as u64)) {
            return 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::error<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(b"Insufficient signer count")
        };
        0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::ok<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::unit())
    }

    fun verify_timestamp(arg0: u64, arg1: &0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_config::Config, arg2: u64) : 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::Result<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit> {
        if (arg0 + 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_config::max_timestamp_delay_ms(arg1) < arg2) {
            return 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::error<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(b"Timestamp too old")
        };
        if (arg0 > arg2 + 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_config::max_timestamp_ahead_ms(arg1)) {
            return 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::error<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(b"Timestamp too future")
        };
        0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::ok<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::unit())
    }

    fun verify_timestamps_are_the_same(arg0: &vector<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>) : 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::Result<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit> {
        if (0x1::vector::is_empty<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(arg0)) {
            return 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::error<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(b"Empty data packages")
        };
        let v0 = 1;
        while (v0 < 0x1::vector::length<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(arg0)) {
            if (0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::timestamp(0x1::vector::borrow<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(arg0, v0)) != 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::timestamp(0x1::vector::borrow<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_data_package::DataPackage>(arg0, 0))) {
                return 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::error<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(b"Not all timestamps are the same")
            };
            v0 = v0 + 1;
        };
        0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::ok<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::unit())
    }

    // decompiled from Move bytecode v6
}

