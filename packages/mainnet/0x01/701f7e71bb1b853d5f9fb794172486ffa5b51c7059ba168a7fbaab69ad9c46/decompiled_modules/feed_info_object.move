module 0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::feed_info_object {
    struct FeedInfoObjectKey<phantom T0> has copy, drop, store {
        pos0: vector<u8>,
    }

    struct FeedInfoObject has store, key {
        id: 0x2::object::UID,
        symbol: 0x1::string::String,
        front_feed_id: u32,
        next_feed_id: u32,
        roll_start_timestamp_ms: u64,
        roll_end_timestamp_ms: u64,
        expiry_timestamp_ms: u64,
    }

    public fun expiry_timestamp_ms(arg0: &FeedInfoObject) : u64 {
        arg0.expiry_timestamp_ms
    }

    public fun front_feed_id(arg0: &FeedInfoObject) : u32 {
        arg0.front_feed_id
    }

    public fun migrate<T0, T1>(arg0: &mut FeedInfoObject, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, T1>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::source::PYTH_LAZER_ROLLING>, arg3: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg4: u32, arg5: u64, arg6: u64, arg7: u64) {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::assert_package_version(arg3);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::assert_is_admin_or_maintenance<T1>();
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::assert_vendor_authority_cap_is_valid<T0, T1>(arg3, arg1);
        let v0 = arg0;
        let v1 = FeedInfoObjectKey<T0>{pos0: *0x1::string::as_bytes(&v0.symbol)};
        assert!(0x2::object::uid_to_inner(&v0.id) == 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::child_id<0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::source::PYTH_LAZER_ROLLING, FeedInfoObjectKey<T0>>(arg2, v1), 13835340818749194243);
        assert!(arg6 < arg7, 13835621945833684997);
        arg0.front_feed_id = arg0.next_feed_id;
        arg0.next_feed_id = arg4;
        arg0.expiry_timestamp_ms = arg5;
        arg0.roll_start_timestamp_ms = arg6;
        arg0.roll_end_timestamp_ms = arg7;
        0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::events::emit_migrated_feed_info_object(0x2::object::uid_to_inner(&arg0.id), arg0.front_feed_id, arg0.next_feed_id, arg0.expiry_timestamp_ms);
        0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::events::emit_updated_rolling_window(0x2::object::uid_to_inner(&arg0.id), arg0.roll_start_timestamp_ms, arg0.roll_end_timestamp_ms);
    }

    public fun new<T0, T1>(arg0: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::source::PYTH_LAZER_ROLLING>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, T1>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg3: 0x1::string::String, arg4: u32, arg5: u32, arg6: u64, arg7: u64, arg8: u64) : FeedInfoObject {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::assert_package_version(arg2);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::assert_is_admin_or_assistant<T1>();
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::assert_vendor_authority_cap_is_valid<T0, T1>(arg2, arg1);
        assert!(arg7 < arg8, 13835621494862118917);
        let v0 = FeedInfoObjectKey<T0>{pos0: 0x1::string::into_bytes(arg3)};
        assert!(!0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::child_exists<0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::source::PYTH_LAZER_ROLLING, FeedInfoObjectKey<T0>>(arg0, v0), 13835058579268173825);
        FeedInfoObject{
            id                      : 0x2::derived_object::claim<FeedInfoObjectKey<T0>>(0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::source::borrow_mut_id(arg0), v0),
            symbol                  : arg3,
            front_feed_id           : arg4,
            next_feed_id            : arg5,
            roll_start_timestamp_ms : arg7,
            roll_end_timestamp_ms   : arg8,
            expiry_timestamp_ms     : arg6,
        }
    }

    public fun next_feed_id(arg0: &FeedInfoObject) : u32 {
        arg0.next_feed_id
    }

    public fun roll_end_timestamp_ms(arg0: &FeedInfoObject) : u64 {
        arg0.roll_end_timestamp_ms
    }

    public fun roll_start_timestamp_ms(arg0: &FeedInfoObject) : u64 {
        arg0.roll_start_timestamp_ms
    }

    public fun set_rolling_window<T0, T1>(arg0: &mut FeedInfoObject, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, T1>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::source::PYTH_LAZER_ROLLING>, arg3: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg4: u64, arg5: u64) {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::assert_package_version(arg3);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::assert_is_admin_or_maintenance<T1>();
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::assert_vendor_authority_cap_is_valid<T0, T1>(arg3, arg1);
        let v0 = arg0;
        let v1 = FeedInfoObjectKey<T0>{pos0: *0x1::string::as_bytes(&v0.symbol)};
        assert!(0x2::object::uid_to_inner(&v0.id) == 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::child_id<0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::source::PYTH_LAZER_ROLLING, FeedInfoObjectKey<T0>>(arg2, v1), 13835340818749194243);
        assert!(arg4 < arg5, 13835622182056886277);
        arg0.roll_start_timestamp_ms = arg4;
        arg0.roll_end_timestamp_ms = arg5;
        0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::events::emit_updated_rolling_window(0x2::object::uid_to_inner(&arg0.id), arg0.roll_start_timestamp_ms, arg0.roll_end_timestamp_ms);
    }

    public fun symbol(arg0: &FeedInfoObject) : 0x1::string::String {
        arg0.symbol
    }

    // decompiled from Move bytecode v7
}

