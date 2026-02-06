module 0x88b83f36dafcd5f6dcdcf1d2cb5889b03f61264ab3cee9cae35db7aa940a21b7::sentinel {
    struct Agent has store, key {
        id: 0x2::object::UID,
        agent_id: 0x1::string::String,
        cost_per_message: u64,
        system_prompt: 0x1::string::String,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        accumulated_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        last_funded_timestamp: u64,
        created_at: u64,
    }

    struct AgentInfo has copy, drop {
        agent_id: 0x1::string::String,
        cost_per_message: u64,
        system_prompt: 0x1::string::String,
        object_id: 0x2::object::ID,
        balance: u64,
        accumulated_fees: u64,
    }

    struct AgentRegistry has key {
        id: 0x2::object::UID,
        agents: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        agent_count: u64,
    }

    struct ProtocolConfig has key {
        id: 0x2::object::UID,
        protocol_wallet: address,
        agent_balance_fee: u64,
        creator_fee: u64,
        protocol_fee: u64,
        admin: address,
        canonical_enclave_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct SENTINEL has drop {
        dummy_field: bool,
    }

    struct AgentCap has store, key {
        id: 0x2::object::UID,
        agent_id: 0x1::string::String,
    }

    struct RegisterAgentResponse has copy, drop {
        agent_id: 0x1::string::String,
        cost_per_message: u64,
        system_prompt: 0x1::string::String,
        is_defeated: bool,
        creator: address,
    }

    struct ConsumePromptResponse has copy, drop {
        agent_id: 0x1::string::String,
        success: bool,
        score: u8,
        attacker: address,
        nonce: u64,
        message_hash: address,
        agent_response: 0x1::string::String,
        jury_response: 0x1::string::String,
        fun_response: 0x1::string::String,
    }

    struct AgentRegistered has copy, drop {
        agent_id: 0x1::string::String,
        prompt: 0x1::string::String,
        cost_per_message: u64,
        initial_balance: u64,
        agent_object_id: 0x2::object::ID,
    }

    struct PromptConsumed has copy, drop {
        agent_id: 0x1::string::String,
        success: bool,
        amount: u64,
        sender: address,
        message: 0x1::string::String,
        agent_response: 0x1::string::String,
        jury_response: 0x1::string::String,
        fun_response: 0x1::string::String,
        score: u8,
    }

    struct FeeTransferred has copy, drop {
        agent_id: 0x1::string::String,
        amount_to_agent: u64,
        amount_to_owner: u64,
        amount_to_protocol: u64,
        total_amount: u64,
    }

    struct AgentFunded has copy, drop {
        agent_id: 0x1::string::String,
        amount: u64,
        funded_timestamp: u64,
        unlock_timestamp: u64,
    }

    struct AgentDefeated has copy, drop {
        agent_id: 0x1::string::String,
        winner: address,
        score: u8,
        amount_won: u64,
    }

    struct FeeRatiosUpdated has copy, drop {
        agent_balance_fee: u64,
        creator_fee: u64,
        protocol_fee: u64,
        updated_by: address,
    }

    struct ProtocolWalletUpdated has copy, drop {
        old_wallet: address,
        new_wallet: address,
        updated_by: address,
    }

    struct FundsWithdrawn has copy, drop {
        agent_id: 0x1::string::String,
        amount: u64,
        withdrawn_at: u64,
    }

    struct FeesClaimed has copy, drop {
        agent_id: 0x1::string::String,
        owner: address,
        amount: u64,
    }

    struct Attack has store, key {
        id: 0x2::object::UID,
        agent_id: 0x1::string::String,
        attacker: address,
        paid_amount: u64,
        nonce: u64,
    }

    struct CanonicalEnclaveSet has copy, drop {
        enclave_id: 0x2::object::ID,
        set_by: address,
        timestamp: u64,
    }

    struct CanonicalEnclaveUpdated has copy, drop {
        old_enclave_id: 0x2::object::ID,
        new_enclave_id: 0x2::object::ID,
        updated_by: address,
        timestamp: u64,
    }

    public fun agent_exists(arg0: &AgentRegistry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.agents, arg1)
    }

    public fun claim_fees(arg0: &mut Agent, arg1: &AgentCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.agent_id == arg1.agent_id, 15);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.accumulated_fees);
        assert!(v0 > 0, 3);
        let v1 = FeesClaimed{
            agent_id : arg0.agent_id,
            owner    : 0x2::tx_context::sender(arg2),
            amount   : v0,
        };
        0x2::event::emit<FeesClaimed>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.accumulated_fees), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun consume_prompt(arg0: &AgentRegistry, arg1: &ProtocolConfig, arg2: &mut Agent, arg3: bool, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u8, arg9: u64, arg10: &vector<u8>, arg11: &0x74b12d0903b409cdcb1ce06280ff3eef7b35622ae164c1d7c4cd154231d89f25::enclave::Enclave<SENTINEL>, arg12: Attack, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        verify_canonical_enclave(arg1, arg11);
        let Attack {
            id          : v0,
            agent_id    : v1,
            attacker    : v2,
            paid_amount : _,
            nonce       : v4,
        } = arg12;
        assert!(0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.agents, arg2.agent_id), 2);
        assert!(arg2.agent_id == v1, 8);
        assert!(0x2::tx_context::sender(arg14) == v2, 6);
        assert!(0x1::string::length(&arg7) <= 64000, 12);
        let v5 = 0x1::bcs::to_bytes<0x1::string::String>(&arg7);
        let v6 = ConsumePromptResponse{
            agent_id       : arg2.agent_id,
            success        : arg3,
            score          : arg8,
            attacker       : 0x2::tx_context::sender(arg14),
            nonce          : v4,
            message_hash   : 0x2::address::from_bytes(0x2::hash::blake2b256(&v5)),
            agent_response : arg4,
            jury_response  : arg5,
            fun_response   : arg6,
        };
        assert!(0x74b12d0903b409cdcb1ce06280ff3eef7b35622ae164c1d7c4cd154231d89f25::enclave::verify_signature<SENTINEL, ConsumePromptResponse>(arg11, 2, arg9, v6, arg10, arg13, 60000), 1);
        0x2::object::delete(v0);
        let v7 = 0x2::tx_context::sender(arg14);
        let v8 = 0;
        if (arg3) {
            let v9 = 0x2::balance::value<0x2::sui::SUI>(&arg2.balance);
            if (v9 > 0) {
                v8 = v9;
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg2.balance), arg14), v7);
                let v10 = AgentDefeated{
                    agent_id   : arg2.agent_id,
                    winner     : v7,
                    score      : arg8,
                    amount_won : v9,
                };
                0x2::event::emit<AgentDefeated>(v10);
            };
        };
        let v11 = PromptConsumed{
            agent_id       : arg2.agent_id,
            success        : arg3,
            amount         : v8,
            sender         : v7,
            message        : arg7,
            agent_response : arg4,
            jury_response  : arg5,
            fun_response   : arg6,
            score          : arg8,
        };
        0x2::event::emit<PromptConsumed>(v11);
    }

    public fun fund_agent(arg0: &mut Agent, arg1: &AgentCap, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.agent_id == arg1.agent_id, 15);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg0.last_funded_timestamp = v0;
        let v1 = AgentFunded{
            agent_id         : arg0.agent_id,
            amount           : 0x2::coin::value<0x2::sui::SUI>(&arg2),
            funded_timestamp : v0,
            unlock_timestamp : v0 + 1209600000,
        };
        0x2::event::emit<AgentFunded>(v1);
    }

    public fun get_agent_balance(arg0: &Agent) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_agent_count(arg0: &AgentRegistry) : u64 {
        arg0.agent_count
    }

    public fun get_agent_info(arg0: &Agent) : AgentInfo {
        AgentInfo{
            agent_id         : arg0.agent_id,
            cost_per_message : arg0.cost_per_message,
            system_prompt    : arg0.system_prompt,
            object_id        : 0x2::object::id<Agent>(arg0),
            balance          : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance),
            accumulated_fees : 0x2::balance::value<0x2::sui::SUI>(&arg0.accumulated_fees),
        }
    }

    public fun get_agent_object_id(arg0: &AgentRegistry, arg1: 0x1::string::String) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.agents, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.agents, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun get_protocol_config(arg0: &ProtocolConfig) : (address, u64, u64, u64) {
        (arg0.protocol_wallet, arg0.agent_balance_fee, arg0.creator_fee, arg0.protocol_fee)
    }

    public fun get_withdrawal_time_remaining(arg0: &Agent, arg1: &0x2::clock::Clock) : u64 {
        if (arg0.last_funded_timestamp == 0) {
            return 0
        };
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.last_funded_timestamp + 1209600000;
        if (v0 >= v1) {
            return 0
        };
        v1 - v0
    }

    public fun get_withdrawal_unlock_timestamp(arg0: &Agent) : u64 {
        if (arg0.last_funded_timestamp == 0) {
            return 0
        };
        arg0.last_funded_timestamp + 1209600000
    }

    fun init(arg0: SENTINEL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x74b12d0903b409cdcb1ce06280ff3eef7b35622ae164c1d7c4cd154231d89f25::enclave::new_cap<SENTINEL>(arg0, arg1);
        0x74b12d0903b409cdcb1ce06280ff3eef7b35622ae164c1d7c4cd154231d89f25::enclave::create_enclave_config<SENTINEL>(&v0, 0x1::string::utf8(b"sentinel enclave"), x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", arg1);
        0x2::transfer::public_transfer<0x74b12d0903b409cdcb1ce06280ff3eef7b35622ae164c1d7c4cd154231d89f25::enclave::Cap<SENTINEL>>(v0, 0x2::tx_context::sender(arg1));
        let v1 = AgentRegistry{
            id          : 0x2::object::new(arg1),
            agents      : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg1),
            agent_count : 0,
        };
        0x2::transfer::share_object<AgentRegistry>(v1);
        let v2 = ProtocolConfig{
            id                   : 0x2::object::new(arg1),
            protocol_wallet      : 0x2::tx_context::sender(arg1),
            agent_balance_fee    : 5000,
            creator_fee          : 4000,
            protocol_fee         : 1000,
            admin                : 0x2::tx_context::sender(arg1),
            canonical_enclave_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<ProtocolConfig>(v2);
    }

    public fun is_withdrawal_unlocked(arg0: &Agent, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) - arg0.last_funded_timestamp >= 1209600000
    }

    public fun register_agent(arg0: &mut AgentRegistry, arg1: &ProtocolConfig, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: &vector<u8>, arg7: &0x74b12d0903b409cdcb1ce06280ff3eef7b35622ae164c1d7c4cd154231d89f25::enclave::Enclave<SENTINEL>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg5) <= 64000, 12);
        verify_canonical_enclave(arg1, arg7);
        let v0 = RegisterAgentResponse{
            agent_id         : arg2,
            cost_per_message : arg4,
            system_prompt    : arg5,
            is_defeated      : false,
            creator          : 0x2::tx_context::sender(arg9),
        };
        assert!(0x74b12d0903b409cdcb1ce06280ff3eef7b35622ae164c1d7c4cd154231d89f25::enclave::verify_signature<SENTINEL, RegisterAgentResponse>(arg7, 1, arg3, v0, arg6, arg8, 60000), 1);
        let v1 = Agent{
            id                    : 0x2::object::new(arg9),
            agent_id              : arg2,
            cost_per_message      : arg4,
            system_prompt         : arg5,
            balance               : 0x2::balance::zero<0x2::sui::SUI>(),
            accumulated_fees      : 0x2::balance::zero<0x2::sui::SUI>(),
            last_funded_timestamp : 0x2::clock::timestamp_ms(arg8),
            created_at            : arg3,
        };
        let v2 = 0x2::object::id<Agent>(&v1);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.agents, arg2, v2);
        arg0.agent_count = arg0.agent_count + 1;
        let v3 = AgentCap{
            id       : 0x2::object::new(arg9),
            agent_id : arg2,
        };
        0x2::transfer::public_transfer<AgentCap>(v3, 0x2::tx_context::sender(arg9));
        let v4 = AgentRegistered{
            agent_id         : arg2,
            prompt           : arg5,
            cost_per_message : arg4,
            initial_balance  : 0,
            agent_object_id  : v2,
        };
        0x2::event::emit<AgentRegistered>(v4);
        0x2::transfer::share_object<Agent>(v1);
    }

    public fun request_attack(arg0: &AgentRegistry, arg1: &mut Agent, arg2: &ProtocolConfig, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Attack {
        assert!(0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.agents, arg1.agent_id), 2);
        assert!(0x2::object::id<Agent>(arg1) == *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.agents, arg1.agent_id), 2);
        assert!(!is_withdrawal_unlocked(arg1, arg5), 10);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 >= arg1.cost_per_message, 4);
        let v1 = v0 * arg2.creator_fee / 10000;
        let v2 = v0 * arg2.protocol_fee / 10000;
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        if (v1 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.accumulated_fees, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v1));
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v2), arg6), arg2.protocol_wallet);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, v3);
        let v4 = 0x2::random::new_generator(arg4, arg6);
        let v5 = Attack{
            id          : 0x2::object::new(arg6),
            agent_id    : arg1.agent_id,
            attacker    : 0x2::tx_context::sender(arg6),
            paid_amount : v0,
            nonce       : 0x2::random::generate_u64(&mut v4),
        };
        let v6 = FeeTransferred{
            agent_id           : arg1.agent_id,
            amount_to_agent    : v0 - v1 - v2,
            amount_to_owner    : v1,
            amount_to_protocol : v2,
            total_amount       : v0,
        };
        0x2::event::emit<FeeTransferred>(v6);
        v5
    }

    public fun set_canonical_enclave(arg0: &mut ProtocolConfig, arg1: &0x74b12d0903b409cdcb1ce06280ff3eef7b35622ae164c1d7c4cd154231d89f25::enclave::Enclave<SENTINEL>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 6);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.canonical_enclave_id), 13);
        arg0.canonical_enclave_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x74b12d0903b409cdcb1ce06280ff3eef7b35622ae164c1d7c4cd154231d89f25::enclave::Enclave<SENTINEL>>(arg1));
        let v0 = CanonicalEnclaveSet{
            enclave_id : 0x2::object::id<0x74b12d0903b409cdcb1ce06280ff3eef7b35622ae164c1d7c4cd154231d89f25::enclave::Enclave<SENTINEL>>(arg1),
            set_by     : 0x2::tx_context::sender(arg3),
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<CanonicalEnclaveSet>(v0);
    }

    public fun transfer_admin(arg0: &mut ProtocolConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 6);
        arg0.admin = arg1;
    }

    public fun update_agent_cost(arg0: &mut Agent, arg1: &AgentCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.agent_id == arg1.agent_id, 15);
        assert!(0x2::clock::timestamp_ms(arg3) - arg0.created_at <= 10800000, 11);
        arg0.cost_per_message = arg2;
    }

    public fun update_agent_prompt(arg0: &mut Agent, arg1: &AgentCap, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.agent_id == arg1.agent_id, 15);
        assert!(0x1::string::length(&arg2) <= 64000, 12);
        assert!(0x2::clock::timestamp_ms(arg3) - arg0.created_at <= 10800000, 11);
        arg0.system_prompt = arg2;
    }

    public fun update_canonical_enclave(arg0: &mut ProtocolConfig, arg1: &0x74b12d0903b409cdcb1ce06280ff3eef7b35622ae164c1d7c4cd154231d89f25::enclave::Enclave<SENTINEL>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 6);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.canonical_enclave_id), 13);
        let v0 = 0x2::object::id<0x74b12d0903b409cdcb1ce06280ff3eef7b35622ae164c1d7c4cd154231d89f25::enclave::Enclave<SENTINEL>>(arg1);
        arg0.canonical_enclave_id = 0x1::option::some<0x2::object::ID>(v0);
        let v1 = CanonicalEnclaveUpdated{
            old_enclave_id : *0x1::option::borrow<0x2::object::ID>(&arg0.canonical_enclave_id),
            new_enclave_id : v0,
            updated_by     : 0x2::tx_context::sender(arg3),
            timestamp      : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<CanonicalEnclaveUpdated>(v1);
    }

    public fun update_fee_ratios(arg0: &mut ProtocolConfig, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 6);
        assert!(arg1 + arg2 + arg3 == 10000, 9);
        arg0.agent_balance_fee = arg1;
        arg0.creator_fee = arg2;
        arg0.protocol_fee = arg3;
        let v0 = FeeRatiosUpdated{
            agent_balance_fee : arg1,
            creator_fee       : arg2,
            protocol_fee      : arg3,
            updated_by        : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<FeeRatiosUpdated>(v0);
    }

    public fun update_protocol_wallet(arg0: &mut ProtocolConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 6);
        assert!(arg0.protocol_wallet != arg1, 16);
        arg0.protocol_wallet = arg1;
        let v0 = ProtocolWalletUpdated{
            old_wallet : arg0.protocol_wallet,
            new_wallet : arg1,
            updated_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ProtocolWalletUpdated>(v0);
    }

    fun verify_canonical_enclave(arg0: &ProtocolConfig, arg1: &0x74b12d0903b409cdcb1ce06280ff3eef7b35622ae164c1d7c4cd154231d89f25::enclave::Enclave<SENTINEL>) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.canonical_enclave_id), 13);
        assert!(0x2::object::id<0x74b12d0903b409cdcb1ce06280ff3eef7b35622ae164c1d7c4cd154231d89f25::enclave::Enclave<SENTINEL>>(arg1) == *0x1::option::borrow<0x2::object::ID>(&arg0.canonical_enclave_id), 14);
    }

    public fun withdraw_from_agent(arg0: &mut Agent, arg1: &AgentCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.agent_id == arg1.agent_id, 15);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 3);
        assert!(is_withdrawal_unlocked(arg0, arg3), 10);
        let v0 = FundsWithdrawn{
            agent_id     : arg0.agent_id,
            amount       : arg2,
            withdrawn_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FundsWithdrawn>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2), arg4)
    }

    // decompiled from Move bytecode v6
}

