module 0xf4f6aececb6803a88a7633a164e067812750f3328914449b83452789e2ac379d::agent {
    struct AGENT has drop {
        dummy_field: bool,
    }

    struct AgentRule has drop, store {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AgentBadge has store, key {
        id: 0x2::object::UID,
        owner: address,
        agent_id: u64,
        skill_hash: vector<u8>,
        issued_at: u64,
        expires_at: u64,
        trade_count: u64,
        is_active: bool,
    }

    struct AgentRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        agents: 0x2::table::Table<address, u64>,
        total_registered: u64,
    }

    struct TreasuryStore has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<AGENT>,
    }

    struct AgentRegistered has copy, drop {
        agent_address: address,
        agent_id: u64,
    }

    struct AgentRevoked has copy, drop {
        agent_address: address,
        agent_id: u64,
    }

    public fun update_icon_url(arg0: &TreasuryStore, arg1: &mut 0x2::coin::CoinMetadata<AGENT>, arg2: vector<u8>, arg3: &AdminCap) {
        0x2::coin::update_icon_url<AGENT>(&arg0.treasury, arg1, 0x1::ascii::string(arg2));
    }

    public fun badge_is_valid(arg0: &AgentBadge, arg1: &0x2::clock::Clock) : bool {
        arg0.is_active && 0x2::clock::timestamp_ms(arg1) < arg0.expires_at
    }

    fun init(arg0: AGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENT>(arg0, 6, b"AGENT", b"SUI AGENT", b"The first token built for AI agents to trade autonomously on Sui.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<AGENT>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        0x2::token::add_rule_for_action<AGENT, AgentRule>(&mut v6, &v5, 0x2::token::spend_action(), arg1);
        0x2::token::add_rule_for_action<AGENT, AgentRule>(&mut v6, &v5, 0x2::token::transfer_action(), arg1);
        0x2::token::share_policy<AGENT>(v6);
        0x2::transfer::public_freeze_object<0x2::token::TokenPolicyCap<AGENT>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGENT>>(v1);
        let v7 = TreasuryStore{
            id       : 0x2::object::new(arg1),
            treasury : v2,
        };
        0x2::transfer::transfer<TreasuryStore>(v7, 0x2::tx_context::sender(arg1));
        let v8 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v8, 0x2::tx_context::sender(arg1));
        let v9 = AgentRegistry{
            id               : 0x2::object::new(arg1),
            admin            : 0x2::tx_context::sender(arg1),
            agents           : 0x2::table::new<address, u64>(arg1),
            total_registered : 0,
        };
        0x2::transfer::share_object<AgentRegistry>(v9);
    }

    public fun is_registered(arg0: &AgentRegistry, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.agents, arg1)
    }

    public fun mint_supply(arg0: &mut TreasuryStore, arg1: &AdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AGENT>>(0x2::coin::mint<AGENT>(&mut arg0.treasury, arg2, arg4), arg3);
    }

    public fun register_agent(arg0: &mut AgentRegistry, arg1: &AdminCap, arg2: address, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, u64>(&arg0.agents, arg2), 5);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg0.total_registered = arg0.total_registered + 1;
        let v1 = arg0.total_registered;
        0x2::table::add<address, u64>(&mut arg0.agents, arg2, v1);
        let v2 = AgentBadge{
            id          : 0x2::object::new(arg5),
            owner       : arg2,
            agent_id    : v1,
            skill_hash  : arg3,
            issued_at   : v0,
            expires_at  : v0 + 2592000000,
            trade_count : 0,
            is_active   : true,
        };
        0x2::transfer::transfer<AgentBadge>(v2, arg2);
        let v3 = AgentRegistered{
            agent_address : arg2,
            agent_id      : v1,
        };
        0x2::event::emit<AgentRegistered>(v3);
    }

    public fun revoke_agent(arg0: &mut AgentBadge, arg1: &AdminCap) {
        arg0.is_active = false;
        let v0 = AgentRevoked{
            agent_address : arg0.owner,
            agent_id      : arg0.agent_id,
        };
        0x2::event::emit<AgentRevoked>(v0);
    }

    public fun total_agents(arg0: &AgentRegistry) : u64 {
        arg0.total_registered
    }

    public fun verify_agent(arg0: &mut AgentBadge, arg1: &mut 0x2::token::ActionRequest<AGENT>, arg2: &AgentRegistry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.owner == v0, 4);
        assert!(arg0.is_active, 2);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.expires_at, 3);
        assert!(0x2::table::contains<address, u64>(&arg2.agents, v0), 1);
        arg0.trade_count = arg0.trade_count + 1;
        let v1 = AgentRule{dummy_field: false};
        0x2::token::add_approval<AGENT, AgentRule>(v1, arg1, arg4);
    }

    // decompiled from Move bytecode v6
}

