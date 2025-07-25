module 0x802352290bfc7b6f43103afad5141b526595a25e49a048f829db4fb74e08a7a6::campaign {
    struct CAMPAIGN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Campaign has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        about: 0x1::string::String,
        active: bool,
        whitelist: 0x2::table::Table<address, vector<u64>>,
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
        if (!0x2::table::contains<address, vector<u64>>(&arg1.whitelist, arg2)) {
            let v0 = if (arg3) {
                1
            } else {
                0
            };
            let v1 = 0x1::vector::empty<u64>();
            let v2 = &mut v1;
            0x1::vector::push_back<u64>(v2, v0);
            0x1::vector::push_back<u64>(v2, 0);
            0x1::vector::push_back<u64>(v2, 0);
            0x2::table::add<address, vector<u64>>(&mut arg1.whitelist, arg2, v1);
        };
    }

    public entry fun create_campaign(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        0x2::object::uid_to_inner(&v0);
        let v1 = Campaign{
            id             : v0,
            title          : arg1,
            about          : arg2,
            active         : true,
            whitelist      : 0x2::table::new<address, vector<u64>>(arg4),
            total_referees : 0x2::table::new<address, bool>(arg4),
            referrals      : 0x2::table::new<address, 0x2::table::Table<address, bool>>(arg4),
            activities     : 0x2::table::new<address, 0x2::table::Table<u64, bool>>(arg4),
            started_at     : 0x2::clock::timestamp_ms(arg3),
            ended_at       : 0x1::option::none<u64>(),
        };
        0x2::transfer::share_object<Campaign>(v1);
    }

    public entry fun create_referral(arg0: &mut Campaign, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active == true, 5);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, vector<u64>>(&arg0.whitelist, v0), 8);
        assert!(0x2::table::contains<address, vector<u64>>(&arg0.whitelist, arg1), 8);
        let v1 = 0x2::table::borrow_mut<address, vector<u64>>(&mut arg0.whitelist, v0);
        assert!(*0x1::vector::borrow<u64>(v1, 0) == 1, 8);
        assert!(v0 != arg1, 1);
        let v2 = 0;
        assert!(0x1::vector::borrow_mut<u64>(v1, 1) == &v2, 2);
        let v3 = 0x1::vector::borrow_mut<u64>(v1, 2);
        let v4 = 0;
        assert!(v3 == &v4, 3);
        *v3 = 1;
        let v5 = 0x1::vector::borrow_mut<u64>(0x2::table::borrow_mut<address, vector<u64>>(&mut arg0.whitelist, arg1), 1);
        *v5 = *v5 + 1;
        let v6 = ReferralEvent{
            referrer   : arg1,
            referee    : v0,
            created_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ReferralEvent>(v6);
    }

    public entry fun delete_campaign(arg0: &AdminCap, arg1: Campaign) {
        let Campaign {
            id             : v0,
            title          : _,
            about          : _,
            active         : _,
            whitelist      : v4,
            total_referees : v5,
            referrals      : v6,
            activities     : v7,
            started_at     : _,
            ended_at       : _,
        } = arg1;
        0x2::object::delete(v0);
        0x2::table::drop<address, vector<u64>>(v4);
        0x2::table::drop<address, bool>(v5);
        0x2::table::destroy_empty<address, 0x2::table::Table<address, bool>>(v6);
        0x2::table::destroy_empty<address, 0x2::table::Table<u64, bool>>(v7);
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

    public entry fun log_user_activity(arg0: &mut Campaign, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active == true, 5);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, vector<u64>>(&arg0.whitelist, v0), 8);
        assert!(*0x1::vector::borrow<u64>(0x2::table::borrow<address, vector<u64>>(&arg0.whitelist, v0), 0) == 1, 8);
        let v1 = LoginEvent{
            user        : v0,
            loggedin_at : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<LoginEvent>(v1);
    }

    public fun remove_whitelist(arg0: &mut Campaign, arg1: address) {
        let v0 = 0x2::table::remove<address, vector<u64>>(&mut arg0.whitelist, arg1);
        while (!0x1::vector::is_empty<u64>(&v0)) {
            0x1::vector::pop_back<u64>(&mut v0);
        };
        0x1::vector::destroy_empty<u64>(v0);
    }

    public entry fun update_permission_whitelist(arg0: &AdminCap, arg1: &mut Campaign, arg2: address, arg3: bool) {
        assert!(0x2::table::contains<address, vector<u64>>(&arg1.whitelist, arg2), 7);
        let v0 = if (arg3) {
            1
        } else {
            0
        };
        *0x1::vector::borrow_mut<u64>(0x2::table::borrow_mut<address, vector<u64>>(&mut arg1.whitelist, arg2), 0) = v0;
    }

    // decompiled from Move bytecode v6
}

