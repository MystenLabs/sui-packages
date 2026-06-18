module 0xeef943421fb0efe05ddc69d5e657256022bb18e8b56c03735e00d3141b7d20b::market_registry {
    struct MarketRegistry has store, key {
        id: 0x2::object::UID,
        next_project_id: u64,
        project_count: u64,
        market_count: u64,
        market_ids: vector<0x2::object::ID>,
    }

    struct ProjectKey has copy, drop, store {
        pos0: u64,
    }

    struct MarketKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct Project has copy, drop, store {
        project_id: u64,
        owner: address,
        name: vector<u8>,
        metadata_uri: vector<u8>,
        rewards_enabled: bool,
        reward_distributor_id: 0x2::object::ID,
    }

    struct MarketRecord has copy, drop, store {
        project_id: u64,
        market_id: 0x2::object::ID,
        py_state_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        pt_orderbook_id: 0x2::object::ID,
        yt_orderbook_id: 0x2::object::ID,
        reward_distributor_id: 0x2::object::ID,
        expiry: u64,
    }

    struct ProjectRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        project_id: u64,
        owner: address,
        name: vector<u8>,
        metadata_uri: vector<u8>,
        rewards_enabled: bool,
        reward_distributor_id: 0x2::object::ID,
    }

    struct ProjectRewardsUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        project_id: u64,
        rewards_enabled: bool,
        reward_distributor_id: 0x2::object::ID,
    }

    struct MarketRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        project_id: u64,
        market_id: 0x2::object::ID,
        py_state_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        reward_distributor_id: 0x2::object::ID,
        expiry: u64,
    }

    struct MarketOrderbookUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        pt_orderbook_id: 0x2::object::ID,
        yt_orderbook_id: 0x2::object::ID,
    }

    public fun id(arg0: &MarketRegistry) : 0x2::object::ID {
        0x2::object::id<MarketRegistry>(arg0)
    }

    fun assert_market_core_record<T0: drop, T1: drop, T2: drop>(arg0: &MarketRecord, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::market::Market<T0, T1, T2>, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>) {
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::market::id<T0, T1, T2>(arg1);
        assert!(arg0.market_id == v0, 3203);
        assert!(arg0.py_state_id == 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg2), 3203);
        assert!(arg0.pool_id == 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg3), 3203);
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::market_id<T0>(arg2) == v0, 3203);
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::market_id<T0>(arg3) == v0, 3203);
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::py_state_id<T0>(arg3) == 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg2), 3203);
    }

    fun assert_project_reward_config<T0: drop, T1: drop, T2: drop>(arg0: &MarketRegistry, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::market::Market<T0, T1, T2>, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>) : 0x2::object::ID {
        let v0 = market_record(arg0, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::market::id<T0, T1, T2>(arg1));
        assert_market_core_record<T0, T1, T2>(&v0, arg1, arg2, arg3);
        let v1 = project(arg0, v0.project_id);
        assert!(v1.rewards_enabled, 3204);
        assert!(v0.reward_distributor_id == v1.reward_distributor_id, 3205);
        v1.reward_distributor_id
    }

    fun borrow_market_record_mut(arg0: &mut MarketRegistry, arg1: 0x2::object::ID) : &mut MarketRecord {
        assert!(market_registered(arg0, arg1), 3202);
        let v0 = MarketKey{pos0: arg1};
        0x2::dynamic_field::borrow_mut<MarketKey, MarketRecord>(&mut arg0.id, v0)
    }

    fun create(arg0: &mut 0x2::tx_context::TxContext) : MarketRegistry {
        MarketRegistry{
            id              : 0x2::object::new(arg0),
            next_project_id : 1,
            project_count   : 0,
            market_count    : 0,
            market_ids      : 0x1::vector::empty<0x2::object::ID>(),
        }
    }

    public fun create_and_share_by_admin(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let v0 = create(arg2);
        0x2::transfer::share_object<MarketRegistry>(v0);
        0x2::object::id<MarketRegistry>(&v0)
    }

    public fun create_by_admin(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) : MarketRegistry {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        create(arg2)
    }

    public fun market_count(arg0: &MarketRegistry) : u64 {
        arg0.market_count
    }

    public fun market_id_at(arg0: &MarketRegistry, arg1: u64) : 0x2::object::ID {
        assert!(arg1 < 0x1::vector::length<0x2::object::ID>(&arg0.market_ids), 3207);
        *0x1::vector::borrow<0x2::object::ID>(&arg0.market_ids, arg1)
    }

    public fun market_ids(arg0: &MarketRegistry) : vector<0x2::object::ID> {
        arg0.market_ids
    }

    public fun market_project_id(arg0: &MarketRegistry, arg1: 0x2::object::ID) : u64 {
        let v0 = market_record(arg0, arg1);
        v0.project_id
    }

    public fun market_record(arg0: &MarketRegistry, arg1: 0x2::object::ID) : MarketRecord {
        assert!(market_registered(arg0, arg1), 3202);
        let v0 = MarketKey{pos0: arg1};
        *0x2::dynamic_field::borrow<MarketKey, MarketRecord>(&arg0.id, v0)
    }

    public fun market_record_at(arg0: &MarketRegistry, arg1: u64) : MarketRecord {
        market_record(arg0, market_id_at(arg0, arg1))
    }

    public fun market_registered(arg0: &MarketRegistry, arg1: 0x2::object::ID) : bool {
        let v0 = MarketKey{pos0: arg1};
        0x2::dynamic_field::exists<MarketKey>(&arg0.id, v0)
    }

    public fun market_reward_distributor_id(arg0: &MarketRegistry, arg1: 0x2::object::ID) : 0x2::object::ID {
        let v0 = market_record(arg0, arg1);
        v0.reward_distributor_id
    }

    public fun none_id() : 0x2::object::ID {
        0x2::object::id_from_address(@0x0)
    }

    public fun project(arg0: &MarketRegistry, arg1: u64) : Project {
        assert!(project_exists(arg0, arg1), 3200);
        let v0 = ProjectKey{pos0: arg1};
        *0x2::dynamic_field::borrow<ProjectKey, Project>(&arg0.id, v0)
    }

    public fun project_count(arg0: &MarketRegistry) : u64 {
        arg0.project_count
    }

    public fun project_exists(arg0: &MarketRegistry, arg1: u64) : bool {
        let v0 = ProjectKey{pos0: arg1};
        0x2::dynamic_field::exists<ProjectKey>(&arg0.id, v0)
    }

    public fun project_id_at(arg0: &MarketRegistry, arg1: u64) : u64 {
        assert!(arg1 < arg0.project_count, 3207);
        arg1 + 1
    }

    public fun project_reward_distributor_id(arg0: &MarketRegistry, arg1: u64) : 0x2::object::ID {
        let v0 = project(arg0, arg1);
        v0.reward_distributor_id
    }

    public fun project_rewards_enabled(arg0: &MarketRegistry, arg1: u64) : bool {
        let v0 = project(arg0, arg1);
        v0.rewards_enabled
    }

    fun register_market<T0: drop, T1: drop, T2: drop>(arg0: &mut MarketRegistry, arg1: u64, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::market::Market<T0, T1, T2>, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg4: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>) {
        assert!(project_exists(arg0, arg1), 3200);
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::market::id<T0, T1, T2>(arg2);
        assert!(!market_registered(arg0, v0), 3201);
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::market_id<T0>(arg3) == v0, 3203);
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::market_id<T0>(arg4) == v0, 3203);
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::py_state_id<T0>(arg4) == 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg3), 3203);
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::market::expiry<T0, T1, T2>(arg2) == 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::expiry<T0>(arg3), 3203);
        assert!(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::market::expiry<T0, T1, T2>(arg2) == 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::expiry<T0>(arg4), 3203);
        let v1 = project(arg0, arg1);
        let v2 = if (v1.rewards_enabled) {
            v1.reward_distributor_id
        } else {
            none_id()
        };
        let v3 = MarketRecord{
            project_id            : arg1,
            market_id             : v0,
            py_state_id           : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg3),
            pool_id               : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg4),
            pt_orderbook_id       : none_id(),
            yt_orderbook_id       : none_id(),
            reward_distributor_id : v2,
            expiry                : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::market::expiry<T0, T1, T2>(arg2),
        };
        let v4 = MarketKey{pos0: v0};
        0x2::dynamic_field::add<MarketKey, MarketRecord>(&mut arg0.id, v4, v3);
        arg0.market_count = arg0.market_count + 1;
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.market_ids, v0);
        let v5 = MarketRegistered{
            registry_id           : 0x2::object::id<MarketRegistry>(arg0),
            project_id            : arg1,
            market_id             : v0,
            py_state_id           : v3.py_state_id,
            pool_id               : v3.pool_id,
            reward_distributor_id : v2,
            expiry                : v3.expiry,
        };
        0x2::event::emit<MarketRegistered>(v5);
    }

    public fun register_market_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &mut MarketRegistry, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: u64, arg4: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::market::Market<T0, T1, T2>, arg5: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg6: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg1);
        register_market<T0, T1, T2>(arg0, arg3, arg4, arg5, arg6);
    }

    fun register_project(arg0: &mut MarketRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: bool, arg4: 0x2::object::ID, arg5: address) : u64 {
        if (arg3) {
            assert!(arg4 != none_id(), 3204);
        };
        let v0 = arg0.next_project_id;
        assert!(v0 > 0, 3206);
        arg0.next_project_id = v0 + 1;
        arg0.project_count = arg0.project_count + 1;
        let v1 = ProjectKey{pos0: v0};
        let v2 = Project{
            project_id            : v0,
            owner                 : arg5,
            name                  : arg1,
            metadata_uri          : arg2,
            rewards_enabled       : arg3,
            reward_distributor_id : arg4,
        };
        0x2::dynamic_field::add<ProjectKey, Project>(&mut arg0.id, v1, v2);
        let v3 = ProjectRegistered{
            registry_id           : 0x2::object::id<MarketRegistry>(arg0),
            project_id            : v0,
            owner                 : arg5,
            name                  : arg1,
            metadata_uri          : arg2,
            rewards_enabled       : arg3,
            reward_distributor_id : arg4,
        };
        0x2::event::emit<ProjectRegistered>(v3);
        v0
    }

    public fun register_project_by_admin(arg0: &mut MarketRegistry, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: vector<u8>, arg4: vector<u8>, arg5: bool, arg6: 0x2::object::ID, arg7: &0x2::tx_context::TxContext) : u64 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg1);
        register_project(arg0, arg3, arg4, arg5, arg6, 0x2::tx_context::sender(arg7))
    }

    public fun require_market_reward_gates_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &MarketRegistry, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::market::Market<T0, T1, T2>, arg4: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg5: &mut 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg1);
        let v0 = assert_project_reward_config<T0, T1, T2>(arg0, arg3, arg4, arg5);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::require_yt_reward_distributor_by_admin<T0>(arg4, arg1, v0, arg2);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::require_reward_distributor_by_admin<T0>(arg5, arg1, v0, arg2);
    }

    fun set_project_rewards(arg0: &mut MarketRegistry, arg1: u64, arg2: bool, arg3: 0x2::object::ID) {
        if (arg2) {
            assert!(arg3 != none_id(), 3204);
        };
        assert!(project_exists(arg0, arg1), 3200);
        let v0 = ProjectKey{pos0: arg1};
        let v1 = 0x2::dynamic_field::borrow_mut<ProjectKey, Project>(&mut arg0.id, v0);
        v1.rewards_enabled = arg2;
        v1.reward_distributor_id = arg3;
        let v2 = ProjectRewardsUpdated{
            registry_id           : 0x2::object::id<MarketRegistry>(arg0),
            project_id            : arg1,
            rewards_enabled       : arg2,
            reward_distributor_id : arg3,
        };
        0x2::event::emit<ProjectRewardsUpdated>(v2);
    }

    public fun set_project_rewards_by_admin(arg0: &mut MarketRegistry, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: u64, arg4: bool, arg5: 0x2::object::ID) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg1);
        set_project_rewards(arg0, arg3, arg4, arg5);
    }

    public fun set_pt_orderbook_id_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &mut MarketRegistry, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::market::Market<T0, T1, T2>, arg4: 0x2::object::ID) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg1);
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::market::id<T0, T1, T2>(arg3);
        let v1 = 0x2::object::id<MarketRegistry>(arg0);
        let v2 = borrow_market_record_mut(arg0, v0);
        v2.pt_orderbook_id = arg4;
        let v3 = MarketOrderbookUpdated{
            registry_id     : v1,
            market_id       : v0,
            pt_orderbook_id : v2.pt_orderbook_id,
            yt_orderbook_id : v2.yt_orderbook_id,
        };
        0x2::event::emit<MarketOrderbookUpdated>(v3);
    }

    public fun set_yt_orderbook_id_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &mut MarketRegistry, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::market::Market<T0, T1, T2>, arg4: 0x2::object::ID) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg1);
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::market::id<T0, T1, T2>(arg3);
        let v1 = 0x2::object::id<MarketRegistry>(arg0);
        let v2 = borrow_market_record_mut(arg0, v0);
        v2.yt_orderbook_id = arg4;
        let v3 = MarketOrderbookUpdated{
            registry_id     : v1,
            market_id       : v0,
            pt_orderbook_id : v2.pt_orderbook_id,
            yt_orderbook_id : v2.yt_orderbook_id,
        };
        0x2::event::emit<MarketOrderbookUpdated>(v3);
    }

    // decompiled from Move bytecode v7
}

