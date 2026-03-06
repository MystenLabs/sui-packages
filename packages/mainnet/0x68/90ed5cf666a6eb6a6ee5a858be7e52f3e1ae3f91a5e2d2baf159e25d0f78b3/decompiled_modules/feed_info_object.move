module 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::feed_info_object {
    struct FeedInfoObjectKey has copy, drop, store {
        pos0: vector<u8>,
    }

    struct FeedInfoObject has store, key {
        id: 0x2::object::UID,
        symbol: 0x1::string::String,
        current_feed_id: u32,
        next_feed_id: u32,
        expiry_timestamp_ms: u64,
        roll_start_days: u64,
        cutoff_days: u64,
    }

    public fun current_feed_id(arg0: &FeedInfoObject) : u32 {
        arg0.current_feed_id
    }

    public fun cutoff_days(arg0: &FeedInfoObject) : u64 {
        arg0.cutoff_days
    }

    public fun expiry_timestamp_ms(arg0: &FeedInfoObject) : u64 {
        arg0.expiry_timestamp_ms
    }

    public fun new<T0>(arg0: &mut 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::pyth_lazer_rolling::OracleAggregatorPythLazerRollingIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, T0>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg3: 0x1::string::String, arg4: u32, arg5: u32, arg6: u64, arg7: u64, arg8: u64) : FeedInfoObject {
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::assert_package_version(arg2);
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::assert_authority_cap_is_valid<T0>(arg2, arg1);
        assert!(arg7 > arg8, 1);
        let v0 = 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::pyth_lazer_rolling::borrow_mut_id<T0>(arg0, arg1);
        let v1 = FeedInfoObjectKey{pos0: 0x1::string::into_bytes(arg3)};
        assert!(!0x2::derived_object::exists<FeedInfoObjectKey>(v0, v1), 0);
        FeedInfoObject{
            id                  : 0x2::derived_object::claim<FeedInfoObjectKey>(v0, v1),
            symbol              : arg3,
            current_feed_id     : arg4,
            next_feed_id        : arg5,
            expiry_timestamp_ms : arg6,
            roll_start_days     : arg7,
            cutoff_days         : arg8,
        }
    }

    public fun next_feed_id(arg0: &FeedInfoObject) : u32 {
        arg0.next_feed_id
    }

    public fun roll_start_days(arg0: &FeedInfoObject) : u64 {
        arg0.roll_start_days
    }

    public fun symbol(arg0: &FeedInfoObject) : 0x1::string::String {
        arg0.symbol
    }

    public fun update<T0>(arg0: &mut 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::pyth_lazer_rolling::OracleAggregatorPythLazerRollingIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, T0>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg3: &mut FeedInfoObject, arg4: u32, arg5: u32, arg6: u64, arg7: u64, arg8: u64) {
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::assert_package_version(arg2);
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::assert_authority_cap_is_valid<T0>(arg2, arg1);
        assert!(arg7 > arg8, 1);
        arg3.current_feed_id = arg4;
        arg3.next_feed_id = arg5;
        arg3.expiry_timestamp_ms = arg6;
        arg3.roll_start_days = arg7;
        arg3.cutoff_days = arg8;
    }

    // decompiled from Move bytecode v6
}

