module 0x664a0e25093ade2eb071799f7b24a821a5eeb6f355986f6bc15c582b60d0c6a0::proposal_quota_registry {
    struct QuotaEntry has copy, drop, store {
        user: address,
        info: QuotaInfo,
    }

    struct QuotaInfo has copy, drop, store {
        period_ms: u64,
        feeless_proposal_amount: u64,
        feeless_proposal_used: u64,
        feeless_proposal_period_start_ms: u64,
        sponsor_amount: u64,
        sponsor_used: u64,
        sponsor_period_start_ms: u64,
        sponsor_consumed_proposals: vector<0x2::object::ID>,
    }

    struct ProposalQuotaRegistry has copy, drop, store {
        quotas: vector<QuotaEntry>,
    }

    struct QuotasSet has copy, drop {
        dao_id: 0x2::object::ID,
        users: vector<address>,
        period_ms: u64,
        feeless_proposal_amount: u64,
        sponsor_amount: u64,
        timestamp: u64,
    }

    struct QuotasRemoved has copy, drop {
        dao_id: 0x2::object::ID,
        users: vector<address>,
        timestamp: u64,
    }

    struct FeelessQuotaUsed has copy, drop {
        dao_id: 0x2::object::ID,
        user: address,
        remaining: u64,
        timestamp: u64,
    }

    struct SponsorQuotaUsed has copy, drop {
        dao_id: 0x2::object::ID,
        sponsor: address,
        proposal_id: 0x2::object::ID,
        remaining: u64,
        timestamp: u64,
    }

    public fun check_feeless_quota_available(arg0: &ProposalQuotaRegistry, arg1: address, arg2: &0x2::clock::Clock) : bool {
        let (v0, v1) = find_user_index(&arg0.quotas, arg1);
        if (!v0) {
            return false
        };
        let v2 = &0x1::vector::borrow<QuotaEntry>(&arg0.quotas, v1).info;
        if (v2.feeless_proposal_amount == 0) {
            return false
        };
        let v3 = if (elapsed_periods(0x2::clock::timestamp_ms(arg2), v2.feeless_proposal_period_start_ms, v2.period_ms) > 0) {
            0
        } else {
            v2.feeless_proposal_used
        };
        v3 < v2.feeless_proposal_amount
    }

    public fun check_sponsor_quota_available(arg0: &ProposalQuotaRegistry, arg1: address, arg2: &0x2::clock::Clock) : (bool, u64) {
        let (v0, v1) = find_user_index(&arg0.quotas, arg1);
        if (!v0) {
            return (false, 0)
        };
        let v2 = &0x1::vector::borrow<QuotaEntry>(&arg0.quotas, v1).info;
        if (v2.sponsor_amount == 0) {
            return (false, 0)
        };
        let v3 = if (elapsed_periods(0x2::clock::timestamp_ms(arg2), v2.sponsor_period_start_ms, v2.period_ms) > 0) {
            0
        } else {
            v2.sponsor_used
        };
        let v4 = quota_remaining(v2.sponsor_amount, v3);
        (v4 > 0, v4)
    }

    fun elapsed_periods(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            0
        } else if (arg0 >= arg1) {
            (arg0 - arg1) / arg2
        } else {
            0
        }
    }

    public fun feeless_proposal_amount(arg0: &QuotaInfo) : u64 {
        arg0.feeless_proposal_amount
    }

    public fun feeless_proposal_period_start_ms(arg0: &QuotaInfo) : u64 {
        arg0.feeless_proposal_period_start_ms
    }

    public fun feeless_proposal_used(arg0: &QuotaInfo) : u64 {
        arg0.feeless_proposal_used
    }

    fun find_user_index(arg0: &vector<QuotaEntry>, arg1: address) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<QuotaEntry>(arg0)) {
            if (0x1::vector::borrow<QuotaEntry>(arg0, v0).user == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun get_feeless_quota_status(arg0: &ProposalQuotaRegistry, arg1: address, arg2: &0x2::clock::Clock) : (bool, u64) {
        let (v0, v1) = find_user_index(&arg0.quotas, arg1);
        if (!v0) {
            return (false, 0)
        };
        let v2 = &0x1::vector::borrow<QuotaEntry>(&arg0.quotas, v1).info;
        if (v2.feeless_proposal_amount == 0) {
            return (false, 0)
        };
        let v3 = if (elapsed_periods(0x2::clock::timestamp_ms(arg2), v2.feeless_proposal_period_start_ms, v2.period_ms) > 0) {
            0
        } else {
            v2.feeless_proposal_used
        };
        let v4 = quota_remaining(v2.feeless_proposal_amount, v3);
        (v4 > 0, v4)
    }

    public fun has_quota(arg0: &ProposalQuotaRegistry, arg1: address) : bool {
        let (v0, _) = find_user_index(&arg0.quotas, arg1);
        v0
    }

    public fun new() : ProposalQuotaRegistry {
        ProposalQuotaRegistry{quotas: 0x1::vector::empty<QuotaEntry>()}
    }

    public fun period_ms(arg0: &QuotaInfo) : u64 {
        arg0.period_ms
    }

    fun quota_remaining(arg0: u64, arg1: u64) : u64 {
        if (arg1 >= arg0) {
            0
        } else {
            arg0 - arg1
        }
    }

    public fun set_quotas(arg0: &mut ProposalQuotaRegistry, arg1: 0x2::object::ID, arg2: vector<address>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        let v0 = arg4 == 0 && arg5 == 0;
        if (!v0) {
            assert!(arg3 > 0, 0);
            assert!(arg5 <= 256, 6);
        };
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg2)) {
            let v3 = *0x1::vector::borrow<address>(&arg2, v2);
            if (v0) {
                let (v4, v5) = find_user_index(&arg0.quotas, v3);
                if (v4) {
                    0x1::vector::remove<QuotaEntry>(&mut arg0.quotas, v5);
                };
            } else {
                let v6 = QuotaInfo{
                    period_ms                        : arg3,
                    feeless_proposal_amount          : arg4,
                    feeless_proposal_used            : 0,
                    feeless_proposal_period_start_ms : v1,
                    sponsor_amount                   : arg5,
                    sponsor_used                     : 0,
                    sponsor_period_start_ms          : v1,
                    sponsor_consumed_proposals       : 0x1::vector::empty<0x2::object::ID>(),
                };
                let (v7, v8) = find_user_index(&arg0.quotas, v3);
                if (v7) {
                    let v9 = 0x1::vector::borrow_mut<QuotaEntry>(&mut arg0.quotas, v8);
                    let v10 = v9.info;
                    if (v10.period_ms == arg3) {
                        let v11 = elapsed_periods(v1, v10.feeless_proposal_period_start_ms, v10.period_ms);
                        let v12 = elapsed_periods(v1, v10.sponsor_period_start_ms, v10.period_ms);
                        let v13 = if (v11 > 0) {
                            v10.feeless_proposal_period_start_ms + v11 * v10.period_ms
                        } else {
                            v10.feeless_proposal_period_start_ms
                        };
                        let v14 = if (v12 > 0) {
                            v10.sponsor_period_start_ms + v12 * v10.period_ms
                        } else {
                            v10.sponsor_period_start_ms
                        };
                        let v15 = if (v11 > 0) {
                            0
                        } else {
                            v10.feeless_proposal_used
                        };
                        let v16 = if (v12 > 0) {
                            0
                        } else {
                            v10.sponsor_used
                        };
                        let v17 = if (v12 > 0) {
                            0x1::vector::empty<0x2::object::ID>()
                        } else {
                            v10.sponsor_consumed_proposals
                        };
                        let v18 = QuotaInfo{
                            period_ms                        : arg3,
                            feeless_proposal_amount          : arg4,
                            feeless_proposal_used            : v15,
                            feeless_proposal_period_start_ms : v13,
                            sponsor_amount                   : arg5,
                            sponsor_used                     : v16,
                            sponsor_period_start_ms          : v14,
                            sponsor_consumed_proposals       : v17,
                        };
                        v9.info = v18;
                    } else {
                        v9.info = v6;
                    };
                } else {
                    assert!(0x1::vector::length<QuotaEntry>(&arg0.quotas) < 0x5d369bb8a96e9d5d3e9ed434f5d1ba3de449ce392dc574d23b86791e08ee2129::constants::max_quota_entries(), 1);
                    let v19 = QuotaEntry{
                        user : v3,
                        info : v6,
                    };
                    0x1::vector::push_back<QuotaEntry>(&mut arg0.quotas, v19);
                };
            };
            v2 = v2 + 1;
        };
        if (v0) {
            let v20 = QuotasRemoved{
                dao_id    : arg1,
                users     : arg2,
                timestamp : v1,
            };
            0x2::event::emit<QuotasRemoved>(v20);
        } else {
            let v21 = QuotasSet{
                dao_id                  : arg1,
                users                   : arg2,
                period_ms               : arg3,
                feeless_proposal_amount : arg4,
                sponsor_amount          : arg5,
                timestamp               : v1,
            };
            0x2::event::emit<QuotasSet>(v21);
        };
    }

    public fun sponsor_amount(arg0: &QuotaInfo) : u64 {
        arg0.sponsor_amount
    }

    public fun sponsor_consumed_proposals(arg0: &QuotaInfo) : &vector<0x2::object::ID> {
        &arg0.sponsor_consumed_proposals
    }

    public fun sponsor_period_start_ms(arg0: &QuotaInfo) : u64 {
        arg0.sponsor_period_start_ms
    }

    public fun sponsor_used(arg0: &QuotaInfo) : u64 {
        arg0.sponsor_used
    }

    public fun use_feeless_quota(arg0: &mut ProposalQuotaRegistry, arg1: 0x2::object::ID, arg2: address, arg3: &0x2::clock::Clock) {
        let (v0, v1) = find_user_index(&arg0.quotas, arg2);
        assert!(v0, 2);
        let v2 = &mut 0x1::vector::borrow_mut<QuotaEntry>(&mut arg0.quotas, v1).info;
        assert!(v2.feeless_proposal_amount > 0, 0);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = elapsed_periods(v3, v2.feeless_proposal_period_start_ms, v2.period_ms);
        if (v4 > 0) {
            v2.feeless_proposal_period_start_ms = v2.feeless_proposal_period_start_ms + v4 * v2.period_ms;
            v2.feeless_proposal_used = 0;
        };
        assert!(v2.feeless_proposal_used < v2.feeless_proposal_amount, 3);
        v2.feeless_proposal_used = v2.feeless_proposal_used + 1;
        let v5 = FeelessQuotaUsed{
            dao_id    : arg1,
            user      : arg2,
            remaining : v2.feeless_proposal_amount - v2.feeless_proposal_used,
            timestamp : v3,
        };
        0x2::event::emit<FeelessQuotaUsed>(v5);
    }

    public fun use_sponsor_quota(arg0: &mut ProposalQuotaRegistry, arg1: 0x2::object::ID, arg2: address, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        let (v0, v1) = find_user_index(&arg0.quotas, arg2);
        assert!(v0, 2);
        let v2 = &mut 0x1::vector::borrow_mut<QuotaEntry>(&mut arg0.quotas, v1).info;
        assert!(v2.sponsor_amount > 0, 0);
        let v3 = 0x2::clock::timestamp_ms(arg4);
        let v4 = elapsed_periods(v3, v2.sponsor_period_start_ms, v2.period_ms);
        if (v4 > 0) {
            v2.sponsor_period_start_ms = v2.sponsor_period_start_ms + v4 * v2.period_ms;
            v2.sponsor_used = 0;
            v2.sponsor_consumed_proposals = 0x1::vector::empty<0x2::object::ID>();
        };
        assert!(v2.sponsor_used < v2.sponsor_amount, 3);
        v2.sponsor_used = v2.sponsor_used + 1;
        0x1::vector::push_back<0x2::object::ID>(&mut v2.sponsor_consumed_proposals, arg3);
        let v5 = SponsorQuotaUsed{
            dao_id      : arg1,
            sponsor     : arg2,
            proposal_id : arg3,
            remaining   : v2.sponsor_amount - v2.sponsor_used,
            timestamp   : v3,
        };
        0x2::event::emit<SponsorQuotaUsed>(v5);
    }

    // decompiled from Move bytecode v6
}

