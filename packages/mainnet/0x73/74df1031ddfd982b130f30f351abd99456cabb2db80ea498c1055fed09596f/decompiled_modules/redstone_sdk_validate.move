module 0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::redstone_sdk_validate {
    public fun verify_data_packages(arg0: &vector<0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::redstone_sdk_data_package::DataPackage>, arg1: &0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::redstone_sdk_config::Config, arg2: u64) {
        verify_timestamps_are_the_same(arg0);
        verify_timestamp(0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::redstone_sdk_data_package::timestamp(0x1::vector::borrow<0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::redstone_sdk_data_package::DataPackage>(arg0, 0)), arg1, arg2);
        let v0 = 0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::redstone_sdk_config::signers(arg1);
        verify_signer_count(arg0, 0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::redstone_sdk_config::signer_count_threshold(arg1), &v0);
    }

    public fun verify_redstone_marker(arg0: &vector<u8>) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 >= 9, 0);
        let v1 = x"000002ed57011e0000";
        let v2 = v0 - 9;
        while (v2 < v0) {
            assert!(*0x1::vector::borrow<u8>(arg0, v2) == *0x1::vector::borrow<u8>(&v1, v2 + 9 - v0), 0);
            v2 = v2 + 1;
        };
    }

    fun verify_signer_count(arg0: &vector<0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::redstone_sdk_data_package::DataPackage>, arg1: u8, arg2: &vector<vector<u8>>) {
        let v0 = 0;
        let v1 = 0x2::vec_set::from_keys<vector<u8>>(*arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::redstone_sdk_data_package::DataPackage>(arg0)) {
            let v3 = 0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::redstone_sdk_data_package::signer_address(0x1::vector::borrow<0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::redstone_sdk_data_package::DataPackage>(arg0, v2));
            if (0x2::vec_set::contains<vector<u8>>(&v1, v3)) {
                v0 = v0 + 1;
                0x2::vec_set::remove<vector<u8>>(&mut v1, v3);
            };
            v2 = v2 + 1;
        };
        assert!(v0 >= arg1, 3);
    }

    fun verify_timestamp(arg0: u64, arg1: &0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::redstone_sdk_config::Config, arg2: u64) {
        assert!(arg0 + 0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::redstone_sdk_config::max_timestamp_delay_ms(arg1) >= arg2, 1);
        assert!(arg0 <= arg2 + 0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::redstone_sdk_config::max_timestamp_ahead_ms(arg1), 2);
    }

    fun verify_timestamps_are_the_same(arg0: &vector<0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::redstone_sdk_data_package::DataPackage>) {
        assert!(!0x1::vector::is_empty<0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::redstone_sdk_data_package::DataPackage>(arg0), 5);
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::redstone_sdk_data_package::DataPackage>(arg0)) {
            if (!(0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::redstone_sdk_data_package::timestamp(0x1::vector::borrow<0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::redstone_sdk_data_package::DataPackage>(arg0, v0)) == 0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::redstone_sdk_data_package::timestamp(0x1::vector::borrow<0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::redstone_sdk_data_package::DataPackage>(arg0, 0)))) {
                v1 = false;
                /* label 8 */
                assert!(v1, 4);
                return
            };
            v0 = v0 + 1;
        };
        v1 = true;
        /* goto 8 */
    }

    // decompiled from Move bytecode v6
}

