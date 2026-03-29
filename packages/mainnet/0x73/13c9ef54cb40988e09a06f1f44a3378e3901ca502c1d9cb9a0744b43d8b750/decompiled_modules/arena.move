module 0x7313c9ef54cb40988e09a06f1f44a3378e3901ca502c1d9cb9a0744b43d8b750::arena {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Arena has key {
        id: 0x2::object::UID,
        current_round: u64,
    }

    struct AgentEntry has drop, store {
        wallet: address,
        registered_at: u64,
        eliminated: bool,
        eliminated_at: u64,
    }

    struct Round has key {
        id: 0x2::object::UID,
        round_number: u64,
        state: u8,
        agents: 0x2::table::Table<address, AgentEntry>,
        agent_list: vector<address>,
        active_count: u64,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        start_time: u64,
        end_time: u64,
        winner: 0x1::option::Option<address>,
        prize_claimed: bool,
    }

    struct RoundOpened has copy, drop {
        round_number: u64,
        timestamp: u64,
    }

    struct AgentRegistered has copy, drop {
        round_number: u64,
        wallet: address,
        agent_count: u64,
        timestamp: u64,
    }

    struct RoundStarted has copy, drop {
        round_number: u64,
        agent_count: u64,
        start_time: u64,
        end_time: u64,
    }

    struct AgentEliminated has copy, drop {
        round_number: u64,
        wallet: address,
        agents_remaining: u64,
        timestamp: u64,
    }

    struct RoundEnded has copy, drop {
        round_number: u64,
        winner: address,
        prize_sui: u64,
        timestamp: u64,
    }

    public fun claim_prize(arg0: &mut Round, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 2, 2);
        assert!(!arg0.prize_claimed, 9);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == *0x1::option::borrow<address>(&arg0.winner), 8);
        arg0.prize_claimed = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.prize_pool), arg1), v0);
    }

    public fun eliminate_agent(arg0: &AdminCap, arg1: &mut Round, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.state == 1, 1);
        assert!(0x2::table::contains<address, AgentEntry>(&arg1.agents, arg2), 6);
        let v0 = 0x2::table::borrow_mut<address, AgentEntry>(&mut arg1.agents, arg2);
        assert!(!v0.eliminated, 7);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        v0.eliminated = true;
        v0.eliminated_at = v1;
        arg1.active_count = arg1.active_count - 1;
        let v2 = AgentEliminated{
            round_number     : arg1.round_number,
            wallet           : arg2,
            agents_remaining : arg1.active_count,
            timestamp        : v1,
        };
        0x2::event::emit<AgentEliminated>(v2);
        if (arg1.active_count == 1) {
            let v3 = 0;
            while (v3 < 0x1::vector::length<address>(&arg1.agent_list)) {
                let v4 = *0x1::vector::borrow<address>(&arg1.agent_list, v3);
                if (!0x2::table::borrow<address, AgentEntry>(&arg1.agents, v4).eliminated) {
                    arg1.winner = 0x1::option::some<address>(v4);
                    break
                };
                v3 = v3 + 1;
            };
            arg1.state = 2;
        };
    }

    public fun end_round(arg0: &AdminCap, arg1: &mut Round, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.state == 1, 1);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.end_time, 2);
        arg1.state = 2;
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1.agent_list)) {
            let v1 = *0x1::vector::borrow<address>(&arg1.agent_list, v0);
            if (!0x2::table::borrow<address, AgentEntry>(&arg1.agents, v1).eliminated) {
                arg1.winner = 0x1::option::some<address>(v1);
                break
            };
            v0 = v0 + 1;
        };
        let v2 = RoundEnded{
            round_number : arg1.round_number,
            winner       : *0x1::option::borrow<address>(&arg1.winner),
            prize_sui    : 0x2::balance::value<0x2::sui::SUI>(&arg1.prize_pool),
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RoundEnded>(v2);
    }

    public fun get_active_count(arg0: &Round) : u64 {
        arg0.active_count
    }

    public fun get_end_time(arg0: &Round) : u64 {
        arg0.end_time
    }

    public fun get_prize_pool(arg0: &Round) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool)
    }

    public fun get_state(arg0: &Round) : u8 {
        arg0.state
    }

    public fun get_winner(arg0: &Round) : 0x1::option::Option<address> {
        arg0.winner
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Arena{
            id            : 0x2::object::new(arg0),
            current_round : 0,
        };
        0x2::transfer::share_object<Arena>(v1);
    }

    public fun is_eliminated(arg0: &Round, arg1: address) : bool {
        if (!0x2::table::contains<address, AgentEntry>(&arg0.agents, arg1)) {
            return true
        };
        0x2::table::borrow<address, AgentEntry>(&arg0.agents, arg1).eliminated
    }

    public fun open_round(arg0: &AdminCap, arg1: &mut Arena, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.current_round = arg1.current_round + 1;
        let v0 = Round{
            id            : 0x2::object::new(arg3),
            round_number  : arg1.current_round,
            state         : 0,
            agents        : 0x2::table::new<address, AgentEntry>(arg3),
            agent_list    : 0x1::vector::empty<address>(),
            active_count  : 0,
            prize_pool    : 0x2::balance::zero<0x2::sui::SUI>(),
            start_time    : 0,
            end_time      : 0,
            winner        : 0x1::option::none<address>(),
            prize_claimed : false,
        };
        let v1 = RoundOpened{
            round_number : arg1.current_round,
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RoundOpened>(v1);
        0x2::transfer::share_object<Round>(v0);
    }

    public fun register(arg0: &mut Round, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, AgentEntry>(&arg0.agents, v0), 5);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v2 = AgentEntry{
            wallet        : v0,
            registered_at : v1,
            eliminated    : false,
            eliminated_at : 0,
        };
        0x2::table::add<address, AgentEntry>(&mut arg0.agents, v0, v2);
        0x1::vector::push_back<address>(&mut arg0.agent_list, v0);
        arg0.active_count = arg0.active_count + 1;
        let v3 = AgentRegistered{
            round_number : arg0.round_number,
            wallet       : v0,
            agent_count  : arg0.active_count,
            timestamp    : v1,
        };
        0x2::event::emit<AgentRegistered>(v3);
    }

    public fun start_round(arg0: &AdminCap, arg1: &mut Round, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.state == 0, 3);
        assert!(arg1.active_count >= 10, 4);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg1.state = 1;
        arg1.start_time = v0;
        arg1.end_time = v0 + 3600000;
        let v1 = RoundStarted{
            round_number : arg1.round_number,
            agent_count  : arg1.active_count,
            start_time   : v0,
            end_time     : arg1.end_time,
        };
        0x2::event::emit<RoundStarted>(v1);
    }

    // decompiled from Move bytecode v6
}

