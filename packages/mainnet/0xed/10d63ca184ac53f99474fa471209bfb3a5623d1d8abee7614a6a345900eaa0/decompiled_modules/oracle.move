module 0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::oracle {
    struct SlippageValidated has copy, drop {
        price_a: u128,
        price_b: u128,
        deviation_scaled: u128,
        threshold: u128,
    }

    public fun get_validated_price<T0>(arg0: &0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::core::OracleRegistry, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg3: &0x2::clock::Clock, arg4: u64) : 0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::core::NormalizedPrice {
        0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::core::check_version(arg0);
        let v0 = 0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::core::get_config<T0>(arg0);
        let v1 = 0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::core::is_pyth_enabled<T0>(v0);
        let v2 = 0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::core::is_stork_enabled<T0>(v0);
        if (v1 && v2) {
            let v4 = 0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::pyth_adapter::get_pyth_price<T0>(arg0, arg1, arg3, arg4);
            let v5 = 0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::stork_adapter::get_stork_price<T0>(arg0, arg2, arg3, arg4);
            validate_slippage(&v4, &v5, 0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::core::config_max_slippage<T0>(v0));
            v4
        } else if (v1) {
            0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::pyth_adapter::get_pyth_price<T0>(arg0, arg1, arg3, arg4)
        } else {
            assert!(v2, 14);
            0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::stork_adapter::get_stork_price<T0>(arg0, arg2, arg3, arg4)
        }
    }

    public fun is_price_stale(arg0: &0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::core::NormalizedPrice, arg1: u64, arg2: u64) : bool {
        let v0 = 0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::core::publish_time(arg0);
        let v1 = if (arg1 > v0) {
            arg1 - v0
        } else {
            0
        };
        v1 > arg2
    }

    fun normalize_to_e18(arg0: u128, arg1: &0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::zo_i64::I64) : u128 {
        let v0 = 0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::zo_i64::get_is_negative(arg1);
        let v1 = if (v0) {
            0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::zo_i64::get_magnitude_if_negative(arg1)
        } else {
            0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::zo_i64::get_magnitude_if_positive(arg1)
        };
        if (v0) {
            assert!(v1 <= 18, 16);
        } else {
            assert!(v1 <= 20, 16);
        };
        let v2 = if (v0) {
            pow10(18 - v1)
        } else {
            pow10(18 + v1)
        };
        let v3 = arg0 * v2;
        assert!(v3 / v2 == arg0, 15);
        v3
    }

    fun pow10(arg0: u64) : u128 {
        assert!(arg0 <= 38, 16);
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    fun validate_slippage(arg0: &0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::core::NormalizedPrice, arg1: &0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::core::NormalizedPrice, arg2: u64) {
        let v0 = 0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::core::expo(arg0);
        let v1 = normalize_to_e18(0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::core::price(arg0), &v0);
        let v2 = 0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::core::expo(arg1);
        let v3 = normalize_to_e18(0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::core::price(arg1), &v2);
        assert!(v1 > 0 && v3 > 0, 18);
        let v4 = if (v1 > v3) {
            v1 - v3
        } else {
            v3 - v1
        };
        assert!(v4 <= 340282366920938463463374607, 17);
        let v5 = v4 * 1000000000000 / v1;
        let v6 = (arg2 as u128) / 0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::core::price_deviation_scale() / 1000000000000;
        assert!(v5 <= v6, 13);
        let v7 = SlippageValidated{
            price_a          : v1,
            price_b          : v3,
            deviation_scaled : v5,
            threshold        : v6,
        };
        0x2::event::emit<SlippageValidated>(v7);
    }

    // decompiled from Move bytecode v6
}

