module 0x295c809ee7cb53af762d80e61f39d9a899481c7798f276456211f8c89a10ef59::campaign {
    struct CAMPAIGN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CampaignOwnerCap has store, key {
        id: 0x2::object::UID,
        campaign_id: 0x2::object::ID,
    }

    struct Campaign has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        about: 0x1::string::String,
        active: bool,
        whitelist: 0x2::table::Table<address, bool>,
        total_referees: 0x2::table::Table<address, bool>,
        referrals: 0x2::table::Table<address, 0x2::table::Table<address, bool>>,
        activities: 0x2::table::Table<address, 0x2::table::Table<u64, bool>>,
        started_at: u64,
        ended_at: 0x1::option::Option<u64>,
    }

    struct ReferralEvent has copy, drop {
        referrer: address,
        referee: address,
        created_at: u64,
    }

    struct LoginEvent has copy, drop {
        user: address,
        loggedin_at: u64,
    }

    public entry fun add_whitelist(arg0: &AdminCap, arg1: &mut Campaign, arg2: address, arg3: bool) {
        if (!0x2::table::contains<address, bool>(&arg1.whitelist, arg2)) {
            0x2::table::add<address, bool>(&mut arg1.whitelist, arg2, arg3);
        };
    }

    public entry fun create_campaign(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = Campaign{
            id             : v0,
            title          : arg1,
            about          : arg2,
            active         : true,
            whitelist      : 0x2::table::new<address, bool>(arg4),
            total_referees : 0x2::table::new<address, bool>(arg4),
            referrals      : 0x2::table::new<address, 0x2::table::Table<address, bool>>(arg4),
            activities     : 0x2::table::new<address, 0x2::table::Table<u64, bool>>(arg4),
            started_at     : 0x2::clock::timestamp_ms(arg3),
            ended_at       : 0x1::option::none<u64>(),
        };
        let v2 = CampaignOwnerCap{
            id          : 0x2::object::new(arg4),
            campaign_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::share_object<Campaign>(v1);
        0x2::transfer::share_object<CampaignOwnerCap>(v2);
    }

    public entry fun create_referral(arg0: &CampaignOwnerCap, arg1: &mut Campaign, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.active == true, 5);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.campaign_id == 0x2::object::uid_to_inner(&arg1.id), 0);
        assert!(0x2::table::contains<address, bool>(&arg1.whitelist, v0), 8);
        let v1 = true;
        assert!(0x2::table::borrow<address, bool>(&arg1.whitelist, v0) == &v1, 8);
        assert!(v0 != arg2, 1);
        assert!(!0x2::table::contains<address, 0x2::table::Table<address, bool>>(&arg1.referrals, v0), 3);
        assert!(!0x2::table::contains<address, bool>(&arg1.total_referees, v0), 4);
        if (!0x2::table::contains<address, 0x2::table::Table<address, bool>>(&arg1.referrals, arg2)) {
            let v2 = 0x2::table::new<address, bool>(arg4);
            0x2::table::add<address, bool>(&mut v2, v0, true);
            0x2::table::add<address, 0x2::table::Table<address, bool>>(&mut arg1.referrals, arg2, v2);
            0x2::table::add<address, bool>(&mut arg1.total_referees, v0, true);
        } else {
            let v3 = 0x2::table::borrow_mut<address, 0x2::table::Table<address, bool>>(&mut arg1.referrals, arg2);
            assert!(!0x2::table::contains<address, bool>(v3, v0), 2);
            0x2::table::add<address, bool>(v3, v0, true);
            0x2::table::add<address, bool>(&mut arg1.total_referees, v0, true);
        };
        let v4 = ReferralEvent{
            referrer   : arg2,
            referee    : v0,
            created_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ReferralEvent>(v4);
    }

    public entry fun end_campaign(arg0: &AdminCap, arg1: &mut Campaign, arg2: &0x2::clock::Clock) {
        assert!(arg1.active == true, 5);
        arg1.active = false;
        arg1.ended_at = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg2));
    }

    fun init(arg0: CAMPAIGN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun log_user_activity(arg0: &CampaignOwnerCap, arg1: &mut Campaign, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.campaign_id == 0x2::object::uid_to_inner(&arg1.id), 0);
        assert!(arg1.active == true, 5);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, bool>(&arg1.whitelist, v0), 8);
        let v1 = true;
        assert!(0x2::table::borrow<address, bool>(&arg1.whitelist, v0) == &v1, 8);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        if (!0x2::table::contains<address, 0x2::table::Table<u64, bool>>(&arg1.activities, v0)) {
            let v3 = 0x2::table::new<u64, bool>(arg3);
            0x2::table::add<u64, bool>(&mut v3, v2, true);
            0x2::table::add<address, 0x2::table::Table<u64, bool>>(&mut arg1.activities, v0, v3);
        } else {
            0x2::table::add<u64, bool>(0x2::table::borrow_mut<address, 0x2::table::Table<u64, bool>>(&mut arg1.activities, v0), v2, true);
        };
        let v4 = LoginEvent{
            user        : v0,
            loggedin_at : v2,
        };
        0x2::event::emit<LoginEvent>(v4);
    }

    public entry fun update_permission_whitelist(arg0: &AdminCap, arg1: &mut Campaign, arg2: address, arg3: bool) {
        assert!(0x2::table::contains<address, bool>(&arg1.whitelist, arg2), 7);
        *0x2::table::borrow_mut<address, bool>(&mut arg1.whitelist, arg2) = arg3;
    }

    // decompiled from Move bytecode v6
}

