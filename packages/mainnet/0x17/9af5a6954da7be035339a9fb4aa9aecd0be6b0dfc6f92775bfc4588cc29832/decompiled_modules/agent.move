module 0x179af5a6954da7be035339a9fb4aa9aecd0be6b0dfc6f92775bfc4588cc29832::agent {
    struct Agent has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        agent_type: 0x1::string::String,
        agent_type_code: u8,
        status: u8,
        created_at: u64,
        total_actions: u64,
        successful_actions: u64,
        daily_spending_limit: u64,
        current_daily_spend: u64,
        last_reset_epoch: u64,
        config_blob_id: 0x1::string::String,
        metadata_blob_id: 0x1::string::String,
    }

    struct AgentOwnerCap has store, key {
        id: 0x2::object::UID,
        agent_id: 0x2::object::ID,
    }

    struct ActionRecorded has copy, drop {
        agent_id: 0x2::object::ID,
        action_type: 0x1::string::String,
        success: bool,
        spend_amount: u64,
        epoch: u64,
        walrus_blob_id: 0x1::string::String,
    }

    struct BlobUpdated has copy, drop {
        agent_id: 0x2::object::ID,
        blob_field: 0x1::string::String,
        old_blob_id: 0x1::string::String,
        new_blob_id: 0x1::string::String,
    }

    fun assert_action_allowed(arg0: u8, arg1: u8) {
        if (arg1 == 0) {
            return
        };
        if (arg0 == 10) {
            return
        };
        assert!(arg0 == 1 && arg1 == 1 || arg0 == 2 && arg1 == 2 || arg0 == 3 && arg1 == 3 || arg0 == 4 && arg1 == 4 || arg0 == 5 && (arg1 == 5 || arg1 == 2) || arg0 == 6 && (arg1 == 6 || arg1 == 1) || arg0 == 7 && (arg1 == 7 || arg1 == 2) || arg0 == 8 && arg1 == 8 || arg0 == 9 && arg1 == 9, 3);
    }

    public fun create_agent(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (Agent, AgentOwnerCap) {
        assert!(arg2 >= 1 && arg2 <= 10, 4);
        let v0 = 0x2::tx_context::epoch(arg4);
        let v1 = Agent{
            id                   : 0x2::object::new(arg4),
            owner                : 0x2::tx_context::sender(arg4),
            name                 : arg0,
            agent_type           : arg1,
            agent_type_code      : arg2,
            status               : 1,
            created_at           : v0,
            total_actions        : 0,
            successful_actions   : 0,
            daily_spending_limit : arg3,
            current_daily_spend  : 0,
            last_reset_epoch     : v0,
            config_blob_id       : 0x1::string::utf8(b""),
            metadata_blob_id     : 0x1::string::utf8(b""),
        };
        let v2 = AgentOwnerCap{
            id       : 0x2::object::new(arg4),
            agent_id : 0x2::object::id<Agent>(&v1),
        };
        (v1, v2)
    }

    entry fun create_and_transfer(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_agent(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::transfer<Agent>(v0, 0x2::tx_context::sender(arg4));
        0x2::transfer::transfer<AgentOwnerCap>(v1, 0x2::tx_context::sender(arg4));
    }

    public fun get_agent_type(arg0: &Agent) : 0x1::string::String {
        arg0.agent_type
    }

    public fun get_agent_type_code(arg0: &Agent) : u8 {
        arg0.agent_type_code
    }

    public fun get_config_blob_id(arg0: &Agent) : 0x1::string::String {
        arg0.config_blob_id
    }

    public fun get_current_daily_spend(arg0: &Agent) : u64 {
        arg0.current_daily_spend
    }

    public fun get_daily_spending_limit(arg0: &Agent) : u64 {
        arg0.daily_spending_limit
    }

    public fun get_metadata_blob_id(arg0: &Agent) : 0x1::string::String {
        arg0.metadata_blob_id
    }

    public fun get_name(arg0: &Agent) : 0x1::string::String {
        arg0.name
    }

    public fun get_owner(arg0: &Agent) : address {
        arg0.owner
    }

    public fun get_remaining_daily_budget(arg0: &Agent) : u64 {
        arg0.daily_spending_limit - arg0.current_daily_spend
    }

    public fun get_status(arg0: &Agent) : u8 {
        arg0.status
    }

    public fun get_success_rate(arg0: &Agent) : u64 {
        if (arg0.total_actions == 0) {
            0
        } else {
            arg0.successful_actions * 100 / arg0.total_actions
        }
    }

    public fun get_successful_actions(arg0: &Agent) : u64 {
        arg0.successful_actions
    }

    public fun get_total_actions(arg0: &Agent) : u64 {
        arg0.total_actions
    }

    public fun has_config_blob(arg0: &Agent) : bool {
        0x1::string::length(&arg0.config_blob_id) > 0
    }

    public fun has_metadata_blob(arg0: &Agent) : bool {
        0x1::string::length(&arg0.metadata_blob_id) > 0
    }

    public fun is_action_allowed(arg0: u8, arg1: u8) : bool {
        if (arg1 == 0) {
            return true
        };
        if (arg0 == 10) {
            return true
        };
        if (arg1 > 10) {
            return false
        };
        arg0 == 1 && arg1 == 1 || arg0 == 2 && arg1 == 2 || arg0 == 3 && arg1 == 3 || arg0 == 4 && arg1 == 4 || arg0 == 5 && (arg1 == 5 || arg1 == 2) || arg0 == 6 && (arg1 == 6 || arg1 == 1) || arg0 == 7 && (arg1 == 7 || arg1 == 2) || arg0 == 8 && arg1 == 8 || arg0 == 9 && arg1 == 9
    }

    public fun is_active(arg0: &Agent) : bool {
        arg0.status == 1
    }

    public fun pause_agent(arg0: &mut Agent, arg1: &AgentOwnerCap) {
        assert!(0x2::object::id<Agent>(arg0) == arg1.agent_id, 0);
        arg0.status = 2;
    }

    public fun record_action(arg0: &mut Agent, arg1: 0x1::string::String, arg2: u8, arg3: bool, arg4: u64, arg5: 0x1::string::String, arg6: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 1);
        assert!(arg2 <= 10, 5);
        if (arg0.agent_type_code > 0) {
            assert_action_allowed(arg0.agent_type_code, arg2);
        };
        let v0 = 0x2::tx_context::epoch(arg6);
        if (v0 > arg0.last_reset_epoch) {
            arg0.current_daily_spend = 0;
            arg0.last_reset_epoch = v0;
        };
        if (arg4 > 0) {
            assert!(arg0.current_daily_spend + arg4 <= arg0.daily_spending_limit, 2);
            arg0.current_daily_spend = arg0.current_daily_spend + arg4;
        };
        arg0.total_actions = arg0.total_actions + 1;
        if (arg3) {
            arg0.successful_actions = arg0.successful_actions + 1;
        };
        let v1 = ActionRecorded{
            agent_id       : 0x2::object::id<Agent>(arg0),
            action_type    : arg1,
            success        : arg3,
            spend_amount   : arg4,
            epoch          : v0,
            walrus_blob_id : arg5,
        };
        0x2::event::emit<ActionRecorded>(v1);
    }

    public fun resume_agent(arg0: &mut Agent, arg1: &AgentOwnerCap) {
        assert!(0x2::object::id<Agent>(arg0) == arg1.agent_id, 0);
        arg0.status = 1;
    }

    entry fun set_config_blob(arg0: &mut Agent, arg1: &AgentOwnerCap, arg2: 0x1::string::String) {
        update_config_blob(arg0, arg1, arg2);
    }

    entry fun set_metadata_blob(arg0: &mut Agent, arg1: &AgentOwnerCap, arg2: 0x1::string::String) {
        update_metadata_blob(arg0, arg1, arg2);
    }

    public fun terminate_agent(arg0: &mut Agent, arg1: &AgentOwnerCap) {
        assert!(0x2::object::id<Agent>(arg0) == arg1.agent_id, 0);
        arg0.status = 3;
    }

    public fun update_config_blob(arg0: &mut Agent, arg1: &AgentOwnerCap, arg2: 0x1::string::String) {
        assert!(0x2::object::id<Agent>(arg0) == arg1.agent_id, 0);
        arg0.config_blob_id = arg2;
        let v0 = BlobUpdated{
            agent_id    : 0x2::object::id<Agent>(arg0),
            blob_field  : 0x1::string::utf8(b"config"),
            old_blob_id : arg0.config_blob_id,
            new_blob_id : arg0.config_blob_id,
        };
        0x2::event::emit<BlobUpdated>(v0);
    }

    public fun update_metadata_blob(arg0: &mut Agent, arg1: &AgentOwnerCap, arg2: 0x1::string::String) {
        assert!(0x2::object::id<Agent>(arg0) == arg1.agent_id, 0);
        arg0.metadata_blob_id = arg2;
        let v0 = BlobUpdated{
            agent_id    : 0x2::object::id<Agent>(arg0),
            blob_field  : 0x1::string::utf8(b"metadata"),
            old_blob_id : arg0.metadata_blob_id,
            new_blob_id : arg0.metadata_blob_id,
        };
        0x2::event::emit<BlobUpdated>(v0);
    }

    public fun update_spending_limit(arg0: &mut Agent, arg1: &AgentOwnerCap, arg2: u64) {
        assert!(0x2::object::id<Agent>(arg0) == arg1.agent_id, 0);
        arg0.daily_spending_limit = arg2;
    }

    // decompiled from Move bytecode v6
}

