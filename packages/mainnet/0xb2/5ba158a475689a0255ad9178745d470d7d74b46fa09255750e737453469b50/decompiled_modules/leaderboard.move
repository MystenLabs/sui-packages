module 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::leaderboard {
    struct Record has copy, drop, store {
        value: u64,
        account: address,
    }

    struct Leaderboard has store {
        scores: vector<Record>,
    }

    struct ReferralRecord has copy, drop, store {
        revenue: u64,
        referrals: u64,
        account: address,
    }

    struct ReferralLeaderboard has store {
        scores: vector<ReferralRecord>,
        top_users: 0x2::table::Table<address, bool>,
    }

    public(friend) fun empty() : Leaderboard {
        Leaderboard{scores: 0x1::vector::empty<Record>()}
    }

    public(friend) fun account(arg0: &Record) : address {
        arg0.account
    }

    public(friend) fun add_referral_score(arg0: &mut ReferralLeaderboard, arg1: u64, arg2: u64, arg3: address) {
        remove_referral_score(arg0, arg3);
        let v0 = &mut arg0.scores;
        let v1 = ReferralRecord{
            revenue   : arg1,
            referrals : arg2,
            account   : arg3,
        };
        if (0x1::vector::length<ReferralRecord>(v0) < 1000) {
            0x1::vector::insert<ReferralRecord>(v0, v1, find_referral_insertion_index(v0, arg1));
            0x2::table::add<address, bool>(&mut arg0.top_users, arg3, true);
        } else {
            let v2 = 0;
            let v3 = *0x1::vector::borrow<ReferralRecord>(v0, v2);
            if (arg1 > v3.revenue) {
                0x1::vector::remove<ReferralRecord>(v0, v2);
                0x2::table::remove<address, bool>(&mut arg0.top_users, v3.account);
                0x1::vector::insert<ReferralRecord>(v0, v1, find_referral_insertion_index(v0, arg1));
                0x2::table::add<address, bool>(&mut arg0.top_users, arg3, true);
            };
        };
    }

    public(friend) fun add_score(arg0: &mut Leaderboard, arg1: u64, arg2: address) {
        let v0 = &mut arg0.scores;
        let v1 = Record{
            value   : arg1,
            account : arg2,
        };
        insert_leaderboard(v0, v1);
    }

    public(friend) fun empty_referral(arg0: &mut 0x2::tx_context::TxContext) : ReferralLeaderboard {
        ReferralLeaderboard{
            scores    : 0x1::vector::empty<ReferralRecord>(),
            top_users : 0x2::table::new<address, bool>(arg0),
        }
    }

    fun find_insertion_index(arg0: &vector<Record>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<Record>(arg0);
        while (v0 < v1) {
            v1 = v0 + (v1 - v0) / 2;
            let v2 = *0x1::vector::borrow<Record>(arg0, v1);
            if (v2.value < arg1) {
                v0 = v1 + 1;
                continue
            };
        };
        v0
    }

    fun find_record_index(arg0: &vector<Record>, arg1: Record) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Record>(arg0)) {
            if (0x1::vector::borrow<Record>(arg0, v0).account == arg1.account) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    fun find_referral_insertion_index(arg0: &vector<ReferralRecord>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<ReferralRecord>(arg0);
        while (v0 < v1) {
            v1 = v0 + (v1 - v0) / 2;
            let v2 = *0x1::vector::borrow<ReferralRecord>(arg0, v1);
            if (v2.revenue < arg1) {
                v0 = v1 + 1;
                continue
            };
        };
        v0
    }

    public(friend) fun get_leaderboard(arg0: &Leaderboard) : &vector<Record> {
        &arg0.scores
    }

    public(friend) fun get_paged_leaderboard(arg0: &Leaderboard, arg1: u64, arg2: u64) : (vector<Record>, u64) {
        let v0 = 0x1::vector::length<Record>(&arg0.scores);
        let v1 = v0 / arg2;
        let v2 = v1;
        if (v0 % arg2 > 0) {
            v2 = v1 + 1;
        };
        let v3 = 0x1::vector::empty<Record>();
        if (arg1 == 0) {
            return (v3, v2)
        };
        let v4 = (arg1 - 1) * arg2;
        if (v4 >= v0) {
            return (v3, v2)
        };
        let v5 = 0;
        let v6 = v0 - v4;
        while (v5 < arg2 && v6 > 0) {
            v6 = v6 - 1;
            0x1::vector::push_back<Record>(&mut v3, *0x1::vector::borrow<Record>(&arg0.scores, v6));
            v5 = v5 + 1;
        };
        (v3, v2)
    }

    public(friend) fun get_paged_referral_leaderboard(arg0: &ReferralLeaderboard, arg1: u64, arg2: u64) : (vector<ReferralRecord>, u64) {
        let v0 = 0x1::vector::length<ReferralRecord>(&arg0.scores);
        let v1 = v0 / arg2;
        let v2 = v1;
        if (v0 % arg2 > 0) {
            v2 = v1 + 1;
        };
        let v3 = 0x1::vector::empty<ReferralRecord>();
        if (arg1 == 0) {
            return (v3, v2)
        };
        let v4 = (arg1 - 1) * arg2;
        if (v4 >= v0) {
            return (v3, v2)
        };
        let v5 = 0;
        let v6 = v0 - v4;
        while (v5 < arg2 && v6 > 0) {
            v6 = v6 - 1;
            0x1::vector::push_back<ReferralRecord>(&mut v3, *0x1::vector::borrow<ReferralRecord>(&arg0.scores, v6));
            v5 = v5 + 1;
        };
        (v3, v2)
    }

    public(friend) fun get_referral_rank(arg0: &ReferralLeaderboard, arg1: address) : (u64, u64, u64) {
        if (!0x2::table::contains<address, bool>(&arg0.top_users, arg1)) {
            return (0, 0, 0)
        };
        let v0 = 0x1::vector::length<ReferralRecord>(&arg0.scores);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<ReferralRecord>(&arg0.scores, v1);
            if (v2.account == arg1) {
                return (v0 - v1, v2.revenue, v2.referrals)
            };
            v1 = v1 + 1;
        };
        (0, 0, 0)
    }

    fun insert_leaderboard(arg0: &mut vector<Record>, arg1: Record) {
        if (0x1::vector::length<Record>(arg0) < 1000) {
            0x1::vector::insert<Record>(arg0, arg1, find_insertion_index(arg0, arg1.value));
        } else {
            let v0 = 0;
            let v1 = *0x1::vector::borrow<Record>(arg0, v0);
            if (arg1.value > v1.value) {
                0x1::vector::remove<Record>(arg0, v0);
                0x1::vector::insert<Record>(arg0, arg1, find_insertion_index(arg0, arg1.value));
            };
        };
    }

    fun remove_leaderboard(arg0: &mut vector<Record>, arg1: Record) : bool {
        let v0 = find_record_index(arg0, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            0x1::vector::remove<Record>(arg0, 0x1::option::extract<u64>(&mut v0));
            true
        } else {
            false
        }
    }

    public(friend) fun remove_referral_score(arg0: &mut ReferralLeaderboard, arg1: address) : bool {
        if (!0x2::table::contains<address, bool>(&arg0.top_users, arg1)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<ReferralRecord>(&arg0.scores)) {
            if (0x1::vector::borrow<ReferralRecord>(&arg0.scores, v0).account == arg1) {
                0x1::vector::remove<ReferralRecord>(&mut arg0.scores, v0);
                0x2::table::remove<address, bool>(&mut arg0.top_users, arg1);
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public(friend) fun remove_score(arg0: &mut Leaderboard, arg1: u64, arg2: address) : bool {
        let v0 = &mut arg0.scores;
        let v1 = Record{
            value   : arg1,
            account : arg2,
        };
        remove_leaderboard(v0, v1)
    }

    // decompiled from Move bytecode v7
}

