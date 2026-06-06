module 0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::lighthouse {
    struct Lighthouse has key {
        id: 0x2::object::UID,
        cast_id: 0x2::object::ID,
        vessel_id: 0x2::object::ID,
        content_blob: vector<u8>,
        created_at: u64,
        last_visit: u64,
        visit_count: u64,
        birth_path: u8,
    }

    struct GenesisLighthouse has key {
        id: 0x2::object::UID,
        message: vector<u8>,
        content_blob: vector<u8>,
        placed_at: u64,
        placed_by: address,
        visit_count: u64,
    }

    struct LighthouseStands has copy, drop {
        lighthouse_id: address,
        cast_id: address,
        vessel_id: address,
        birth_path: u8,
        total_reads: u64,
        stands_at: u64,
    }

    struct LighthouseVisited has copy, drop {
        lighthouse_id: address,
        visit_count: u64,
        visited_at: u64,
        expires_at: u64,
    }

    struct LighthouseFallen has copy, drop {
        lighthouse_id: address,
        visit_count: u64,
        stood_for_ms: u64,
        fallen_at: u64,
    }

    struct GenesisPlaced has copy, drop {
        lighthouse_id: address,
        placed_by: address,
        placed_at: u64,
    }

    struct GenesisVisited has copy, drop {
        lighthouse_id: address,
        visit_count: u64,
        visited_at: u64,
    }

    public fun vessel_id(arg0: &Lighthouse) : 0x2::object::ID {
        arg0.vessel_id
    }

    public fun birth_path(arg0: &Lighthouse) : u8 {
        arg0.birth_path
    }

    public fun cast_id(arg0: &Lighthouse) : 0x2::object::ID {
        arg0.cast_id
    }

    public fun expires_at(arg0: &Lighthouse) : u64 {
        arg0.last_visit + 3153600000000
    }

    public fun genesis_message(arg0: &GenesisLighthouse) : vector<u8> {
        arg0.message
    }

    public fun genesis_visits(arg0: &GenesisLighthouse) : u64 {
        arg0.visit_count
    }

    public fun kill(arg0: Lighthouse, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1) >= 1000000000000, 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::object::id<Lighthouse>(&arg0);
        let Lighthouse {
            id           : v2,
            cast_id      : _,
            vessel_id    : _,
            content_blob : _,
            created_at   : _,
            last_visit   : _,
            visit_count  : _,
            birth_path   : _,
        } = arg0;
        0x2::object::delete(v2);
        let v10 = LighthouseFallen{
            lighthouse_id : 0x2::object::id_to_address(&v1),
            visit_count   : arg0.visit_count,
            stood_for_ms  : v0 - arg0.created_at,
            fallen_at     : v0,
        };
        0x2::event::emit<LighthouseFallen>(v10);
        arg1
    }

    public fun kill_cost() : u64 {
        1000000000000
    }

    public fun last_visit(arg0: &Lighthouse) : u64 {
        arg0.last_visit
    }

    public fun lh_lifespan_ms() : u64 {
        3153600000000
    }

    public fun path_genesis() : u8 {
        0
    }

    public fun path_million() : u8 {
        1
    }

    public fun path_tides() : u8 {
        2
    }

    public fun place_genesis(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = GenesisLighthouse{
            id           : 0x2::object::new(arg3),
            message      : arg0,
            content_blob : arg1,
            placed_at    : v1,
            placed_by    : v0,
            visit_count  : 0,
        };
        let v3 = 0x2::object::id<GenesisLighthouse>(&v2);
        let v4 = GenesisPlaced{
            lighthouse_id : 0x2::object::id_to_address(&v3),
            placed_by     : v0,
            placed_at     : v1,
        };
        0x2::event::emit<GenesisPlaced>(v4);
        0x2::transfer::share_object<GenesisLighthouse>(v2);
    }

    public fun raise(arg0: &0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::cast::Cast, arg1: &mut 0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::vessel::Vessel, arg2: &0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::vessel::VesselCap, arg3: &mut 0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::registry::LighthouseRegistry, arg4: &mut 0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::drift::Drift, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::cast::is_lighthouse(arg0), 3);
        assert!(0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::cast::vessel_id(arg0) == 0x2::object::id<0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::vessel::Vessel>(arg1), 4);
        let v0 = 0x2::object::id<0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::cast::Cast>(arg0);
        let v1 = 0x2::object::id<0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::vessel::Vessel>(arg1);
        let v2 = 0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::cast::lighthouse_path(arg0);
        let v3 = 0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::cast::read_count(arg0);
        let v4 = 0x2::clock::timestamp_ms(arg5);
        0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::vessel::record_lighthouse(arg1, arg2, arg5);
        let v5 = Lighthouse{
            id           : 0x2::object::new(arg6),
            cast_id      : v0,
            vessel_id    : v1,
            content_blob : 0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::cast::content_blob(arg0),
            created_at   : v4,
            last_visit   : v4,
            visit_count  : v3,
            birth_path   : v2,
        };
        let v6 = 0x2::object::id<Lighthouse>(&v5);
        let v7 = 0x2::object::id_to_address(&v6);
        let v8 = 0x2::object::id_to_address(&v0);
        let v9 = LighthouseStands{
            lighthouse_id : v7,
            cast_id       : v8,
            vessel_id     : 0x2::object::id_to_address(&v1),
            birth_path    : v2,
            total_reads   : v3,
            stands_at     : v4,
        };
        0x2::event::emit<LighthouseStands>(v9);
        0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::registry::register(arg3, v0, v1, v6, v2, v3, v4);
        0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::drift::index_lighthouse(arg4, v8, v7, v2, arg5, arg6);
        0x2::transfer::share_object<Lighthouse>(v5);
    }

    public fun visit(arg0: &mut Lighthouse, arg1: &mut 0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::registry::LighthouseRegistry, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0.visit_count = arg0.visit_count + 1;
        arg0.last_visit = v0;
        let v1 = 0x2::object::id<Lighthouse>(arg0);
        let v2 = LighthouseVisited{
            lighthouse_id : 0x2::object::id_to_address(&v1),
            visit_count   : arg0.visit_count,
            visited_at    : v0,
            expires_at    : v0 + 3153600000000,
        };
        0x2::event::emit<LighthouseVisited>(v2);
        0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::registry::record_visit(arg1, arg0.cast_id, 0x2::object::id<Lighthouse>(arg0), arg0.visit_count, v0);
    }

    public fun visit_count(arg0: &Lighthouse) : u64 {
        arg0.visit_count
    }

    public fun visit_genesis(arg0: &mut GenesisLighthouse, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        arg0.visit_count = arg0.visit_count + 1;
        let v0 = 0x2::object::id<GenesisLighthouse>(arg0);
        let v1 = GenesisVisited{
            lighthouse_id : 0x2::object::id_to_address(&v0),
            visit_count   : arg0.visit_count,
            visited_at    : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<GenesisVisited>(v1);
    }

    // decompiled from Move bytecode v7
}

