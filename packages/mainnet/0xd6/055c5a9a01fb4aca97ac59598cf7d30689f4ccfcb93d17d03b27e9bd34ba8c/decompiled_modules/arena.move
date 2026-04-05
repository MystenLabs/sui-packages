module 0xac38870890071543644ea81d1f5fe8000d45030c266c82c24c26eccbf0c239db::arena {
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
        prize_pool: 0x2::balance::Balance<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>,
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
        prize_agent: u64,
        timestamp: u64,
    }

    struct PrizeClaimed has copy, drop {
        round_number: u64,
        winner: address,
        amount: u64,
        timestamp: u64,
    }

    public fun claim_prize(arg0: &mut Round, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 2, 2);
        assert!(!arg0.prize_claimed, 9);
        assert!(0x1::option::is_some<address>(&arg0.winner), 11);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == *0x1::option::borrow<address>(&arg0.winner), 8);
        arg0.prize_claimed = true;
        let v1 = 0x2::balance::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg0.prize_pool);
        let v2 = v1 * 3000 / 10000;
        let v3 = PrizeClaimed{
            round_number : arg0.round_number,
            winner       : v0,
            amount       : v1 - v2,
            timestamp    : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<PrizeClaimed>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>>(0x2::coin::from_balance<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(0x2::balance::split<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&mut arg0.prize_pool, v2), arg2), @0x9e0ac3152f035e411164b24c8db59b3f0ee870340ec754ae5f074559baaa15b1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>>(0x2::coin::from_balance<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(0x2::balance::withdraw_all<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&mut arg0.prize_pool), arg2), v0);
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
            let v5 = RoundEnded{
                round_number : arg1.round_number,
                winner       : *0x1::option::borrow<address>(&arg1.winner),
                prize_agent  : 0x2::balance::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg1.prize_pool),
                timestamp    : v1,
            };
            0x2::event::emit<RoundEnded>(v5);
        };
    }

    public fun end_round(arg0: &AdminCap, arg1: &mut Round, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.state == 1, 1);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg1.end_time, 2);
        assert!(0x2::table::contains<address, AgentEntry>(&arg1.agents, arg2), 6);
        assert!(!0x2::table::borrow<address, AgentEntry>(&arg1.agents, arg2).eliminated, 7);
        arg1.state = 2;
        arg1.winner = 0x1::option::some<address>(arg2);
        let v0 = RoundEnded{
            round_number : arg1.round_number,
            winner       : arg2,
            prize_agent  : 0x2::balance::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg1.prize_pool),
            timestamp    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RoundEnded>(v0);
    }

    public fun get_active_count(arg0: &Round) : u64 {
        arg0.active_count
    }

    public fun get_end_time(arg0: &Round) : u64 {
        arg0.end_time
    }

    public fun get_prize_pool(arg0: &Round) : u64 {
        0x2::balance::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg0.prize_pool)
    }

    public fun get_round_number(arg0: &Round) : u64 {
        arg0.round_number
    }

    public fun get_start_time(arg0: &Round) : u64 {
        arg0.start_time
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

    public fun is_prize_claimed(arg0: &Round) : bool {
        arg0.prize_claimed
    }

    public fun is_registered(arg0: &Round, arg1: address) : bool {
        0x2::table::contains<address, AgentEntry>(&arg0.agents, arg1)
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
            prize_pool    : 0x2::balance::zero<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(),
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

    public fun register(arg0: &mut Round, arg1: 0x2::coin::Coin<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 0);
        assert!(0x2::coin::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg1) == 250000000000, 10);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, AgentEntry>(&arg0.agents, v0), 5);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        0x2::balance::join<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(arg1));
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

