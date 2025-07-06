module 0xf7ed71550eb29ca3fcf1d4282f2a80f9b7f6970fcb9b6203b414e8d47b4c15fb::user_reputation {
    struct UserProfile has key {
        id: 0x2::object::UID,
        owner: address,
        reputation_score: u64,
        tournaments_participated: u64,
        tournaments_won: u64,
        total_votes_cast: u64,
        staked_amount: u64,
        stake: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct UserRegistry has key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, 0x2::object::ID>,
        admin: address,
    }

    struct UserProfileCreatedEvent has copy, drop {
        user_id: 0x2::object::ID,
        owner: address,
    }

    struct StakeAddedEvent has copy, drop {
        user_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        total_staked: u64,
    }

    struct ReputationIncreasedEvent has copy, drop {
        user_id: 0x2::object::ID,
        owner: address,
        new_score: u64,
        reason: 0x1::string::String,
    }

    public fun add_stake(arg0: &mut UserProfile, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 3);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.stake, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.staked_amount = arg0.staked_amount + v0;
        let v1 = StakeAddedEvent{
            user_id      : 0x2::object::id<UserProfile>(arg0),
            owner        : arg0.owner,
            amount       : v0,
            total_staked : arg0.staked_amount,
        };
        0x2::event::emit<StakeAddedEvent>(v1);
    }

    public fun calculate_voting_power(arg0: &UserProfile) : u64 {
        arg0.reputation_score / 10 + arg0.staked_amount / 100000000
    }

    public fun create_profile(arg0: &mut UserRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.users, v0)) {
            return
        };
        let v1 = UserProfile{
            id                       : 0x2::object::new(arg1),
            owner                    : v0,
            reputation_score         : 100,
            tournaments_participated : 0,
            tournaments_won          : 0,
            total_votes_cast         : 0,
            staked_amount            : 0,
            stake                    : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v2 = 0x2::object::id<UserProfile>(&v1);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.users, v0, v2);
        let v3 = UserProfileCreatedEvent{
            user_id : v2,
            owner   : v0,
        };
        0x2::event::emit<UserProfileCreatedEvent>(v3);
        0x2::transfer::transfer<UserProfile>(v1, v0);
    }

    public fun get_profile_details(arg0: &UserProfile) : (address, u64, u64, u64, u64, u64) {
        (arg0.owner, arg0.reputation_score, arg0.tournaments_participated, arg0.tournaments_won, arg0.total_votes_cast, arg0.staked_amount)
    }

    public fun increase_reputation(arg0: &mut UserProfile, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 3);
        arg0.reputation_score = arg0.reputation_score + arg1;
        let v0 = ReputationIncreasedEvent{
            user_id   : 0x2::object::id<UserProfile>(arg0),
            owner     : arg0.owner,
            new_score : arg0.reputation_score,
            reason    : arg2,
        };
        0x2::event::emit<ReputationIncreasedEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UserRegistry{
            id    : 0x2::object::new(arg0),
            users : 0x2::table::new<address, 0x2::object::ID>(arg0),
            admin : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<UserRegistry>(v0);
    }

    public fun record_tournament_participation(arg0: &mut UserProfile, arg1: bool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 3);
        arg0.tournaments_participated = arg0.tournaments_participated + 1;
        arg0.total_votes_cast = arg0.total_votes_cast + arg2;
        if (arg1) {
            arg0.tournaments_won = arg0.tournaments_won + 1;
            increase_reputation(arg0, 50, 0x1::string::utf8(b"Tournament win"), arg3);
        } else {
            increase_reputation(arg0, 10, 0x1::string::utf8(b"Tournament participation"), arg3);
        };
    }

    public fun withdraw_stake(arg0: &mut UserProfile, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 3);
        assert!(arg0.staked_amount >= arg1, 1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.stake) >= arg1, 1);
        arg0.staked_amount = arg0.staked_amount - arg1;
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.stake, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

