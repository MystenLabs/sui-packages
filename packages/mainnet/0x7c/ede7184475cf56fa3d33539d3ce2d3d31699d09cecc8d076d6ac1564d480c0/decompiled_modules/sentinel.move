module 0x7cede7184475cf56fa3d33539d3ce2d3d31699d09cecc8d076d6ac1564d480c0::sentinel {
    struct Agent<phantom T0> has store, key {
        id: 0x2::object::UID,
        agent_id: 0x1::string::String,
        cost_per_message: u64,
        prompt_hash: vector<u8>,
        balance: 0x2::balance::Balance<T0>,
        accumulated_fees: 0x2::balance::Balance<T0>,
        last_funded_timestamp: u64,
        created_at: u64,
        attack_count: u64,
        is_defeated: bool,
    }

    struct AgentInfo has copy, drop {
        agent_id: 0x1::string::String,
        cost_per_message: u64,
        prompt_hash: vector<u8>,
        object_id: 0x2::object::ID,
        balance: u64,
        accumulated_fees: u64,
        token_type: 0x1::type_name::TypeName,
        attack_count: u64,
        is_defeated: bool,
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
        enclave_pubkey: 0x1::option::Option<vector<u8>>,
        whitelisted_tokens: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        fee_increase_bps: u64,
        max_fee_multiplier_bps: u64,
        is_paused: bool,
        minimum_token_amounts: 0x2::table::Table<0x1::type_name::TypeName, u64>,
    }

    struct SENTINEL has drop {
        dummy_field: bool,
    }

    struct AgentCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        agent_id: 0x1::string::String,
    }

    struct Attack<phantom T0> has store, key {
        id: 0x2::object::UID,
        agent_id: 0x1::string::String,
        attacker: address,
        paid_amount: u64,
        nonce: u64,
    }

    struct AgentRegistered has copy, drop {
        agent_id: 0x1::string::String,
        prompt_hash: vector<u8>,
        cost_per_message: u64,
        initial_balance: u64,
        agent_object_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
    }

    struct PromptConsumed has copy, drop {
        agent_id: 0x1::string::String,
        success: bool,
        amount: u64,
        sender: address,
        message_hash: vector<u8>,
        score: u64,
        token_type: 0x1::type_name::TypeName,
    }

    struct FeeTransferred has copy, drop {
        agent_id: 0x1::string::String,
        amount_to_agent: u64,
        amount_to_owner: u64,
        amount_to_protocol: u64,
        total_amount: u64,
        token_type: 0x1::type_name::TypeName,
    }

    struct AgentFunded has copy, drop {
        agent_id: 0x1::string::String,
        amount: u64,
        funded_timestamp: u64,
        unlock_timestamp: u64,
        token_type: 0x1::type_name::TypeName,
    }

    struct AgentDefeated has copy, drop {
        agent_id: 0x1::string::String,
        winner: address,
        score: u64,
        amount_won: u64,
        token_type: 0x1::type_name::TypeName,
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
        token_type: 0x1::type_name::TypeName,
    }

    struct FeesClaimed has copy, drop {
        agent_id: 0x1::string::String,
        owner: address,
        amount: u64,
        token_type: 0x1::type_name::TypeName,
    }

    struct EnclavePubkeySet has copy, drop {
        enclave_pubkey: vector<u8>,
        set_by: address,
        timestamp: u64,
    }

    struct EnclavePubkeyUpdated has copy, drop {
        old_enclave_pubkey: vector<u8>,
        new_enclave_pubkey: vector<u8>,
        updated_by: address,
        timestamp: u64,
    }

    struct ProtocolPaused has copy, drop {
        paused_by: address,
        timestamp: u64,
    }

    struct ProtocolUnpaused has copy, drop {
        unpaused_by: address,
        timestamp: u64,
    }

    public fun add_whitelisted_token<T0>(arg0: &mut ProtocolConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 6);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.whitelisted_tokens, 0x1::type_name::get<T0>());
    }

    public fun agent_exists(arg0: &AgentRegistry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.agents, arg1)
    }

    fun build_consume_prompt_message(arg0: u8, arg1: u64, arg2: &0x1::string::String, arg3: bool, arg4: u64, arg5: &address, arg6: u64, arg7: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(arg2));
        let v1 = if (arg3) {
            1
        } else {
            0
        };
        0x1::vector::push_back<u8>(&mut v0, v1);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(arg5));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg6));
        0x1::vector::append<u8>(&mut v0, *arg7);
        v0
    }

    fun build_register_agent_message(arg0: u8, arg1: u64, arg2: &0x1::string::String, arg3: u64, arg4: &vector<u8>, arg5: &address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, *arg4);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(arg5));
        v0
    }

    public fun claim_fees<T0>(arg0: &mut Agent<T0>, arg1: &AgentCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.agent_id == arg1.agent_id, 15);
        let v0 = 0x2::balance::value<T0>(&arg0.accumulated_fees);
        assert!(v0 > 0, 3);
        let v1 = FeesClaimed{
            agent_id   : arg0.agent_id,
            owner      : 0x2::tx_context::sender(arg2),
            amount     : v0,
            token_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<FeesClaimed>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.accumulated_fees), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun consume_prompt<T0>(arg0: &AgentRegistry, arg1: &ProtocolConfig, arg2: &mut Agent<T0>, arg3: bool, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: &vector<u8>, arg8: Attack<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_paused, 19);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 21);
        verify_enclave_set(arg1);
        let Attack {
            id          : v0,
            agent_id    : v1,
            attacker    : v2,
            paid_amount : _,
            nonce       : v4,
        } = arg8;
        assert!(0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.agents, arg2.agent_id), 2);
        assert!(arg2.agent_id == v1, 8);
        assert!(0x2::tx_context::sender(arg10) == v2, 6);
        let v5 = 0x2::tx_context::sender(arg10);
        let v6 = build_consume_prompt_message(2, arg6, &arg2.agent_id, arg3, arg4, &v5, v4, &arg5);
        let v7 = *0x1::option::borrow<vector<u8>>(&arg1.enclave_pubkey);
        verify_signature(&v7, &v6, arg7, arg6, arg9, 180);
        0x2::object::delete(v0);
        let v8 = 0x2::tx_context::sender(arg10);
        let v9 = 0;
        if (arg3) {
            let v10 = 0x2::balance::value<T0>(&arg2.balance);
            if (v10 > 0) {
                v9 = v10;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg2.balance), arg10), v8);
                let v11 = AgentDefeated{
                    agent_id   : arg2.agent_id,
                    winner     : v8,
                    score      : arg4,
                    amount_won : v10,
                    token_type : 0x1::type_name::get<T0>(),
                };
                0x2::event::emit<AgentDefeated>(v11);
            };
            arg2.is_defeated = true;
        };
        let v12 = PromptConsumed{
            agent_id     : arg2.agent_id,
            success      : arg3,
            amount       : v9,
            sender       : v8,
            message_hash : arg5,
            score        : arg4,
            token_type   : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<PromptConsumed>(v12);
    }

    public fun fund_agent<T0>(arg0: &mut Agent<T0>, arg1: &AgentCap<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.agent_id == arg1.agent_id, 15);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg2));
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg0.last_funded_timestamp = v0;
        let v1 = AgentFunded{
            agent_id         : arg0.agent_id,
            amount           : 0x2::coin::value<T0>(&arg2),
            funded_timestamp : v0,
            unlock_timestamp : v0 + 1209600000,
            token_type       : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<AgentFunded>(v1);
    }

    public fun get_agent_balance<T0>(arg0: &Agent<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_agent_count(arg0: &AgentRegistry) : u64 {
        arg0.agent_count
    }

    public fun get_agent_info<T0>(arg0: &Agent<T0>) : AgentInfo {
        AgentInfo{
            agent_id         : arg0.agent_id,
            cost_per_message : arg0.cost_per_message,
            prompt_hash      : arg0.prompt_hash,
            object_id        : 0x2::object::id<Agent<T0>>(arg0),
            balance          : 0x2::balance::value<T0>(&arg0.balance),
            accumulated_fees : 0x2::balance::value<T0>(&arg0.accumulated_fees),
            token_type       : 0x1::type_name::get<T0>(),
            attack_count     : arg0.attack_count,
            is_defeated      : arg0.is_defeated,
        }
    }

    public fun get_agent_object_id(arg0: &AgentRegistry, arg1: 0x1::string::String) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.agents, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.agents, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun get_attack_count<T0>(arg0: &Agent<T0>) : u64 {
        arg0.attack_count
    }

    public fun get_effective_cost<T0>(arg0: &Agent<T0>, arg1: &ProtocolConfig) : u64 {
        let v0 = 10000 + arg0.attack_count * arg1.fee_increase_bps;
        let v1 = if (v0 > arg1.max_fee_multiplier_bps) {
            arg1.max_fee_multiplier_bps
        } else {
            v0
        };
        arg0.cost_per_message * v1 / 10000
    }

    public fun get_enclave_pubkey(arg0: &ProtocolConfig) : 0x1::option::Option<vector<u8>> {
        arg0.enclave_pubkey
    }

    public fun get_fee_settings(arg0: &ProtocolConfig) : (u64, u64) {
        (arg0.fee_increase_bps, arg0.max_fee_multiplier_bps)
    }

    public fun get_minimum_token_amount<T0>(arg0: &ProtocolConfig) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.minimum_token_amounts, v0)) {
            *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.minimum_token_amounts, v0)
        } else {
            0
        }
    }

    public fun get_protocol_config(arg0: &ProtocolConfig) : (address, u64, u64, u64) {
        (arg0.protocol_wallet, arg0.agent_balance_fee, arg0.creator_fee, arg0.protocol_fee)
    }

    public fun get_withdrawal_time_remaining<T0>(arg0: &Agent<T0>, arg1: &0x2::clock::Clock) : u64 {
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

    public fun get_withdrawal_unlock_timestamp<T0>(arg0: &Agent<T0>) : u64 {
        if (arg0.last_funded_timestamp == 0) {
            return 0
        };
        arg0.last_funded_timestamp + 1209600000
    }

    fun init(arg0: SENTINEL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AgentRegistry{
            id          : 0x2::object::new(arg1),
            agents      : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg1),
            agent_count : 0,
        };
        0x2::transfer::share_object<AgentRegistry>(v0);
        let v1 = 0x2::vec_set::empty<0x1::type_name::TypeName>();
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v1, 0x1::type_name::get<0x2::sui::SUI>());
        let v2 = ProtocolConfig{
            id                     : 0x2::object::new(arg1),
            protocol_wallet        : 0x2::tx_context::sender(arg1),
            agent_balance_fee      : 5000,
            creator_fee            : 4000,
            protocol_fee           : 1000,
            admin                  : 0x2::tx_context::sender(arg1),
            enclave_pubkey         : 0x1::option::none<vector<u8>>(),
            whitelisted_tokens     : v1,
            fee_increase_bps       : 100,
            max_fee_multiplier_bps : 30000,
            is_paused              : false,
            minimum_token_amounts  : 0x2::table::new<0x1::type_name::TypeName, u64>(arg1),
        };
        0x2::transfer::share_object<ProtocolConfig>(v2);
    }

    public fun is_agent_defeated<T0>(arg0: &Agent<T0>) : bool {
        arg0.is_defeated
    }

    public fun is_protocol_paused(arg0: &ProtocolConfig) : bool {
        arg0.is_paused
    }

    public fun is_token_whitelisted<T0>(arg0: &ProtocolConfig) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelisted_tokens, &v0)
    }

    public fun is_withdrawal_unlocked<T0>(arg0: &Agent<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) - arg0.last_funded_timestamp >= 1209600000
    }

    public fun pause_protocol(arg0: &mut ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 6);
        arg0.is_paused = true;
        let v0 = ProtocolPaused{
            paused_by : 0x2::tx_context::sender(arg2),
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ProtocolPaused>(v0);
    }

    public fun register_agent<T0>(arg0: &mut AgentRegistry, arg1: &ProtocolConfig, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: 0x2::coin::Coin<T0>, arg7: &vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_paused, 19);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 21);
        assert!(is_token_whitelisted<T0>(arg1), 17);
        verify_enclave_set(arg1);
        let v0 = 0x2::coin::value<T0>(&arg6);
        assert!(v0 >= get_minimum_token_amount<T0>(arg1), 20);
        let v1 = 0x2::tx_context::sender(arg9);
        let v2 = build_register_agent_message(1, arg3, &arg2, arg4, &arg5, &v1);
        let v3 = *0x1::option::borrow<vector<u8>>(&arg1.enclave_pubkey);
        verify_signature(&v3, &v2, arg7, arg3, arg8, 180);
        let v4 = 0x2::clock::timestamp_ms(arg8);
        let v5 = Agent<T0>{
            id                    : 0x2::object::new(arg9),
            agent_id              : arg2,
            cost_per_message      : arg4,
            prompt_hash           : arg5,
            balance               : 0x2::coin::into_balance<T0>(arg6),
            accumulated_fees      : 0x2::balance::zero<T0>(),
            last_funded_timestamp : v4,
            created_at            : v4,
            attack_count          : 0,
            is_defeated           : false,
        };
        let v6 = 0x2::object::id<Agent<T0>>(&v5);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.agents, arg2, v6);
        arg0.agent_count = arg0.agent_count + 1;
        let v7 = AgentCap<T0>{
            id       : 0x2::object::new(arg9),
            agent_id : arg2,
        };
        0x2::transfer::public_transfer<AgentCap<T0>>(v7, 0x2::tx_context::sender(arg9));
        let v8 = AgentRegistered{
            agent_id         : arg2,
            prompt_hash      : arg5,
            cost_per_message : arg4,
            initial_balance  : v0,
            agent_object_id  : v6,
            token_type       : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<AgentRegistered>(v8);
        0x2::transfer::share_object<Agent<T0>>(v5);
    }

    public fun remove_minimum_token_amount<T0>(arg0: &mut ProtocolConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 6);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.minimum_token_amounts, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.minimum_token_amounts, v0);
        };
    }

    public fun remove_whitelisted_token<T0>(arg0: &mut ProtocolConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 6);
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.whitelisted_tokens, &v0);
    }

    public fun request_attack<T0>(arg0: &AgentRegistry, arg1: &mut Agent<T0>, arg2: &ProtocolConfig, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Attack<T0> {
        assert!(!arg2.is_paused, 19);
        assert!(0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.agents, arg1.agent_id), 2);
        assert!(0x2::object::id<Agent<T0>>(arg1) == *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.agents, arg1.agent_id), 2);
        assert!(is_token_whitelisted<T0>(arg2), 17);
        assert!(!is_withdrawal_unlocked<T0>(arg1, arg5), 18);
        assert!(!arg1.is_defeated, 24);
        let v0 = 0x2::coin::value<T0>(&arg3);
        arg1.attack_count = arg1.attack_count + 1;
        let v1 = v0 * arg2.creator_fee / 10000;
        let v2 = v0 * arg2.protocol_fee / 10000;
        let v3 = 0x2::coin::into_balance<T0>(arg3);
        if (v1 > 0) {
            0x2::balance::join<T0>(&mut arg1.accumulated_fees, 0x2::balance::split<T0>(&mut v3, v1));
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, v2), arg6), arg2.protocol_wallet);
        };
        0x2::balance::join<T0>(&mut arg1.balance, v3);
        let v4 = 0x2::random::new_generator(arg4, arg6);
        let v5 = Attack<T0>{
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
            token_type         : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<FeeTransferred>(v6);
        v5
    }

    public fun set_enclave_pubkey(arg0: &mut ProtocolConfig, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 6);
        assert!(0x1::option::is_none<vector<u8>>(&arg0.enclave_pubkey), 13);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 21);
        arg0.enclave_pubkey = 0x1::option::some<vector<u8>>(arg1);
        let v0 = EnclavePubkeySet{
            enclave_pubkey : *0x1::option::borrow<vector<u8>>(&arg0.enclave_pubkey),
            set_by         : 0x2::tx_context::sender(arg3),
            timestamp      : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<EnclavePubkeySet>(v0);
    }

    public fun set_minimum_token_amount<T0>(arg0: &mut ProtocolConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 6);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.minimum_token_amounts, v0)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.minimum_token_amounts, v0) = arg1;
        } else {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.minimum_token_amounts, v0, arg1);
        };
    }

    public fun transfer_admin(arg0: &mut ProtocolConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 6);
        arg0.admin = arg1;
    }

    public fun unpause_protocol(arg0: &mut ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 6);
        arg0.is_paused = false;
        let v0 = ProtocolUnpaused{
            unpaused_by : 0x2::tx_context::sender(arg2),
            timestamp   : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ProtocolUnpaused>(v0);
    }

    public fun update_agent_cost<T0>(arg0: &mut Agent<T0>, arg1: &AgentCap<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.agent_id == arg1.agent_id, 15);
        assert!(0x2::clock::timestamp_ms(arg3) - arg0.created_at <= 10800000, 11);
        arg0.cost_per_message = arg2;
    }

    public fun update_agent_prompt_hash<T0>(arg0: &mut Agent<T0>, arg1: &AgentCap<T0>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.agent_id == arg1.agent_id, 15);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 21);
        assert!(0x2::clock::timestamp_ms(arg3) - arg0.created_at <= 10800000, 11);
        arg0.prompt_hash = arg2;
    }

    public fun update_dynamic_fee_settings(arg0: &mut ProtocolConfig, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 6);
        assert!(arg2 >= 10000, 9);
        arg0.fee_increase_bps = arg1;
        arg0.max_fee_multiplier_bps = arg2;
    }

    public fun update_enclave_pubkey(arg0: &mut ProtocolConfig, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 6);
        assert!(0x1::option::is_some<vector<u8>>(&arg0.enclave_pubkey), 13);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 21);
        arg0.enclave_pubkey = 0x1::option::some<vector<u8>>(arg1);
        let v0 = EnclavePubkeyUpdated{
            old_enclave_pubkey : *0x1::option::borrow<vector<u8>>(&arg0.enclave_pubkey),
            new_enclave_pubkey : *0x1::option::borrow<vector<u8>>(&arg0.enclave_pubkey),
            updated_by         : 0x2::tx_context::sender(arg3),
            timestamp          : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<EnclavePubkeyUpdated>(v0);
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

    fun verify_enclave_set(arg0: &ProtocolConfig) {
        assert!(0x1::option::is_some<vector<u8>>(&arg0.enclave_pubkey), 13);
    }

    fun verify_signature(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        assert!(arg3 <= v0, 22);
        assert!(v0 - arg3 <= arg5, 23);
        assert!(0x2::ed25519::ed25519_verify(arg2, arg0, arg1), 1);
    }

    public fun withdraw_from_agent<T0>(arg0: &mut Agent<T0>, arg1: &AgentCap<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.agent_id == arg1.agent_id, 15);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg2, 3);
        assert!(is_withdrawal_unlocked<T0>(arg0, arg3), 10);
        let v0 = FundsWithdrawn{
            agent_id     : arg0.agent_id,
            amount       : arg2,
            withdrawn_at : 0x2::clock::timestamp_ms(arg3),
            token_type   : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<FundsWithdrawn>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg4)
    }

    // decompiled from Move bytecode v6
}

