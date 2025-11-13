module 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_update_check {
    public(friend) fun is_update_time_sound(arg0: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_config::Config, arg1: u64, arg2: u64, arg3: address) : 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::Result<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::unit::Unit> {
        let v0 = if (sender_in_trusted(arg0, arg3)) {
            arg1 + 1
        } else {
            arg1 + 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::redstone_sdk_config::min_interval_between_updates_ms(arg0) + 1
        };
        if (arg2 < v0) {
            return 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::error<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::unit::Unit>(b"Bad update time")
        };
        0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::result::ok<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::unit::Unit>(0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::unit::unit())
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

