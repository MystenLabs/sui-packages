module 0x6a8c081d53472a4f4695d9f1e966d37a33f444e0a09859ae1011dcfca352c2e5::TalentumDaily {
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
        fee_amount: u64,
        fee_recipient: address,
        owner: address,
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

    struct FeeConfigUpdateEvent has copy, drop {
        fee_amount: u64,
        fee_recipient: address,
        timestamp: u64,
    }

    struct FeeCollectedEvent has copy, drop {
        user: address,
        fee_amount: u64,
        recipient: address,
        timestamp: u64,
    }

    public entry fun create_user_streak(arg0: &mut GlobalStats, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = get_user_streak_id(v0);
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v1), 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.fee_amount, 5);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        let v3 = UserStreak{
            id                : 0x2::object::new(arg3),
            owner             : v0,
            streak_count      : 1,
            last_refresh_time : v2,
        };
        0x2::dynamic_field::add<vector<u8>, bool>(&mut arg0.id, v1, true);
        0x2::transfer::transfer<UserStreak>(v3, v0);
        arg0.total_users = arg0.total_users + 1;
        arg0.total_refreshes = arg0.total_refreshes + 1;
        if (arg0.fee_amount > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg0.fee_amount, arg3), arg0.fee_recipient);
            let v4 = FeeCollectedEvent{
                user       : v0,
                fee_amount : arg0.fee_amount,
                recipient  : arg0.fee_recipient,
                timestamp  : v2,
            };
            0x2::event::emit<FeeCollectedEvent>(v4);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v5 = NewUserEvent{
            user      : v0,
            timestamp : v2,
        };
        0x2::event::emit<NewUserEvent>(v5);
    }

    public fun get_fee_amount(arg0: &GlobalStats) : u64 {
        arg0.fee_amount
    }

    public fun get_fee_recipient(arg0: &GlobalStats) : address {
        arg0.fee_recipient
    }

    public fun get_owner(arg0: &GlobalStats) : address {
        arg0.owner
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
            fee_amount      : 100000000,
            fee_recipient   : 0x2::tx_context::sender(arg0),
            owner           : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<GlobalStats>(v0);
    }

    public entry fun refresh_streak(arg0: &mut GlobalStats, arg1: &mut UserStreak, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1.owner == v0, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg0.fee_amount, 5);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (v1 > arg1.last_refresh_time + 172800000) {
            arg1.streak_count = 1;
        } else {
            assert!(v1 >= arg1.last_refresh_time + 86400000, 1);
            arg1.streak_count = arg1.streak_count + 1;
        };
        arg1.last_refresh_time = v1;
        arg0.total_refreshes = arg0.total_refreshes + 1;
        if (arg0.fee_amount > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, arg0.fee_amount, arg4), arg0.fee_recipient);
            let v2 = FeeCollectedEvent{
                user       : v0,
                fee_amount : arg0.fee_amount,
                recipient  : arg0.fee_recipient,
                timestamp  : v1,
            };
            0x2::event::emit<FeeCollectedEvent>(v2);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        let v3 = StreakUpdateEvent{
            user         : v0,
            streak_count : arg1.streak_count,
            timestamp    : v1,
        };
        0x2::event::emit<StreakUpdateEvent>(v3);
    }

    public entry fun transfer_ownership(arg0: &mut GlobalStats, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        arg0.owner = arg1;
    }

    public entry fun update_fee_config(arg0: &mut GlobalStats, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 4);
        arg0.fee_amount = arg1;
        arg0.fee_recipient = arg2;
        let v0 = FeeConfigUpdateEvent{
            fee_amount    : arg1,
            fee_recipient : arg2,
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FeeConfigUpdateEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

