module 0x685a05ebfbdef6164b5ff89dbdc80528bbc13e6c907c8e8ebf4a5718a7d2da00::TalentumDaily {
    struct UserStreak has key {
        id: 0x2::object::UID,
        owner: address,
        streak_count: u64,
        last_refresh_time: u64,
    }

    struct GlobalStats has key {
        id: 0x2::object::UID,
        total_users: u64,
        total_refreshes: u64,
    }

    struct StreakUpdateEvent has copy, drop {
        user: address,
        streak_count: u64,
        timestamp: u64,
    }

    struct NewUserEvent has copy, drop {
        user: address,
        timestamp: u64,
    }

    public entry fun create_user_streak(arg0: &mut GlobalStats, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = get_user_streak_id(v0);
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v1), 3);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        let v3 = UserStreak{
            id                : 0x2::object::new(arg2),
            owner             : v0,
            streak_count      : 1,
            last_refresh_time : v2,
        };
        0x2::dynamic_field::add<vector<u8>, bool>(&mut arg0.id, v1, true);
        0x2::transfer::transfer<UserStreak>(v3, v0);
        arg0.total_users = arg0.total_users + 1;
        arg0.total_refreshes = arg0.total_refreshes + 1;
        let v4 = NewUserEvent{
            user      : v0,
            timestamp : v2,
        };
        0x2::event::emit<NewUserEvent>(v4);
    }

    public fun get_user_streak_id(arg0: address) : vector<u8> {
        let v0 = 0x1::bcs::to_bytes<address>(&arg0);
        0x1::vector::append<u8>(&mut v0, b"user_streak");
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalStats{
            id              : 0x2::object::new(arg0),
            total_users     : 0,
            total_refreshes : 0,
        };
        0x2::transfer::share_object<GlobalStats>(v0);
    }

    public entry fun refresh_streak(arg0: &mut GlobalStats, arg1: &mut UserStreak, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.owner == v0, 2);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (v1 > arg1.last_refresh_time + 172800000) {
            arg1.streak_count = 1;
        } else {
            assert!(v1 >= arg1.last_refresh_time + 86400000, 1);
            arg1.streak_count = arg1.streak_count + 1;
        };
        arg1.last_refresh_time = v1;
        arg0.total_refreshes = arg0.total_refreshes + 1;
        let v2 = StreakUpdateEvent{
            user         : v0,
            streak_count : arg1.streak_count,
            timestamp    : v1,
        };
        0x2::event::emit<StreakUpdateEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

