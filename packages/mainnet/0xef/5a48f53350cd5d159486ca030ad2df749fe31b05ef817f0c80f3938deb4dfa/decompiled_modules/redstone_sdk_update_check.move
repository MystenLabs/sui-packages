module 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_update_check {
    public(friend) fun assert_update_time(arg0: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_config::Config, arg1: u64, arg2: u64, arg3: address) {
        if (sender_in_trusted(arg0, arg3)) {
            assert!(arg1 < arg2, 0);
        } else {
            assert!(arg1 + 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_config::min_interval_between_updates_ms(arg0) < arg2, 0);
        };
    }

    fun sender_in_trusted(arg0: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_config::Config, arg1: address) : bool {
        let v0 = 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_config::trusted_updaters(arg0);
        let v1 = &v0;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<address>(v1)) {
            if (0x1::vector::borrow<address>(v1, v2) == &arg1) {
                v3 = true;
                return v3
            };
            v2 = v2 + 1;
        };
        v3 = false;
        v3
    }

    // decompiled from Move bytecode v6
}

