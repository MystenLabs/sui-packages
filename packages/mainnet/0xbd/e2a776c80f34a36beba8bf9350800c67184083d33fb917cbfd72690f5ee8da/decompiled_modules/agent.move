module 0xbde2a776c80f34a36beba8bf9350800c67184083d33fb917cbfd72690f5ee8da::agent {
    struct MemoryRef has copy, drop, store {
        blob_id: 0x1::string::String,
        category: 0x1::string::String,
        created_at_ms: u64,
        visibility: u8,
    }

    struct AgentNFT has store, key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        persona: 0x1::string::String,
        avatar: 0x1::string::String,
        memory_refs: vector<MemoryRef>,
        index_blob: 0x1::option::Option<0x1::string::String>,
        heirs: vector<address>,
        dormancy_threshold_ms: u64,
        created_at_ms: u64,
        updated_at_ms: u64,
        version: u64,
    }

    struct AgentMinted has copy, drop {
        agent_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        dormancy_threshold_ms: u64,
    }

    struct MemoryAdded has copy, drop {
        agent_id: 0x2::object::ID,
        blob_id: 0x1::string::String,
        category: 0x1::string::String,
        visibility: u8,
        version: u64,
    }

    struct PersonaUpdated has copy, drop {
        agent_id: 0x2::object::ID,
        version: u64,
    }

    struct IndexUpdated has copy, drop {
        agent_id: 0x2::object::ID,
        index_blob: 0x1::string::String,
        version: u64,
    }

    struct AgentPinged has copy, drop {
        agent_id: 0x2::object::ID,
        pinged_at_ms: u64,
    }

    struct HeirAdded has copy, drop {
        agent_id: 0x2::object::ID,
        heir: address,
    }

    struct HeirRemoved has copy, drop {
        agent_id: 0x2::object::ID,
        heir: address,
    }

    struct DormancyChanged has copy, drop {
        agent_id: 0x2::object::ID,
        threshold_ms: u64,
    }

    public entry fun add_heir(arg0: &mut AgentNFT, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg0.heirs) < 16, 2);
        assert!(!contains_addr(&arg0.heirs, arg1), 0);
        0x1::vector::push_back<address>(&mut arg0.heirs, arg1);
        bump(arg0, 0x2::clock::timestamp_ms(arg2));
        let v0 = HeirAdded{
            agent_id : 0x2::object::id<AgentNFT>(arg0),
            heir     : arg1,
        };
        0x2::event::emit<HeirAdded>(v0);
    }

    public entry fun add_memory(arg0: &mut AgentNFT, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<MemoryRef>(&arg0.memory_refs) < 1024, 3);
        let v0 = if (arg3 == 0) {
            0
        } else {
            1
        };
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = MemoryRef{
            blob_id       : arg1,
            category      : arg2,
            created_at_ms : v1,
            visibility    : v0,
        };
        0x1::vector::push_back<MemoryRef>(&mut arg0.memory_refs, v2);
        bump(arg0, v1);
        let v3 = MemoryAdded{
            agent_id   : 0x2::object::id<AgentNFT>(arg0),
            blob_id    : v2.blob_id,
            category   : v2.category,
            visibility : v0,
            version    : arg0.version,
        };
        0x2::event::emit<MemoryAdded>(v3);
    }

    public fun avatar(arg0: &AgentNFT) : &0x1::string::String {
        &arg0.avatar
    }

    fun bump(arg0: &mut AgentNFT, arg1: u64) {
        arg0.updated_at_ms = arg1;
        arg0.version = arg0.version + 1;
    }

    fun contains_addr(arg0: &vector<address>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun creator(arg0: &AgentNFT) : address {
        arg0.creator
    }

    public fun dormancy_threshold_ms(arg0: &AgentNFT) : u64 {
        arg0.dormancy_threshold_ms
    }

    fun find_addr(arg0: &vector<address>, arg1: address) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun heir_count(arg0: &AgentNFT) : u64 {
        0x1::vector::length<address>(&arg0.heirs)
    }

    public fun heirs(arg0: &AgentNFT) : &vector<address> {
        &arg0.heirs
    }

    public fun is_dormant_at(arg0: &AgentNFT, arg1: u64) : bool {
        arg1 > arg0.updated_at_ms + arg0.dormancy_threshold_ms
    }

    public fun memory_count(arg0: &AgentNFT) : u64 {
        0x1::vector::length<MemoryRef>(&arg0.memory_refs)
    }

    public entry fun mint_agent(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 >= 60000 && arg3 <= 1576800000000, 4);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = AgentNFT{
            id                    : 0x2::object::new(arg5),
            creator               : 0x2::tx_context::sender(arg5),
            name                  : arg0,
            persona               : arg1,
            avatar                : arg2,
            memory_refs           : 0x1::vector::empty<MemoryRef>(),
            index_blob            : 0x1::option::none<0x1::string::String>(),
            heirs                 : 0x1::vector::empty<address>(),
            dormancy_threshold_ms : arg3,
            created_at_ms         : v0,
            updated_at_ms         : v0,
            version               : 0,
        };
        let v2 = AgentMinted{
            agent_id              : 0x2::object::id<AgentNFT>(&v1),
            creator               : 0x2::tx_context::sender(arg5),
            name                  : v1.name,
            dormancy_threshold_ms : arg3,
        };
        0x2::event::emit<AgentMinted>(v2);
        0x2::transfer::public_transfer<AgentNFT>(v1, 0x2::tx_context::sender(arg5));
    }

    public fun name(arg0: &AgentNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun persona(arg0: &AgentNFT) : &0x1::string::String {
        &arg0.persona
    }

    public entry fun ping(arg0: &mut AgentNFT, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        bump(arg0, v0);
        let v1 = AgentPinged{
            agent_id     : 0x2::object::id<AgentNFT>(arg0),
            pinged_at_ms : v0,
        };
        0x2::event::emit<AgentPinged>(v1);
    }

    public entry fun remove_heir(arg0: &mut AgentNFT, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let (v0, v1) = find_addr(&arg0.heirs, arg1);
        assert!(v0, 1);
        0x1::vector::remove<address>(&mut arg0.heirs, v1);
        bump(arg0, 0x2::clock::timestamp_ms(arg2));
        let v2 = HeirRemoved{
            agent_id : 0x2::object::id<AgentNFT>(arg0),
            heir     : arg1,
        };
        0x2::event::emit<HeirRemoved>(v2);
    }

    public entry fun set_dormancy_threshold(arg0: &mut AgentNFT, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 >= 60000 && arg1 <= 1576800000000, 4);
        arg0.dormancy_threshold_ms = arg1;
        bump(arg0, 0x2::clock::timestamp_ms(arg2));
        let v0 = DormancyChanged{
            agent_id     : 0x2::object::id<AgentNFT>(arg0),
            threshold_ms : arg1,
        };
        0x2::event::emit<DormancyChanged>(v0);
    }

    public entry fun set_index_blob(arg0: &mut AgentNFT, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        arg0.index_blob = 0x1::option::some<0x1::string::String>(arg1);
        bump(arg0, 0x2::clock::timestamp_ms(arg2));
        let v0 = IndexUpdated{
            agent_id   : 0x2::object::id<AgentNFT>(arg0),
            index_blob : *0x1::option::borrow<0x1::string::String>(&arg0.index_blob),
            version    : arg0.version,
        };
        0x2::event::emit<IndexUpdated>(v0);
    }

    public entry fun update_persona(arg0: &mut AgentNFT, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        arg0.persona = arg1;
        bump(arg0, 0x2::clock::timestamp_ms(arg2));
        let v0 = PersonaUpdated{
            agent_id : 0x2::object::id<AgentNFT>(arg0),
            version  : arg0.version,
        };
        0x2::event::emit<PersonaUpdated>(v0);
    }

    public fun updated_at_ms(arg0: &AgentNFT) : u64 {
        arg0.updated_at_ms
    }

    public fun version(arg0: &AgentNFT) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

