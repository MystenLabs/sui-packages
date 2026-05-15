module 0x56ee956e8784a11c548990367c2cf164474cf843ecbbe918cab634916aa5384f::claimable_quota {
    struct ClaimableQuotaStats has store {
        total_quota_issued: u64,
        total_quota_used: u64,
        total_quota_available: u64,
    }

    struct UserClaimableQuota has drop, store {
        user: address,
        total_issued: u64,
        total_used: u64,
        available_quota: u64,
        last_update_time: u64,
    }

    struct QuotaManager has key {
        id: 0x2::object::UID,
        stats: ClaimableQuotaStats,
        user_quotas: 0x2::table::Table<address, UserClaimableQuota>,
    }

    public fun add_user_quota(arg0: &mut QuotaManager, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) {
        if (arg2 == 0) {
            return
        };
        if (!0x2::table::contains<address, UserClaimableQuota>(&arg0.user_quotas, arg1)) {
            let v0 = UserClaimableQuota{
                user             : arg1,
                total_issued     : 0,
                total_used       : 0,
                available_quota  : 0,
                last_update_time : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::table::add<address, UserClaimableQuota>(&mut arg0.user_quotas, arg1, v0);
        };
        let v1 = 0x2::table::borrow_mut<address, UserClaimableQuota>(&mut arg0.user_quotas, arg1);
        v1.total_issued = v1.total_issued + arg2;
        v1.available_quota = v1.available_quota + arg2;
        v1.last_update_time = 0x2::clock::timestamp_ms(arg3);
        arg0.stats.total_quota_issued = arg0.stats.total_quota_issued + arg2;
        arg0.stats.total_quota_available = arg0.stats.total_quota_available + arg2;
    }

    public fun consume_quota_on_withdraw(arg0: &mut QuotaManager, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        if (arg2 == 0) {
            return 0
        };
        assert!(0x2::table::contains<address, UserClaimableQuota>(&arg0.user_quotas, arg1), 9001);
        let v0 = 0x2::table::borrow_mut<address, UserClaimableQuota>(&mut arg0.user_quotas, arg1);
        assert!(v0.available_quota >= arg2, 9002);
        v0.total_used = v0.total_used + arg2;
        v0.available_quota = v0.available_quota - arg2;
        arg0.stats.total_quota_used = arg0.stats.total_quota_used + arg2;
        arg0.stats.total_quota_available = arg0.stats.total_quota_available - arg2;
        arg2
    }

    public(friend) fun create_quota_manager(arg0: &mut 0x2::tx_context::TxContext) : QuotaManager {
        let v0 = ClaimableQuotaStats{
            total_quota_issued    : 0,
            total_quota_used      : 0,
            total_quota_available : 0,
        };
        QuotaManager{
            id          : 0x2::object::new(arg0),
            stats       : v0,
            user_quotas : 0x2::table::new<address, UserClaimableQuota>(arg0),
        }
    }

    public(friend) fun create_quota_manager2(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimableQuotaStats{
            total_quota_issued    : 0,
            total_quota_used      : 0,
            total_quota_available : 0,
        };
        let v1 = QuotaManager{
            id          : 0x2::object::new(arg0),
            stats       : v0,
            user_quotas : 0x2::table::new<address, UserClaimableQuota>(arg0),
        };
        0x2::transfer::share_object<QuotaManager>(v1);
    }

    public fun distribute_quota_on_invest(arg0: &mut QuotaManager, arg1: address, arg2: vector<address>, arg3: u64, arg4: &0x2::clock::Clock) {
        abort 0
    }

    public fun distribute_quota_on_invest_v1(arg0: &mut QuotaManager, arg1: address, arg2: vector<address>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) {
        if (arg4) {
            add_user_quota(arg0, arg1, arg3, arg5);
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2) && v0 < 20) {
            if (v0 == 0) {
                let v1 = arg3 / 10;
                if (v1 > 0) {
                    add_user_quota(arg0, *0x1::vector::borrow<address>(&arg2, v0), v1, arg5);
                };
            } else if (v0 >= 1 && v0 < 20) {
                let v2 = arg3 / 50;
                if (v2 > 0) {
                    add_user_quota(arg0, *0x1::vector::borrow<address>(&arg2, v0), v2, arg5);
                };
            };
            v0 = v0 + 1;
        };
    }

    public fun get_global_available_quota(arg0: &QuotaManager) : u64 {
        arg0.stats.total_quota_available
    }

    public fun get_global_quota_stats(arg0: &QuotaManager) : (u64, u64, u64) {
        (arg0.stats.total_quota_issued, arg0.stats.total_quota_used, arg0.stats.total_quota_available)
    }

    public fun get_global_total_issued(arg0: &QuotaManager) : u64 {
        arg0.stats.total_quota_issued
    }

    public fun get_global_total_used(arg0: &QuotaManager) : u64 {
        arg0.stats.total_quota_used
    }

    public fun get_user_available_quota(arg0: &QuotaManager, arg1: address) : u64 {
        if (0x2::table::contains<address, UserClaimableQuota>(&arg0.user_quotas, arg1)) {
            0x2::table::borrow<address, UserClaimableQuota>(&arg0.user_quotas, arg1).available_quota
        } else {
            0
        }
    }

    public fun get_user_quota_info(arg0: &QuotaManager, arg1: address) : (u64, u64, u64) {
        if (0x2::table::contains<address, UserClaimableQuota>(&arg0.user_quotas, arg1)) {
            let v3 = 0x2::table::borrow<address, UserClaimableQuota>(&arg0.user_quotas, arg1);
            (v3.total_issued, v3.total_used, v3.available_quota)
        } else {
            (0, 0, 0)
        }
    }

    public fun get_user_total_issued(arg0: &QuotaManager, arg1: address) : u64 {
        if (0x2::table::contains<address, UserClaimableQuota>(&arg0.user_quotas, arg1)) {
            0x2::table::borrow<address, UserClaimableQuota>(&arg0.user_quotas, arg1).total_issued
        } else {
            0
        }
    }

    public fun get_user_total_used(arg0: &QuotaManager, arg1: address) : u64 {
        if (0x2::table::contains<address, UserClaimableQuota>(&arg0.user_quotas, arg1)) {
            0x2::table::borrow<address, UserClaimableQuota>(&arg0.user_quotas, arg1).total_used
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

