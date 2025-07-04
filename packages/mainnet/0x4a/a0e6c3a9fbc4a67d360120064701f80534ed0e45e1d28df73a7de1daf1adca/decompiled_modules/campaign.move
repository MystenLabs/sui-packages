module 0x4aa0e6c3a9fbc4a67d360120064701f80534ed0e45e1d28df73a7de1daf1adca::campaign {
    struct CAMPAIGN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Campaign has store, key {
        id: 0x2::object::UID,
        admin: address,
        title: 0x1::string::String,
        about: 0x1::string::String,
        active: bool,
        started_at: u64,
        ended_at: 0x1::option::Option<u64>,
    }

    struct UserWhitelist has store, key {
        id: 0x2::object::UID,
        user: address,
        permission: bool,
        referees_count: u64,
        is_referee: bool,
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

    public entry fun add_whitelist(arg0: &Campaign, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 100);
        let v0 = UserWhitelist{
            id             : 0x2::object::new(arg3),
            user           : arg1,
            permission     : arg2,
            referees_count : 0,
            is_referee     : false,
        };
        0x2::transfer::share_object<UserWhitelist>(v0);
    }

    public entry fun create_campaign(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Campaign{
            id         : 0x2::object::new(arg4),
            admin      : 0x2::tx_context::sender(arg4),
            title      : arg1,
            about      : arg2,
            active     : true,
            started_at : 0x2::clock::timestamp_ms(arg3),
            ended_at   : 0x1::option::none<u64>(),
        };
        0x2::transfer::share_object<Campaign>(v0);
    }

    public entry fun create_referral(arg0: &Campaign, arg1: &mut UserWhitelist, arg2: &mut UserWhitelist, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active == true, 5);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1.user == v0, 7);
        assert!(arg1.permission == true, 8);
        assert!(arg2.permission == true, 8);
        assert!(v0 != arg2.user, 1);
        assert!(arg1.referees_count == 0, 2);
        assert!(arg1.is_referee == false, 3);
        arg1.is_referee = true;
        arg2.referees_count = arg2.referees_count + 1;
        let v1 = ReferralEvent{
            referrer   : arg2.user,
            referee    : v0,
            created_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ReferralEvent>(v1);
    }

    public entry fun delete_campaign(arg0: &AdminCap, arg1: Campaign, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg2), 100);
        let Campaign {
            id         : v0,
            admin      : _,
            title      : _,
            about      : _,
            active     : _,
            started_at : _,
            ended_at   : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public entry fun end_campaign(arg0: &AdminCap, arg1: &mut Campaign, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg3), 100);
        assert!(arg1.active == true, 5);
        arg1.active = false;
        arg1.ended_at = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg2));
    }

    fun init(arg0: CAMPAIGN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<AdminCap>(v0);
    }

    public entry fun log_user_activity(arg0: &Campaign, arg1: &UserWhitelist, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active == true, 5);
        assert!(arg1.permission == true, 8);
        assert!(arg1.user == 0x2::tx_context::sender(arg3), 7);
        let v0 = LoginEvent{
            user        : arg1.user,
            loggedin_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<LoginEvent>(v0);
    }

    public entry fun remove_whitelist(arg0: UserWhitelist) {
        let UserWhitelist {
            id             : v0,
            user           : _,
            permission     : _,
            referees_count : _,
            is_referee     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun update_permission_whitelist(arg0: &Campaign, arg1: &mut UserWhitelist, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 100);
        arg1.permission = arg2;
    }

    // decompiled from Move bytecode v6
}

