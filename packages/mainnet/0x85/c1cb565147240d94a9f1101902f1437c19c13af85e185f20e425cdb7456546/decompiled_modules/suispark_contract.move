module 0x85c1cb565147240d94a9f1101902f1437c19c13af85e185f20e425cdb7456546::suispark_contract {
    struct Event has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        prize: u64,
        starting_time: u64,
        voting_period: u64,
    }

    struct Project has store, key {
        id: 0x2::object::UID,
        project_id: 0x1::string::String,
        event_id: 0x2::object::ID,
        is_private: bool,
    }

    struct Platform has store, key {
        id: 0x2::object::UID,
        projects: 0x2::vec_map::VecMap<0x2::object::ID, vector<0x2::object::ID>>,
        projects_votes: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        nft_vote_history: 0x2::vec_map::VecMap<0x2::object::ID, u8>,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        token_reserve: 0x2::balance::Balance<0x85c1cb565147240d94a9f1101902f1437c19c13af85e185f20e425cdb7456546::suispark_token::SUISPARK_TOKEN>,
        events_prize_pool: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
        allocated_prize_pool: u64,
    }

    struct EventCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        prize: u64,
        starting_time: u64,
        voting_period: u64,
    }

    public fun add_prize_pool_amount(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Platform) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.prize_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
    }

    public fun create_event(arg0: &0x85c1cb565147240d94a9f1101902f1437c19c13af85e185f20e425cdb7456546::admin::AdminCap, arg1: &mut Platform, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &mut 0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.allocated_prize_pool >= arg4, 2);
        let v0 = Event{
            id            : 0x2::object::new(arg7),
            name          : arg2,
            description   : arg3,
            prize         : arg4,
            starting_time : 0x2::clock::timestamp_ms(arg6),
            voting_period : arg5,
        };
        let v1 = EventCreatedEvent{
            id            : 0x2::object::id<Event>(&v0),
            name          : arg2,
            prize         : arg4,
            starting_time : 0x2::clock::timestamp_ms(arg6),
            voting_period : arg5,
        };
        0x2::event::emit<EventCreatedEvent>(v1);
        arg1.allocated_prize_pool = arg1.allocated_prize_pool + arg4;
        0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg1.events_prize_pool, 0x2::object::id<Event>(&v0), arg4);
        0x2::vec_map::insert<0x2::object::ID, vector<0x2::object::ID>>(&mut arg1.projects, 0x2::object::id<Event>(&v0), 0x1::vector::empty<0x2::object::ID>());
        0x2::transfer::share_object<Event>(v0);
    }

    public fun get_votes_of_project(arg0: &Platform, arg1: 0x1::string::String) : u64 {
        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.projects_votes, &arg1)) {
            *0x2::vec_map::get<0x1::string::String, u64>(&arg0.projects_votes, &arg1)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Platform{
            id                   : 0x2::object::new(arg0),
            projects             : 0x2::vec_map::empty<0x2::object::ID, vector<0x2::object::ID>>(),
            projects_votes       : 0x2::vec_map::empty<0x1::string::String, u64>(),
            nft_vote_history     : 0x2::vec_map::empty<0x2::object::ID, u8>(),
            prize_pool           : 0x2::balance::zero<0x2::sui::SUI>(),
            token_reserve        : 0x2::balance::zero<0x85c1cb565147240d94a9f1101902f1437c19c13af85e185f20e425cdb7456546::suispark_token::SUISPARK_TOKEN>(),
            events_prize_pool    : 0x2::vec_map::empty<0x2::object::ID, u64>(),
            allocated_prize_pool : 0,
        };
        0x2::transfer::share_object<Platform>(v0);
    }

    public fun is_voting_period_ended(arg0: &Event, arg1: &mut 0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) > arg0.starting_time + arg0.voting_period * 60 * 60 * 1000
    }

    public fun reward_winner(arg0: &mut 0x85c1cb565147240d94a9f1101902f1437c19c13af85e185f20e425cdb7456546::suispark_token::TreasuryCapHolder, arg1: &mut Platform, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x85c1cb565147240d94a9f1101902f1437c19c13af85e185f20e425cdb7456546::suispark_token::reward_user(arg0, arg4, 0x2::tx_context::sender(arg5), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.prize_pool, arg3), arg5), arg2);
    }

    public fun submit_project_with_loyalty_tokens(arg0: &mut Platform, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x85c1cb565147240d94a9f1101902f1437c19c13af85e185f20e425cdb7456546::suispark_token::SUISPARK_TOKEN>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x85c1cb565147240d94a9f1101902f1437c19c13af85e185f20e425cdb7456546::suispark_token::SUISPARK_TOKEN>(&arg3) == (200 as u64), 0);
        let v0 = Project{
            id         : 0x2::object::new(arg5),
            project_id : arg2,
            event_id   : arg1,
            is_private : arg4,
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::vec_map::get_mut<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.projects, &arg1), 0x2::object::id<Project>(&v0));
        0x2::transfer::public_transfer<Project>(v0, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x85c1cb565147240d94a9f1101902f1437c19c13af85e185f20e425cdb7456546::suispark_token::SUISPARK_TOKEN>>(arg3, @0xb19ea168be3908ceb7e98753833d54f76a431337f16de4fa5b9b24429e164c5);
    }

    public fun submit_project_with_sui(arg0: &mut Platform, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg0.projects, &arg1), 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == (5 as u64), 0);
        let v0 = Project{
            id         : 0x2::object::new(arg5),
            project_id : arg2,
            event_id   : arg1,
            is_private : arg4,
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::vec_map::get_mut<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.projects, &arg1), 0x2::object::id<Project>(&v0));
        0x2::transfer::public_transfer<Project>(v0, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, @0xb19ea168be3908ceb7e98753833d54f76a431337f16de4fa5b9b24429e164c5);
    }

    public fun vote_for_project(arg0: &0x85c1cb565147240d94a9f1101902f1437c19c13af85e185f20e425cdb7456546::suispark_nft::NFT, arg1: &mut 0x85c1cb565147240d94a9f1101902f1437c19c13af85e185f20e425cdb7456546::suispark_token::TreasuryCapHolder, arg2: &mut Platform, arg3: &Project, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Project>(arg3);
        let v1 = 0x1::string::utf8(0x2::object::id_to_bytes(&v0));
        let v2 = 0x2::object::id<0x85c1cb565147240d94a9f1101902f1437c19c13af85e185f20e425cdb7456546::suispark_nft::NFT>(arg0);
        assert!(arg3.is_private == false, 3);
        if (!0x2::vec_map::contains<0x2::object::ID, u8>(&arg2.nft_vote_history, &v2)) {
            0x2::vec_map::insert<0x2::object::ID, u8>(&mut arg2.nft_vote_history, v2, 0);
        };
        let v3 = 0x2::vec_map::get_mut<0x2::object::ID, u8>(&mut arg2.nft_vote_history, &v2);
        assert!(*v3 < 3, 1);
        if (!0x2::vec_map::contains<0x1::string::String, u64>(&arg2.projects_votes, &v1)) {
            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg2.projects_votes, v1, 0);
        };
        let v4 = 0x2::vec_map::get_mut<0x1::string::String, u64>(&mut arg2.projects_votes, &v1);
        *v4 = *v4 + 1;
        *v3 = *v3 + 1;
        0x85c1cb565147240d94a9f1101902f1437c19c13af85e185f20e425cdb7456546::suispark_token::reward_user(arg1, 10, 0x2::tx_context::sender(arg4), arg4);
    }

    // decompiled from Move bytecode v6
}

