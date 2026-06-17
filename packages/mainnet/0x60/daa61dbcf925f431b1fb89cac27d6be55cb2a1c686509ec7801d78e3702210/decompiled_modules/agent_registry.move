module 0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::agent_registry {
    struct AgentRegistration has key {
        id: 0x2::object::UID,
        agent_address: address,
        display_name: 0x1::string::String,
        capabilities: vector<0x1::string::String>,
        accepts_object_types: vector<0x1::string::String>,
        produces_object_types: vector<0x1::string::String>,
        base_price_per_call: u64,
        endpoint_url: 0x1::string::String,
        bio_blob: 0x1::string::String,
        completed_tasks: u64,
        total_paid: u64,
        last_settled_ms: u64,
        reputation_score: u64,
        registered_at_ms: u64,
    }

    struct AgentRegistered has copy, drop {
        agent_address: address,
        display_name: 0x1::string::String,
        registered_at_ms: u64,
    }

    struct AgentUpdated has copy, drop {
        agent_address: address,
    }

    public fun accepts(arg0: &AgentRegistration) : &vector<0x1::string::String> {
        &arg0.accepts_object_types
    }

    public fun agent_address(arg0: &AgentRegistration) : address {
        arg0.agent_address
    }

    public fun base_price(arg0: &AgentRegistration) : u64 {
        arg0.base_price_per_call
    }

    public fun bio_blob(arg0: &AgentRegistration) : &0x1::string::String {
        &arg0.bio_blob
    }

    public(friend) fun bump_reputation(arg0: &mut AgentRegistration, arg1: u64) {
        arg0.reputation_score = arg0.reputation_score + arg1;
    }

    public fun capabilities(arg0: &AgentRegistration) : &vector<0x1::string::String> {
        &arg0.capabilities
    }

    public fun completed_tasks(arg0: &AgentRegistration) : u64 {
        arg0.completed_tasks
    }

    public fun last_settled_ms(arg0: &AgentRegistration) : u64 {
        arg0.last_settled_ms
    }

    public fun produces(arg0: &AgentRegistration) : &vector<0x1::string::String> {
        &arg0.produces_object_types
    }

    public fun register(arg0: 0x1::string::String, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg7);
        let v2 = AgentRegistration{
            id                    : 0x2::object::new(arg7),
            agent_address         : v0,
            display_name          : arg0,
            capabilities          : arg1,
            accepts_object_types  : arg2,
            produces_object_types : arg3,
            base_price_per_call   : arg4,
            endpoint_url          : arg5,
            bio_blob              : arg6,
            completed_tasks       : 0,
            total_paid            : 0,
            last_settled_ms       : 0,
            reputation_score      : 0,
            registered_at_ms      : v1,
        };
        let v3 = AgentRegistered{
            agent_address    : v0,
            display_name     : v2.display_name,
            registered_at_ms : v1,
        };
        0x2::event::emit<AgentRegistered>(v3);
        0x2::transfer::share_object<AgentRegistration>(v2);
    }

    public fun reputation(arg0: &AgentRegistration) : u64 {
        arg0.reputation_score
    }

    public(friend) fun settle_reputation_bump(arg0: &mut AgentRegistration, arg1: u64, arg2: u64) {
        arg0.completed_tasks = arg0.completed_tasks + 1;
        arg0.total_paid = arg0.total_paid + arg1;
        arg0.last_settled_ms = arg2;
        arg0.reputation_score = arg0.reputation_score + 1;
    }

    public fun total_paid(arg0: &AgentRegistration) : u64 {
        arg0.total_paid
    }

    public fun update(arg0: &mut AgentRegistration, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.agent_address, 1);
        arg0.capabilities = arg1;
        arg0.accepts_object_types = arg2;
        arg0.produces_object_types = arg3;
        arg0.base_price_per_call = arg4;
        arg0.endpoint_url = arg5;
        arg0.bio_blob = arg6;
        let v0 = AgentUpdated{agent_address: arg0.agent_address};
        0x2::event::emit<AgentUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

