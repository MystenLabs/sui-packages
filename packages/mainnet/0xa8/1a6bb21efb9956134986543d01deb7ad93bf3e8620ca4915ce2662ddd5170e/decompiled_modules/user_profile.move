module 0xa81a6bb21efb9956134986543d01deb7ad93bf3e8620ca4915ce2662ddd5170e::user_profile {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProfileRegistry has key {
        id: 0x2::object::UID,
        total_users: u64,
        premium_users: u64,
        revenue: 0x2::balance::Balance<0x2::sui::SUI>,
        profiles: 0x2::table::Table<address, 0x2::object::ID>,
        referral_rewards: 0x2::table::Table<address, u64>,
    }

    struct UserProfile has key {
        id: 0x2::object::UID,
        address: address,
        username: 0x1::string::String,
        avatar_url: 0x1::string::String,
        bio: 0x1::string::String,
        messages_sent: u64,
        messages_received: u64,
        reputation_score: u64,
        is_premium: bool,
        premium_until: u64,
        referred_by: address,
        referral_count: u64,
        created_at: u64,
        last_active: u64,
    }

    struct PremiumReceipt has store, key {
        id: 0x2::object::UID,
        user: address,
        valid_until: u64,
        purchase_date: u64,
        amount_paid: u64,
    }

    struct ProfileCreated has copy, drop {
        user: address,
        profile_id: 0x2::object::ID,
        referred_by: address,
        created_at: u64,
    }

    struct PremiumPurchased has copy, drop {
        user: address,
        valid_until: u64,
        amount_paid: u64,
    }

    struct ReputationUpdated has copy, drop {
        user: address,
        new_score: u64,
        reason: 0x1::string::String,
    }

    public entry fun create_profile(arg0: &mut ProfileRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.profiles, v0), 1);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = UserProfile{
            id                : 0x2::object::new(arg6),
            address           : v0,
            username          : arg1,
            avatar_url        : arg2,
            bio               : arg3,
            messages_sent     : 0,
            messages_received : 0,
            reputation_score  : 100,
            is_premium        : false,
            premium_until     : 0,
            referred_by       : arg4,
            referral_count    : 0,
            created_at        : v1,
            last_active       : v1,
        };
        let v3 = 0x2::object::id<UserProfile>(&v2);
        arg0.total_users = arg0.total_users + 1;
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.profiles, v0, v3);
        if (arg4 != @0x0 && 0x2::table::contains<address, 0x2::object::ID>(&arg0.profiles, arg4)) {
            process_referral(arg0, arg4);
        };
        let v4 = ProfileCreated{
            user        : v0,
            profile_id  : v3,
            referred_by : arg4,
            created_at  : v1,
        };
        0x2::event::emit<ProfileCreated>(v4);
        0x2::transfer::transfer<UserProfile>(v2, v0);
    }

    public fun get_profile_id(arg0: &ProfileRegistry, arg1: address) : 0x2::object::ID {
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg0.profiles, arg1), 2);
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.profiles, arg1)
    }

    public fun get_profile_stats(arg0: &UserProfile) : (u64, u64, u64) {
        (arg0.messages_sent, arg0.messages_received, arg0.reputation_score)
    }

    public fun get_registry_stats(arg0: &ProfileRegistry) : (u64, u64) {
        (arg0.total_users, arg0.premium_users)
    }

    public(friend) fun increment_messages_received(arg0: &mut UserProfile) {
        arg0.messages_received = arg0.messages_received + 1;
    }

    public(friend) fun increment_messages_sent(arg0: &ProfileRegistry, arg1: &mut UserProfile) {
        arg1.messages_sent = arg1.messages_sent + 1;
        arg1.reputation_score = arg1.reputation_score + 10;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = ProfileRegistry{
            id               : 0x2::object::new(arg0),
            total_users      : 0,
            premium_users    : 0,
            revenue          : 0x2::balance::zero<0x2::sui::SUI>(),
            profiles         : 0x2::table::new<address, 0x2::object::ID>(arg0),
            referral_rewards : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<ProfileRegistry>(v1);
    }

    public fun is_premium_active(arg0: &UserProfile, arg1: &0x2::clock::Clock) : bool {
        arg0.is_premium && arg0.premium_until > 0x2::clock::timestamp_ms(arg1)
    }

    fun process_referral(arg0: &mut ProfileRegistry, arg1: address) {
        if (0x2::table::contains<address, u64>(&mut arg0.referral_rewards, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.referral_rewards, arg1);
            *v0 = *v0 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.referral_rewards, arg1, 1);
        };
    }

    public fun profile_exists(arg0: &ProfileRegistry, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.profiles, arg1)
    }

    public entry fun purchase_premium(arg0: &mut ProfileRegistry, arg1: &mut UserProfile, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1.address == v0, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 5000000000, 3);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = if (arg1.is_premium && arg1.premium_until > v1) {
            arg1.premium_until + 2592000000
        } else {
            v1 + 2592000000
        };
        arg1.is_premium = true;
        arg1.premium_until = v2;
        arg1.reputation_score = arg1.reputation_score + 50;
        if (!arg1.is_premium) {
            arg0.premium_users = arg0.premium_users + 1;
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.revenue, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v3 = PremiumReceipt{
            id            : 0x2::object::new(arg4),
            user          : v0,
            valid_until   : v2,
            purchase_date : v1,
            amount_paid   : 5000000000,
        };
        let v4 = PremiumPurchased{
            user        : v0,
            valid_until : v2,
            amount_paid : 5000000000,
        };
        0x2::event::emit<PremiumPurchased>(v4);
        0x2::transfer::transfer<PremiumReceipt>(v3, v0);
    }

    public entry fun update_profile(arg0: &mut UserProfile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.address == 0x2::tx_context::sender(arg5), 4);
        arg0.username = arg1;
        arg0.avatar_url = arg2;
        arg0.bio = arg3;
        arg0.last_active = 0x2::clock::timestamp_ms(arg4);
    }

    public entry fun withdraw_revenue(arg0: &AdminCap, arg1: &mut ProfileRegistry, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.revenue, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

