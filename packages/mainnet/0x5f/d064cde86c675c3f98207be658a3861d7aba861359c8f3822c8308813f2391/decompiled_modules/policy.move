module 0x5fd064cde86c675c3f98207be658a3861d7aba861359c8f3822c8308813f2391::policy {
    struct AgentPolicy has store, key {
        id: 0x2::object::UID,
        owner: address,
        daily_sui_limit_mist: u64,
        max_per_tx_mist: u64,
        allowed_tokens: vector<0x1::string::String>,
        spent_today_mist: u64,
        daily_usdc_limit: u64,
        max_per_tx_usdc: u64,
        spent_today_usdc: u64,
        seam_day: u64,
    }

    struct PolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        owner: address,
    }

    struct PolicyUpdated has copy, drop {
        policy_id: 0x2::object::ID,
        owner: address,
    }

    struct SpendRecorded has copy, drop {
        policy_id: 0x2::object::ID,
        owner: address,
        coin_type: 0x1::string::String,
        amount_mist: u64,
        spent_today_mist: u64,
        spent_today_usdc: u64,
    }

    public fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: vector<0x1::string::String>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : AgentPolicy {
        assert_tokens(&arg4);
        let v0 = AgentPolicy{
            id                   : 0x2::object::new(arg6),
            owner                : 0x2::tx_context::sender(arg6),
            daily_sui_limit_mist : arg0,
            max_per_tx_mist      : arg1,
            allowed_tokens       : arg4,
            spent_today_mist     : 0,
            daily_usdc_limit     : arg2,
            max_per_tx_usdc      : arg3,
            spent_today_usdc     : 0,
            seam_day             : seam_day_at(0x2::clock::timestamp_ms(arg5)),
        };
        let v1 = PolicyCreated{
            policy_id : 0x2::object::id<AgentPolicy>(&v0),
            owner     : v0.owner,
        };
        0x2::event::emit<PolicyCreated>(v1);
        v0
    }

    public fun allowed_tokens(arg0: &AgentPolicy) : &vector<0x1::string::String> {
        &arg0.allowed_tokens
    }

    fun assert_tokens(arg0: &vector<0x1::string::String>) {
        let v0 = 0x1::vector::length<0x1::string::String>(arg0);
        assert!(v0 > 0, 1);
        assert!(v0 <= 16, 2);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<0x1::string::String>(arg0, v1);
            assert!(0x1::string::length(v2) > 0, 7);
            let v3 = v1 + 1;
            while (v3 < v0) {
                assert!(0x1::vector::borrow<0x1::string::String>(arg0, v3) != v2, 3);
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
    }

    public fun burn(arg0: AgentPolicy, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        let AgentPolicy {
            id                   : v0,
            owner                : _,
            daily_sui_limit_mist : _,
            max_per_tx_mist      : _,
            allowed_tokens       : _,
            spent_today_mist     : _,
            daily_usdc_limit     : _,
            max_per_tx_usdc      : _,
            spent_today_usdc     : _,
            seam_day             : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    entry fun create(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: vector<0x1::string::String>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = new(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::transfer<AgentPolicy>(v0, 0x2::tx_context::sender(arg6));
    }

    public fun daily_sui_limit_mist(arg0: &AgentPolicy) : u64 {
        arg0.daily_sui_limit_mist
    }

    public fun daily_usdc_limit(arg0: &AgentPolicy) : u64 {
        arg0.daily_usdc_limit
    }

    public fun days_from_civil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg1 <= 2) {
            arg0 - 1
        } else {
            arg0
        };
        let v1 = v0 / 400;
        let v2 = v0 - v1 * 400;
        let v3 = if (arg1 > 2) {
            arg1 - 3
        } else {
            arg1 + 9
        };
        v1 * 146097 + v2 * 365 + v2 / 4 - v2 / 100 + (153 * v3 + 2) / 5 + arg2 - 1 - 719468
    }

    fun is_allowed(arg0: &vector<0x1::string::String>, arg1: &0x1::string::String) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(arg0)) {
            if (0x1::vector::borrow<0x1::string::String>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun is_sui(arg0: &0x1::string::String) : bool {
        let v0 = b"::sui::SUI";
        let v1 = 0x1::string::length(arg0);
        let v2 = 0x1::vector::length<u8>(&v0);
        if (v1 < v2) {
            return false
        };
        0x1::string::substring(arg0, v1 - v2, v1) == 0x1::string::utf8(v0)
    }

    fun is_usdc(arg0: &0x1::string::String) : bool {
        let v0 = b"::usdc::USDC";
        let v1 = 0x1::string::length(arg0);
        let v2 = 0x1::vector::length<u8>(&v0);
        if (v1 < v2) {
            return false
        };
        0x1::string::substring(arg0, v1 - v2, v1) == 0x1::string::utf8(v0)
    }

    public fun la_offset_hours(arg0: u64) : u64 {
        let v0 = year_of_days(arg0 / 86400000);
        if (arg0 >= nth_sunday(v0, 3, 2) * 86400000 + 10 * 3600000 && arg0 < nth_sunday(v0, 11, 1) * 86400000 + 9 * 3600000) {
            7
        } else {
            8
        }
    }

    public fun max_per_tx_mist(arg0: &AgentPolicy) : u64 {
        arg0.max_per_tx_mist
    }

    public fun max_per_tx_usdc(arg0: &AgentPolicy) : u64 {
        arg0.max_per_tx_usdc
    }

    fun nth_sunday(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = days_from_civil(arg0, arg1, 1);
        v0 + (7 - (v0 + 4) % 7) % 7 + (arg2 - 1) * 7
    }

    public fun owner(arg0: &AgentPolicy) : address {
        arg0.owner
    }

    entry fun record_spend(arg0: &mut AgentPolicy, arg1: 0x1::string::String, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 0);
        assert!(is_allowed(&arg0.allowed_tokens, &arg1), 4);
        let v0 = is_sui(&arg1);
        if (!v0 && !is_usdc(&arg1)) {
            return
        };
        let v1 = seam_day_at(0x2::clock::timestamp_ms(arg3));
        if (v1 != arg0.seam_day) {
            arg0.spent_today_mist = 0;
            arg0.spent_today_usdc = 0;
            arg0.seam_day = v1;
        };
        if (v0) {
            if (arg0.max_per_tx_mist > 0) {
                assert!(arg2 <= arg0.max_per_tx_mist, 5);
            };
            if (arg0.daily_sui_limit_mist > 0) {
                assert!(arg0.spent_today_mist + arg2 <= arg0.daily_sui_limit_mist, 6);
            };
            arg0.spent_today_mist = arg0.spent_today_mist + arg2;
        } else {
            if (arg0.max_per_tx_usdc > 0) {
                assert!(arg2 <= arg0.max_per_tx_usdc, 8);
            };
            if (arg0.daily_usdc_limit > 0) {
                assert!(arg0.spent_today_usdc + arg2 <= arg0.daily_usdc_limit, 9);
            };
            arg0.spent_today_usdc = arg0.spent_today_usdc + arg2;
        };
        let v2 = SpendRecorded{
            policy_id        : 0x2::object::id<AgentPolicy>(arg0),
            owner            : arg0.owner,
            coin_type        : arg1,
            amount_mist      : arg2,
            spent_today_mist : arg0.spent_today_mist,
            spent_today_usdc : arg0.spent_today_usdc,
        };
        0x2::event::emit<SpendRecorded>(v2);
    }

    public fun seam_day(arg0: &AgentPolicy) : u64 {
        arg0.seam_day
    }

    public fun seam_day_at(arg0: u64) : u64 {
        if (arg0 < 6 * 3600000 + 8 * 3600000) {
            return 0
        };
        let v0 = arg0 - 6 * 3600000;
        (v0 - la_offset_hours(v0) * 3600000) / 86400000
    }

    entry fun set_policy(arg0: &mut AgentPolicy, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: vector<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.owner, 0);
        assert_tokens(&arg5);
        arg0.daily_sui_limit_mist = arg1;
        arg0.max_per_tx_mist = arg2;
        arg0.daily_usdc_limit = arg3;
        arg0.max_per_tx_usdc = arg4;
        arg0.allowed_tokens = arg5;
        let v0 = PolicyUpdated{
            policy_id : 0x2::object::id<AgentPolicy>(arg0),
            owner     : arg0.owner,
        };
        0x2::event::emit<PolicyUpdated>(v0);
    }

    public fun spent_today_mist(arg0: &AgentPolicy) : u64 {
        arg0.spent_today_mist
    }

    public fun spent_today_usdc(arg0: &AgentPolicy) : u64 {
        arg0.spent_today_usdc
    }

    fun year_of_days(arg0: u64) : u64 {
        let v0 = arg0 + 719468;
        let v1 = v0 / 146097;
        let v2 = v0 - v1 * 146097;
        let v3 = (v2 - v2 / 1460 + v2 / 36524 - v2 / 146096) / 365;
        let v4 = (5 * (v2 - 365 * v3 + v3 / 4 - v3 / 100) + 2) / 153;
        let v5 = if (v4 < 10) {
            v4 + 3
        } else {
            v4 - 9
        };
        let v6 = if (v5 <= 2) {
            1
        } else {
            0
        };
        v3 + v1 * 400 + v6
    }

    // decompiled from Move bytecode v7
}

