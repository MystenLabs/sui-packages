module 0xcce42c41428b1c48da45a998302a7a6c9a54261d50af1d78402a8340a7d6cb7d::feed_info_object {
    struct FeedInfoObjectKey<phantom T0> has copy, drop, store {
        pos0: vector<u8>,
    }

    struct SharePolicy {
        pos0: 0x2::object::ID,
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

    public fun migrate<T0, T1>(arg0: &mut FeedInfoObject, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::authority::VENDOR<T0>, T1>, arg2: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::Source<0xcce42c41428b1c48da45a998302a7a6c9a54261d50af1d78402a8340a7d6cb7d::source::PYTH_LAZER_ROLLING>, arg3: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::config::Config, arg4: u32, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        0xcce42c41428b1c48da45a998302a7a6c9a54261d50af1d78402a8340a7d6cb7d::source::assert_version(arg2);
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::config::assert_package_version(arg3);
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::authority::assert_is_admin_or_maintenance<T1>();
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::config::assert_vendor_authority_cap_is_valid<T0, T1>(arg3, arg1);
        let v0 = arg0;
        let v1 = FeedInfoObjectKey<T0>{pos0: *0x1::string::as_bytes(&v0.symbol)};
        assert!(0x2::object::uid_to_inner(&v0.id) == 0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::child_id<0xcce42c41428b1c48da45a998302a7a6c9a54261d50af1d78402a8340a7d6cb7d::source::PYTH_LAZER_ROLLING, FeedInfoObjectKey<T0>>(arg2, v1), 13835341334145269763);
        assert!(arg6 < arg7, 13835622293726035973);
        let v2 = 0x2::clock::timestamp_ms(arg8);
        assert!(arg0.roll_end_timestamp_ms <= v2, 13836185282334425097);
        assert!(v2 < arg6, 13836466783081070603);
        assert!(arg7 <= arg5, 13837029745919655951);
        assert!(arg4 != arg0.next_feed_id, 13837311238076366865);
        arg0.front_feed_id = arg0.next_feed_id;
        arg0.next_feed_id = arg4;
        arg0.expiry_timestamp_ms = arg5;
        arg0.roll_start_timestamp_ms = arg6;
        arg0.roll_end_timestamp_ms = arg7;
        0xcce42c41428b1c48da45a998302a7a6c9a54261d50af1d78402a8340a7d6cb7d::events::emit_migrated_feed_info_object(0x2::object::uid_to_inner(&arg0.id), arg0.front_feed_id, arg0.next_feed_id, arg0.expiry_timestamp_ms);
        0xcce42c41428b1c48da45a998302a7a6c9a54261d50af1d78402a8340a7d6cb7d::events::emit_updated_rolling_window(0x2::object::uid_to_inner(&arg0.id), arg0.roll_start_timestamp_ms, arg0.roll_end_timestamp_ms);
    }

    public fun new<T0, T1>(arg0: &mut 0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::Source<0xcce42c41428b1c48da45a998302a7a6c9a54261d50af1d78402a8340a7d6cb7d::source::PYTH_LAZER_ROLLING>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::authority::VENDOR<T0>, T1>, arg2: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::config::Config, arg3: 0x1::string::String, arg4: u32, arg5: u32, arg6: u64, arg7: u64, arg8: u64) : (FeedInfoObject, SharePolicy) {
        0xcce42c41428b1c48da45a998302a7a6c9a54261d50af1d78402a8340a7d6cb7d::source::assert_version(arg0);
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::config::assert_package_version(arg2);
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::authority::assert_is_admin_or_assistant<T1>();
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::config::assert_vendor_authority_cap_is_valid<T0, T1>(arg2, arg1);
        assert!(arg7 < arg8, 13835621683840679941);
        assert!(arg8 <= arg6, 13837029075904757775);
        assert!(arg5 != arg4, 13837310563766501393);
        let v0 = FeedInfoObjectKey<T0>{pos0: 0x1::string::into_bytes(arg3)};
        assert!(!0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::child_exists<0xcce42c41428b1c48da45a998302a7a6c9a54261d50af1d78402a8340a7d6cb7d::source::PYTH_LAZER_ROLLING, FeedInfoObjectKey<T0>>(arg0, v0), 13835058794016538625);
        let v1 = FeedInfoObject{
            id                      : 0x2::derived_object::claim<FeedInfoObjectKey<T0>>(0xcce42c41428b1c48da45a998302a7a6c9a54261d50af1d78402a8340a7d6cb7d::source::borrow_mut_id(arg0), v0),
            symbol                  : arg3,
            front_feed_id           : arg4,
            next_feed_id            : arg5,
            roll_start_timestamp_ms : arg7,
            roll_end_timestamp_ms   : arg8,
            expiry_timestamp_ms     : arg6,
        };
        let v2 = SharePolicy{pos0: 0x2::object::uid_to_inner(&v1.id)};
        (v1, v2)
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

    public fun set_rolling_window<T0, T1>(arg0: &mut FeedInfoObject, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::authority::VENDOR<T0>, T1>, arg2: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::Source<0xcce42c41428b1c48da45a998302a7a6c9a54261d50af1d78402a8340a7d6cb7d::source::PYTH_LAZER_ROLLING>, arg3: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::config::Config, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        0xcce42c41428b1c48da45a998302a7a6c9a54261d50af1d78402a8340a7d6cb7d::source::assert_version(arg2);
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::config::assert_package_version(arg3);
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::authority::assert_is_admin_or_maintenance<T1>();
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::config::assert_vendor_authority_cap_is_valid<T0, T1>(arg3, arg1);
        let v0 = arg0;
        let v1 = FeedInfoObjectKey<T0>{pos0: *0x1::string::as_bytes(&v0.symbol)};
        assert!(0x2::object::uid_to_inner(&v0.id) == 0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::child_id<0xcce42c41428b1c48da45a998302a7a6c9a54261d50af1d78402a8340a7d6cb7d::source::PYTH_LAZER_ROLLING, FeedInfoObjectKey<T0>>(arg2, v1), 13835341334145269763);
        assert!(arg4 < arg5, 13835622650208321541);
        assert!(0x2::clock::timestamp_ms(arg6) < arg5, 13836748575885492237);
        assert!(arg5 <= arg0.expiry_timestamp_ms, 13837030072337170447);
        arg0.roll_start_timestamp_ms = arg4;
        arg0.roll_end_timestamp_ms = arg5;
        0xcce42c41428b1c48da45a998302a7a6c9a54261d50af1d78402a8340a7d6cb7d::events::emit_updated_rolling_window(0x2::object::uid_to_inner(&arg0.id), arg0.roll_start_timestamp_ms, arg0.roll_end_timestamp_ms);
    }

    public fun share(arg0: FeedInfoObject, arg1: SharePolicy) {
        let SharePolicy { pos0: v0 } = arg1;
        assert!(0x2::object::uid_to_inner(&arg0.id) == v0, 13835903360680984583);
        0x2::transfer::share_object<FeedInfoObject>(arg0);
    }

    public fun symbol(arg0: &FeedInfoObject) : 0x1::string::String {
        arg0.symbol
    }

    // decompiled from Move bytecode v7
}

