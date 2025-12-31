module 0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::quota_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        global_time_window_ms: 0x1::option::Option<u64>,
        global_max_requests_per_window: 0x1::option::Option<u64>,
        global_max_total_requests: 0x1::option::Option<u64>,
        user_time_window_ms: 0x1::option::Option<u64>,
        user_max_requests_per_window: 0x1::option::Option<u64>,
        user_max_total_requests: 0x1::option::Option<u64>,
    }

    struct QuotaState has store {
        window_start_time: u64,
        window_request_count: u64,
        total_request_count: u64,
    }

    struct GlobalQuotaKey has copy, drop, store {
        dummy_field: bool,
    }

    struct UserQuotaKey has copy, drop, store {
        user: address,
    }

    public fun add(arg0: &mut 0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::signing_policy::SigningPolicy, arg1: &0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::signing_policy::SigningPolicyCap, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>) {
        let v0 = 0x1::option::is_some<u64>(&arg2) || 0x1::option::is_some<u64>(&arg4);
        let v1 = 0x1::option::is_some<u64>(&arg5) || 0x1::option::is_some<u64>(&arg7);
        assert!(v0 || v1, 3);
        if (0x1::option::is_some<u64>(&arg2)) {
            assert!(0x1::option::is_some<u64>(&arg3), 3);
        };
        if (0x1::option::is_some<u64>(&arg5)) {
            assert!(0x1::option::is_some<u64>(&arg6), 3);
        };
        let v2 = Rule{dummy_field: false};
        let v3 = Config{
            global_time_window_ms          : arg2,
            global_max_requests_per_window : arg3,
            global_max_total_requests      : arg4,
            user_time_window_ms            : arg5,
            user_max_requests_per_window   : arg6,
            user_max_total_requests        : arg7,
        };
        0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::signing_policy::add_rule<Rule, Config>(v2, arg0, arg1, v3);
    }

    fun check_and_update_quota<T0: copy + drop + store>(arg0: &mut 0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::umi_signer::UmiSigner, arg1: T0, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: u64, arg6: u64) {
        if (!0x2::dynamic_field::exists_<T0>(0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::umi_signer::uid(arg0), arg1)) {
            let v0 = QuotaState{
                window_start_time    : 0,
                window_request_count : 0,
                total_request_count  : 0,
            };
            0x2::dynamic_field::add<T0, QuotaState>(0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::umi_signer::uid_mut(arg0), arg1, v0);
        };
        let v1 = 0x2::dynamic_field::borrow_mut<T0, QuotaState>(0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::umi_signer::uid_mut(arg0), arg1);
        if (0x1::option::is_some<u64>(&arg2)) {
            if (arg5 - v1.window_start_time > *0x1::option::borrow<u64>(&arg2)) {
                v1.window_start_time = arg5;
                v1.window_request_count = 0;
            };
            assert!(v1.window_request_count < *0x1::option::borrow<u64>(&arg3), arg6);
            v1.window_request_count = v1.window_request_count + 1;
        };
        if (0x1::option::is_some<u64>(&arg4)) {
            assert!(v1.total_request_count < *0x1::option::borrow<u64>(&arg4), arg6);
        };
        v1.total_request_count = v1.total_request_count + 1;
    }

    public fun get_global_quota_state(arg0: &0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::umi_signer::UmiSigner) : (u64, u64, u64) {
        let v0 = 0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::umi_signer::uid(arg0);
        let v1 = GlobalQuotaKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<GlobalQuotaKey>(v0, v1)) {
            return (0, 0, 0)
        };
        let v2 = GlobalQuotaKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow<GlobalQuotaKey, QuotaState>(v0, v2);
        (v3.window_start_time, v3.window_request_count, v3.total_request_count)
    }

    public fun get_user_quota_state(arg0: &0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::umi_signer::UmiSigner, arg1: address) : (u64, u64, u64) {
        let v0 = 0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::umi_signer::uid(arg0);
        let v1 = UserQuotaKey{user: arg1};
        if (!0x2::dynamic_field::exists_<UserQuotaKey>(v0, v1)) {
            return (0, 0, 0)
        };
        let v2 = 0x2::dynamic_field::borrow<UserQuotaKey, QuotaState>(v0, v1);
        (v2.window_start_time, v2.window_request_count, v2.total_request_count)
    }

    public fun prove(arg0: &mut 0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::signing_policy::SigningRequest, arg1: &0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::signing_policy::SigningPolicy, arg2: &mut 0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::umi_signer::UmiSigner, arg3: &0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::signing_policy::get_rule<Rule, Config>(v0, arg1);
        let v2 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        if (0x1::option::is_some<u64>(&v1.global_time_window_ms) || 0x1::option::is_some<u64>(&v1.global_max_total_requests)) {
            let v3 = GlobalQuotaKey{dummy_field: false};
            check_and_update_quota<GlobalQuotaKey>(arg2, v3, v1.global_time_window_ms, v1.global_max_requests_per_window, v1.global_max_total_requests, v2, 1);
        };
        if (0x1::option::is_some<u64>(&v1.user_time_window_ms) || 0x1::option::is_some<u64>(&v1.user_max_total_requests)) {
            let v4 = UserQuotaKey{user: 0x2::tx_context::sender(arg3)};
            check_and_update_quota<UserQuotaKey>(arg2, v4, v1.user_time_window_ms, v1.user_max_requests_per_window, v1.user_max_total_requests, v2, 2);
        };
        let v5 = Rule{dummy_field: false};
        0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::signing_policy::add_receipt<Rule>(v5, arg0);
    }

    // decompiled from Move bytecode v6
}

