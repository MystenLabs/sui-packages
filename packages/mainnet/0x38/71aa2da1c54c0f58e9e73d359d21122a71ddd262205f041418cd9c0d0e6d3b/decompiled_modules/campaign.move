module 0x3871aa2da1c54c0f58e9e73d359d21122a71ddd262205f041418cd9c0d0e6d3b::campaign {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Campaign has store, key {
        id: 0x2::object::UID,
        referrals: vector<Referral>,
        activities: vector<Activity>,
    }

    struct Referral has store, key {
        id: 0x2::object::UID,
        referrer: address,
        referee: address,
        created_at: u64,
    }

    struct ReferralDetails has copy, drop {
        referrer: address,
        referee: address,
        created_at: u64,
    }

    struct ReferralEvent has copy, drop {
        referrer: address,
        referee: address,
        created_at: u64,
    }

    struct Activity has store, key {
        id: 0x2::object::UID,
        user: address,
        loggedin_at: u64,
    }

    struct ActivityDetails has copy, drop {
        user: address,
        loggedin_at: u64,
    }

    struct LoginEvent has copy, drop {
        user: address,
        loggedin_at: u64,
    }

    public entry fun create_campaign(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Campaign{
            id         : 0x2::object::new(arg1),
            referrals  : 0x1::vector::empty<Referral>(),
            activities : 0x1::vector::empty<Activity>(),
        };
        0x2::transfer::share_object<Campaign>(v0);
    }

    public entry fun create_referral(arg0: &mut Campaign, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 != arg1, 0);
        assert!(!referral_exist(arg0, arg1, v0), 1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = Referral{
            id         : 0x2::object::new(arg3),
            referrer   : arg1,
            referee    : v0,
            created_at : v1,
        };
        0x1::vector::push_back<Referral>(&mut arg0.referrals, v2);
        let v3 = ReferralEvent{
            referrer   : arg1,
            referee    : v0,
            created_at : v1,
        };
        0x2::event::emit<ReferralEvent>(v3);
    }

    public entry fun get_all_activities(arg0: &Campaign) : vector<ActivityDetails> {
        let v0 = 0x1::vector::empty<ActivityDetails>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Activity>(&arg0.activities)) {
            let v2 = 0x1::vector::borrow<Activity>(&arg0.activities, v1);
            let v3 = ActivityDetails{
                user        : v2.user,
                loggedin_at : v2.loggedin_at,
            };
            0x1::vector::push_back<ActivityDetails>(&mut v0, v3);
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun get_all_referrals(arg0: &Campaign) : vector<ReferralDetails> {
        let v0 = 0x1::vector::empty<ReferralDetails>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Referral>(&arg0.referrals)) {
            let v2 = 0x1::vector::borrow<Referral>(&arg0.referrals, v1);
            let v3 = ReferralDetails{
                referrer   : v2.referrer,
                referee    : v2.referee,
                created_at : v2.created_at,
            };
            0x1::vector::push_back<ReferralDetails>(&mut v0, v3);
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun get_referees_by_referrer(arg0: &Campaign, arg1: address) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Referral>(&arg0.referrals)) {
            let v2 = 0x1::vector::borrow<Referral>(&arg0.referrals, v1);
            if (v2.referrer == arg1) {
                0x1::vector::push_back<address>(&mut v0, v2.referee);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun get_referrers_by_referee(arg0: &Campaign, arg1: address) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Referral>(&arg0.referrals)) {
            let v2 = 0x1::vector::borrow<Referral>(&arg0.referrals, v1);
            if (v2.referee == arg1) {
                0x1::vector::push_back<address>(&mut v0, v2.referrer);
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Campaign{
            id         : 0x2::object::new(arg0),
            referrals  : 0x1::vector::empty<Referral>(),
            activities : 0x1::vector::empty<Activity>(),
        };
        0x2::transfer::share_object<Campaign>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun log_user_activity(arg0: &mut Campaign, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = Activity{
            id          : 0x2::object::new(arg2),
            user        : v0,
            loggedin_at : 0x2::clock::timestamp_ms(arg1),
        };
        0x1::vector::push_back<Activity>(&mut arg0.activities, v1);
        let v2 = LoginEvent{
            user        : v0,
            loggedin_at : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<LoginEvent>(v2);
    }

    fun referral_exist(arg0: &Campaign, arg1: address, arg2: address) : bool {
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Referral>(&arg0.referrals)) {
            let v2 = 0x1::vector::borrow<Referral>(&arg0.referrals, v1);
            if (v2.referrer == arg1 && v2.referee == arg2) {
                v0 = true;
            };
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

