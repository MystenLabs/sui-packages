module 0xbb7f1348443df92fc4cfd5c5eb0b6da619e377e06786b6930aa6eb1ca35a0e1e::composable {
    struct MemoryNFT has store, key {
        id: 0x2::object::UID,
        author: address,
        blob_id: 0x1::string::String,
        content_root_hash: vector<u8>,
        schema_version: u8,
        created_at: u64,
    }

    struct AgentNFT has store, key {
        id: 0x2::object::UID,
        controller: address,
        version: u64,
        strategy_type: u8,
        strategy_blob_id: 0x1::string::String,
        strategy_content_root: vector<u8>,
        memories: 0x2::bag::Bag,
        last_execute_ms: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PoolWhitelist has key {
        id: 0x2::object::UID,
        pools: vector<address>,
        per_execute_cap_mist: u64,
        per_execute_window_ms: u64,
    }

    struct MemoryCreated has copy, drop {
        memory_id: 0x2::object::ID,
        author: address,
        blob_id: 0x1::string::String,
        schema_version: u8,
    }

    struct AgentCreated has copy, drop {
        agent_id: 0x2::object::ID,
        controller: address,
        strategy_type: u8,
    }

    struct MemoryAttached has copy, drop {
        agent_id: 0x2::object::ID,
        memory_id: 0x2::object::ID,
        name: 0x1::string::String,
        by: address,
    }

    struct MemoryDetached has copy, drop {
        agent_id: 0x2::object::ID,
        memory_id: 0x2::object::ID,
        name: 0x1::string::String,
        by: address,
    }

    struct AgentExecuted has copy, drop {
        agent_id: 0x2::object::ID,
        controller: address,
        amount_mist: u64,
        pool: address,
        ts_ms: u64,
    }

    struct AgentDestroyed has copy, drop {
        agent_id: 0x2::object::ID,
        by: address,
    }

    struct ControllerUpdated has copy, drop {
        agent_id: 0x2::object::ID,
        controller: address,
        by: address,
    }

    struct AdminBoundWhitelist has key {
        id: 0x2::object::UID,
        pools: vector<address>,
        per_execute_cap_mist: u64,
        per_execute_window_ms: u64,
        admin: 0x2::object::ID,
    }

    struct BoundWhitelistCreated has copy, drop {
        whitelist_id: 0x2::object::ID,
        admin: 0x2::object::ID,
    }

    struct BoundPoolWhitelisted has copy, drop {
        whitelist_id: 0x2::object::ID,
        pool: address,
        by: address,
    }

    struct BoundPoolUnwhitelisted has copy, drop {
        whitelist_id: 0x2::object::ID,
        pool: address,
        by: address,
    }

    struct BoundCapsUpdated has copy, drop {
        whitelist_id: 0x2::object::ID,
        per_execute_cap_mist: u64,
        per_execute_window_ms: u64,
        by: address,
    }

    public fun agent_controller(arg0: &AgentNFT) : address {
        arg0.controller
    }

    public fun agent_last_execute_ms(arg0: &AgentNFT) : u64 {
        arg0.last_execute_ms
    }

    public fun agent_memory_count(arg0: &AgentNFT) : u64 {
        0x2::bag::length(&arg0.memories)
    }

    public fun agent_strategy_blob(arg0: &AgentNFT) : 0x1::string::String {
        arg0.strategy_blob_id
    }

    public fun agent_strategy_root(arg0: &AgentNFT) : vector<u8> {
        arg0.strategy_content_root
    }

    public fun agent_strategy_type(arg0: &AgentNFT) : u8 {
        arg0.strategy_type
    }

    public fun agent_version(arg0: &AgentNFT) : u64 {
        arg0.version
    }

    public fun attach(arg0: &mut AgentNFT, arg1: MemoryNFT, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::is_empty(&arg2) == false, 6);
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.memories, arg2) == false, 3);
        assert!(0x2::bag::length(&arg0.memories) < 50, 4);
        let v0 = MemoryAttached{
            agent_id  : 0x2::object::id<AgentNFT>(arg0),
            memory_id : 0x2::object::id<MemoryNFT>(&arg1),
            name      : arg2,
            by        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MemoryAttached>(v0);
        0x2::bag::add<0x1::string::String, MemoryNFT>(&mut arg0.memories, arg2, arg1);
    }

    public fun bound_whitelist_admin(arg0: &AdminBoundWhitelist) : 0x2::object::ID {
        arg0.admin
    }

    public fun bound_whitelist_cap_mist(arg0: &AdminBoundWhitelist) : u64 {
        arg0.per_execute_cap_mist
    }

    public fun bound_whitelist_pools(arg0: &AdminBoundWhitelist) : vector<address> {
        arg0.pools
    }

    public fun bound_whitelist_window_ms(arg0: &AdminBoundWhitelist) : u64 {
        arg0.per_execute_window_ms
    }

    public fun create_agent(arg0: 0x1::string::String, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : AgentNFT {
        assert!(0x1::string::is_empty(&arg0) == false, 6);
        let v0 = AgentNFT{
            id                    : 0x2::object::new(arg5),
            controller            : 0x2::tx_context::sender(arg5),
            version               : arg3,
            strategy_type         : arg2,
            strategy_blob_id      : arg0,
            strategy_content_root : arg1,
            memories              : 0x2::bag::new(arg5),
            last_execute_ms       : 0,
        };
        let v1 = AgentCreated{
            agent_id      : 0x2::object::id<AgentNFT>(&v0),
            controller    : v0.controller,
            strategy_type : arg2,
        };
        0x2::event::emit<AgentCreated>(v1);
        v0
    }

    public fun create_memory(arg0: 0x1::string::String, arg1: vector<u8>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : MemoryNFT {
        assert!(0x1::string::is_empty(&arg0) == false, 6);
        let v0 = MemoryNFT{
            id                : 0x2::object::new(arg4),
            author            : 0x2::tx_context::sender(arg4),
            blob_id           : arg0,
            content_root_hash : arg1,
            schema_version    : arg2,
            created_at        : 0x2::clock::timestamp_ms(arg3),
        };
        let v1 = MemoryCreated{
            memory_id      : 0x2::object::id<MemoryNFT>(&v0),
            author         : v0.author,
            blob_id        : v0.blob_id,
            schema_version : arg2,
        };
        0x2::event::emit<MemoryCreated>(v1);
        v0
    }

    public fun destroy_agent(arg0: AgentNFT, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::bag::is_empty(&arg0.memories), 2);
        let AgentNFT {
            id                    : v0,
            controller            : _,
            version               : _,
            strategy_type         : _,
            strategy_blob_id      : _,
            strategy_content_root : _,
            memories              : v6,
            last_execute_ms       : _,
        } = arg0;
        0x2::bag::destroy_empty(v6);
        let v8 = AgentDestroyed{
            agent_id : 0x2::object::id<AgentNFT>(&arg0),
            by       : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<AgentDestroyed>(v8);
        0x2::object::delete(v0);
    }

    public fun destroy_memory(arg0: MemoryNFT) {
        let MemoryNFT {
            id                : v0,
            author            : _,
            blob_id           : _,
            content_root_hash : _,
            schema_version    : _,
            created_at        : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun detach(arg0: &mut AgentNFT, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : MemoryNFT {
        assert!(0x2::tx_context::sender(arg2) == arg0.controller, 1);
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.memories, arg1), 5);
        let v0 = 0x2::bag::remove<0x1::string::String, MemoryNFT>(&mut arg0.memories, arg1);
        let v1 = MemoryDetached{
            agent_id  : 0x2::object::id<AgentNFT>(arg0),
            memory_id : 0x2::object::id<MemoryNFT>(&v0),
            name      : arg1,
            by        : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<MemoryDetached>(v1);
        v0
    }

    public fun execute_strategy(arg0: &mut AgentNFT, arg1: &PoolWhitelist, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.controller, 1);
        assert!(0x1::vector::contains<address>(&arg1.pools, &arg2), 8);
        assert!(arg3 <= arg1.per_execute_cap_mist, 7);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg0.last_execute_ms == 0 || v0 >= arg0.last_execute_ms + arg1.per_execute_window_ms, 9);
        arg0.last_execute_ms = v0;
        let v1 = AgentExecuted{
            agent_id    : 0x2::object::id<AgentNFT>(arg0),
            controller  : 0x2::tx_context::sender(arg5),
            amount_mist : arg3,
            pool        : arg2,
            ts_ms       : v0,
        };
        0x2::event::emit<AgentExecuted>(v1);
    }

    public fun execute_strategy_b(arg0: &mut AgentNFT, arg1: &AdminBoundWhitelist, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.controller, 1);
        assert!(0x1::vector::contains<address>(&arg1.pools, &arg2), 8);
        assert!(arg3 <= arg1.per_execute_cap_mist, 7);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg0.last_execute_ms == 0 || v0 >= arg0.last_execute_ms + arg1.per_execute_window_ms, 9);
        arg0.last_execute_ms = v0;
        let v1 = AgentExecuted{
            agent_id    : 0x2::object::id<AgentNFT>(arg0),
            controller  : 0x2::tx_context::sender(arg5),
            amount_mist : arg3,
            pool        : arg2,
            ts_ms       : v0,
        };
        0x2::event::emit<AgentExecuted>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = PoolWhitelist{
            id                    : 0x2::object::new(arg0),
            pools                 : vector[],
            per_execute_cap_mist  : 1000000000,
            per_execute_window_ms : 60000,
        };
        0x2::transfer::share_object<PoolWhitelist>(v1);
    }

    public fun memory_author(arg0: &MemoryNFT) : address {
        arg0.author
    }

    public fun memory_blob(arg0: &MemoryNFT) : 0x1::string::String {
        arg0.blob_id
    }

    public fun memory_created(arg0: &MemoryNFT) : u64 {
        arg0.created_at
    }

    public fun memory_root(arg0: &MemoryNFT) : vector<u8> {
        arg0.content_root_hash
    }

    public fun memory_schema(arg0: &MemoryNFT) : u8 {
        arg0.schema_version
    }

    public fun public_transfer_agent(arg0: AgentNFT, arg1: address) {
        0x2::transfer::public_transfer<AgentNFT>(arg0, arg1);
    }

    public fun set_caps(arg0: &mut PoolWhitelist, arg1: u64, arg2: u64, arg3: &AdminCap) {
        arg0.per_execute_cap_mist = arg1;
        arg0.per_execute_window_ms = arg2;
    }

    public fun set_caps_b(arg0: &mut AdminBoundWhitelist, arg1: u64, arg2: u64, arg3: &AdminCap, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<AdminCap>(arg3) == arg0.admin, 10);
        arg0.per_execute_cap_mist = arg1;
        arg0.per_execute_window_ms = arg2;
        let v0 = BoundCapsUpdated{
            whitelist_id          : 0x2::object::id<AdminBoundWhitelist>(arg0),
            per_execute_cap_mist  : arg1,
            per_execute_window_ms : arg2,
            by                    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<BoundCapsUpdated>(v0);
    }

    public fun set_controller(arg0: &mut AgentNFT, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.controller, 1);
        arg0.controller = arg1;
        let v0 = ControllerUpdated{
            agent_id   : 0x2::object::id<AgentNFT>(arg0),
            controller : arg1,
            by         : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ControllerUpdated>(v0);
    }

    public fun setup_bound_whitelist(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = 0x2::object::id<AdminCap>(&v0);
        let v2 = AdminBoundWhitelist{
            id                    : 0x2::object::new(arg0),
            pools                 : vector[],
            per_execute_cap_mist  : 1000000000,
            per_execute_window_ms : 60000,
            admin                 : v1,
        };
        let v3 = BoundWhitelistCreated{
            whitelist_id : 0x2::object::id<AdminBoundWhitelist>(&v2),
            admin        : v1,
        };
        0x2::event::emit<BoundWhitelistCreated>(v3);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<AdminBoundWhitelist>(v2);
    }

    public fun setup_composable(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = PoolWhitelist{
            id                    : 0x2::object::new(arg0),
            pools                 : vector[],
            per_execute_cap_mist  : 1000000000,
            per_execute_window_ms : 60000,
        };
        0x2::transfer::share_object<PoolWhitelist>(v1);
    }

    public fun strategy_type_alarm_only() : u8 {
        4
    }

    public fun strategy_type_clmm_range() : u8 {
        3
    }

    public fun strategy_type_dlmm_range() : u8 {
        1
    }

    public fun strategy_type_dlmm_rebalance() : u8 {
        2
    }

    public fun unwhitelist_pool(arg0: &mut PoolWhitelist, arg1: address, arg2: &AdminCap) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.pools)) {
            if (*0x1::vector::borrow<address>(&arg0.pools, v0) == arg1) {
                0x1::vector::remove<address>(&mut arg0.pools, v0);
                break
            };
            v0 = v0 + 1;
        };
    }

    public fun unwhitelist_pool_b(arg0: &mut AdminBoundWhitelist, arg1: address, arg2: &AdminCap, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<AdminCap>(arg2) == arg0.admin, 10);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.pools)) {
            if (*0x1::vector::borrow<address>(&arg0.pools, v0) == arg1) {
                0x1::vector::remove<address>(&mut arg0.pools, v0);
                let v1 = BoundPoolUnwhitelisted{
                    whitelist_id : 0x2::object::id<AdminBoundWhitelist>(arg0),
                    pool         : arg1,
                    by           : 0x2::tx_context::sender(arg3),
                };
                0x2::event::emit<BoundPoolUnwhitelisted>(v1);
                break
            };
            v0 = v0 + 1;
        };
    }

    public fun whitelist_cap_mist(arg0: &PoolWhitelist) : u64 {
        arg0.per_execute_cap_mist
    }

    public fun whitelist_pool(arg0: &mut PoolWhitelist, arg1: address, arg2: &AdminCap) {
        if (!0x1::vector::contains<address>(&arg0.pools, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.pools, arg1);
        };
    }

    public fun whitelist_pool_b(arg0: &mut AdminBoundWhitelist, arg1: address, arg2: &AdminCap, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<AdminCap>(arg2) == arg0.admin, 10);
        if (!0x1::vector::contains<address>(&arg0.pools, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.pools, arg1);
            let v0 = BoundPoolWhitelisted{
                whitelist_id : 0x2::object::id<AdminBoundWhitelist>(arg0),
                pool         : arg1,
                by           : 0x2::tx_context::sender(arg3),
            };
            0x2::event::emit<BoundPoolWhitelisted>(v0);
        };
    }

    public fun whitelist_pools(arg0: &PoolWhitelist) : vector<address> {
        arg0.pools
    }

    public fun whitelist_window_ms(arg0: &PoolWhitelist) : u64 {
        arg0.per_execute_window_ms
    }

    // decompiled from Move bytecode v7
}

