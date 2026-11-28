module 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry {
    struct SetupCap has store, key {
        id: 0x2::object::UID,
    }

    struct ConvertAdminCap has store, key {
        id: 0x2::object::UID,
        registry: 0x2::object::ID,
    }

    struct Entry has copy, drop, store {
        kind: u8,
        decimals: u8,
        feed_id: vector<u8>,
        max_age_s: u64,
        tolerance_bps: u64,
        cap_micros: u64,
        enabled: bool,
    }

    struct RouteKey has copy, drop, store {
        from: 0x1::type_name::TypeName,
        to: 0x1::type_name::TypeName,
    }

    struct Route has copy, drop, store {
        cost_bps: u64,
        dust_micros: u64,
        pools: vector<0x2::object::ID>,
        enabled: bool,
    }

    struct PendingRoute has copy, drop, store {
        route: Route,
        effective_ms: u64,
    }

    struct Pending has copy, drop, store {
        entry: Entry,
        effective_ms: u64,
    }

    struct PendingDelay has copy, drop, store {
        delay_ms: u64,
        effective_ms: u64,
    }

    struct ConvertRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        delay_ms: u64,
        entries: 0x2::table::Table<0x1::type_name::TypeName, Entry>,
        pending: 0x2::table::Table<0x1::type_name::TypeName, Pending>,
        pending_delay: 0x1::option::Option<PendingDelay>,
        routes: 0x2::table::Table<RouteKey, Route>,
        pending_routes: 0x2::table::Table<RouteKey, PendingRoute>,
    }

    struct MinVersionsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PendingMinVersionsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PendingMinVersion has copy, drop, store {
        version: u64,
        effective_ms: u64,
    }

    struct RegistryCreated has copy, drop {
        registry: 0x2::object::ID,
        delay_ms: u64,
    }

    struct MinVersionChanged has copy, drop {
        adapter: 0x1::type_name::TypeName,
        version: u64,
    }

    struct MinVersionChangeProposed has copy, drop {
        adapter: 0x1::type_name::TypeName,
        version: u64,
        effective_ms: u64,
    }

    struct CoinChanged has copy, drop {
        coin: 0x1::type_name::TypeName,
        entry: Entry,
        at_ms: u64,
    }

    struct CoinChangeProposed has copy, drop {
        coin: 0x1::type_name::TypeName,
        entry: Entry,
        effective_ms: u64,
    }

    struct DelayChanged has copy, drop {
        delay_ms: u64,
    }

    struct RouteChanged has copy, drop {
        key: RouteKey,
        route: Route,
        at_ms: u64,
    }

    struct RouteChangeProposed has copy, drop {
        key: RouteKey,
        route: Route,
        effective_ms: u64,
    }

    struct DelayChangeProposed has copy, drop {
        delay_ms: u64,
        effective_ms: u64,
    }

    public fun allowance_micros(arg0: &Route, arg1: u64) : u64 {
        (((arg1 as u128) * (arg0.cost_bps as u128) / 10000) as u64) + arg0.dust_micros
    }

    public fun apply_coin<T0>(arg0: &mut ConvertRegistry, arg1: &0x2::clock::Clock) {
        check_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Pending>(&arg0.pending, v0), 2);
        let v1 = 0x2::table::remove<0x1::type_name::TypeName, Pending>(&mut arg0.pending, v0);
        assert!(0x2::clock::timestamp_ms(arg1) >= v1.effective_ms, 3);
        if (0x2::table::contains<0x1::type_name::TypeName, Entry>(&arg0.entries, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, Entry>(&mut arg0.entries, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, Entry>(&mut arg0.entries, v0, v1.entry);
        let v2 = CoinChanged{
            coin  : v0,
            entry : v1.entry,
            at_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<CoinChanged>(v2);
    }

    public fun apply_delay(arg0: &mut ConvertRegistry, arg1: &0x2::clock::Clock) {
        check_version(arg0);
        assert!(0x1::option::is_some<PendingDelay>(&arg0.pending_delay), 2);
        let v0 = 0x1::option::extract<PendingDelay>(&mut arg0.pending_delay);
        assert!(0x2::clock::timestamp_ms(arg1) >= v0.effective_ms, 3);
        arg0.delay_ms = v0.delay_ms;
        let v1 = DelayChanged{delay_ms: arg0.delay_ms};
        0x2::event::emit<DelayChanged>(v1);
    }

    public fun apply_min_version<T0>(arg0: &mut ConvertRegistry, arg1: &0x2::clock::Clock) {
        check_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = PendingMinVersionsKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<PendingMinVersionsKey>(&arg0.id, v1), 2);
        let v2 = PendingMinVersionsKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<PendingMinVersionsKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, PendingMinVersion>>(&mut arg0.id, v2);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, PendingMinVersion>(v3, &v0), 2);
        let (_, v5) = 0x2::vec_map::remove<0x1::type_name::TypeName, PendingMinVersion>(v3, &v0);
        let v6 = v5;
        assert!(0x2::clock::timestamp_ms(arg1) >= v6.effective_ms, 3);
        put_min(arg0, v0, v6.version);
        let v7 = MinVersionChanged{
            adapter : v0,
            version : v6.version,
        };
        0x2::event::emit<MinVersionChanged>(v7);
    }

    public fun apply_route<T0, T1>(arg0: &mut ConvertRegistry, arg1: &0x2::clock::Clock) {
        check_version(arg0);
        let v0 = route_key<T0, T1>();
        assert!(0x2::table::contains<RouteKey, PendingRoute>(&arg0.pending_routes, v0), 2);
        let v1 = 0x2::table::remove<RouteKey, PendingRoute>(&mut arg0.pending_routes, v0);
        assert!(0x2::clock::timestamp_ms(arg1) >= v1.effective_ms, 3);
        if (0x2::table::contains<RouteKey, Route>(&arg0.routes, v0)) {
            0x2::table::remove<RouteKey, Route>(&mut arg0.routes, v0);
        };
        0x2::table::add<RouteKey, Route>(&mut arg0.routes, v0, v1.route);
        let v2 = RouteChanged{
            key   : v0,
            route : v1.route,
            at_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<RouteChanged>(v2);
    }

    public fun assert_adapter_version<T0>(arg0: &ConvertRegistry, arg1: u64) {
        assert!(arg1 >= min_version<T0>(arg0), 13);
    }

    public fun cap_micros(arg0: &Entry) : u64 {
        arg0.cap_micros
    }

    fun check_cap(arg0: &ConvertAdminCap, arg1: &ConvertRegistry) {
        assert!(arg0.registry == 0x2::object::id<ConvertRegistry>(arg1), 8);
    }

    fun check_entry(arg0: &Entry) {
        assert!(arg0.kind == 0 || arg0.kind == 1, 4);
        assert!(arg0.decimals <= 18 && arg0.tolerance_bps <= 1000, 4);
        assert!(arg0.kind == 0 || !0x1::vector::is_empty<u8>(&arg0.feed_id) && arg0.max_age_s > 0, 4);
    }

    fun check_route(arg0: &Route) {
        assert!(arg0.cost_bps <= 200 && arg0.dust_micros <= 250000, 9);
    }

    fun check_version(arg0: &ConvertRegistry) {
        assert!(arg0.version == 1, 12);
    }

    public fun cost_bps(arg0: &Route) : u64 {
        arg0.cost_bps
    }

    public fun create(arg0: SetupCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : ConvertAdminCap {
        assert!(arg1 >= 300000, 11);
        let SetupCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = ConvertRegistry{
            id             : 0x2::object::new(arg2),
            version        : 1,
            delay_ms       : arg1,
            entries        : 0x2::table::new<0x1::type_name::TypeName, Entry>(arg2),
            pending        : 0x2::table::new<0x1::type_name::TypeName, Pending>(arg2),
            pending_delay  : 0x1::option::none<PendingDelay>(),
            routes         : 0x2::table::new<RouteKey, Route>(arg2),
            pending_routes : 0x2::table::new<RouteKey, PendingRoute>(arg2),
        };
        let v2 = 0x2::object::id<ConvertRegistry>(&v1);
        let v3 = RegistryCreated{
            registry : v2,
            delay_ms : arg1,
        };
        0x2::event::emit<RegistryCreated>(v3);
        0x2::transfer::share_object<ConvertRegistry>(v1);
        ConvertAdminCap{
            id       : 0x2::object::new(arg2),
            registry : v2,
        }
    }

    public fun decimals(arg0: &Entry) : u8 {
        arg0.decimals
    }

    public fun delay_ms(arg0: &ConvertRegistry) : u64 {
        arg0.delay_ms
    }

    public fun disable_coin<T0>(arg0: &ConvertAdminCap, arg1: &mut ConvertRegistry, arg2: &0x2::clock::Clock) {
        check_cap(arg0, arg1);
        check_version(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Entry>(&arg1.entries, v0), 5);
        let v1 = *0x2::table::borrow<0x1::type_name::TypeName, Entry>(&arg1.entries, v0);
        v1.enabled = false;
        *0x2::table::borrow_mut<0x1::type_name::TypeName, Entry>(&mut arg1.entries, v0) = v1;
        if (0x2::table::contains<0x1::type_name::TypeName, Pending>(&arg1.pending, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, Pending>(&mut arg1.pending, v0);
        };
        let v2 = CoinChanged{
            coin  : v0,
            entry : v1,
            at_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<CoinChanged>(v2);
    }

    public fun disable_route<T0, T1>(arg0: &ConvertAdminCap, arg1: &mut ConvertRegistry, arg2: &0x2::clock::Clock) {
        check_cap(arg0, arg1);
        check_version(arg1);
        let v0 = route_key<T0, T1>();
        assert!(0x2::table::contains<RouteKey, Route>(&arg1.routes, v0), 10);
        let v1 = *0x2::table::borrow<RouteKey, Route>(&arg1.routes, v0);
        v1.enabled = false;
        *0x2::table::borrow_mut<RouteKey, Route>(&mut arg1.routes, v0) = v1;
        if (0x2::table::contains<RouteKey, PendingRoute>(&arg1.pending_routes, v0)) {
            0x2::table::remove<RouteKey, PendingRoute>(&mut arg1.pending_routes, v0);
        };
        let v2 = RouteChanged{
            key   : v0,
            route : v1,
            at_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RouteChanged>(v2);
    }

    public fun dollar_entry<T0>(arg0: &ConvertRegistry) : Entry {
        let v0 = enabled_entry<T0>(arg0);
        assert!(v0.kind == 0, 7);
        v0
    }

    public fun dollar_micros(arg0: &Entry, arg1: u64) : u64 {
        let v0 = (arg0.decimals as u64);
        if (v0 >= 6) {
            arg1 / pow10(v0 - 6)
        } else {
            (((arg1 as u128) * (pow10(6 - v0) as u128)) as u64)
        }
    }

    fun drop_pending_min(arg0: &mut ConvertRegistry, arg1: 0x1::type_name::TypeName) {
        let v0 = PendingMinVersionsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<PendingMinVersionsKey>(&arg0.id, v0)) {
            return
        };
        let v1 = PendingMinVersionsKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<PendingMinVersionsKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, PendingMinVersion>>(&mut arg0.id, v1);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, PendingMinVersion>(v2, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, PendingMinVersion>(v2, &arg1);
        };
    }

    public fun dust_micros(arg0: &Route) : u64 {
        arg0.dust_micros
    }

    public fun enabled(arg0: &Entry) : bool {
        arg0.enabled
    }

    public fun enabled_entry<T0>(arg0: &ConvertRegistry) : Entry {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Entry>(&arg0.entries, v0), 5);
        let v1 = *0x2::table::borrow<0x1::type_name::TypeName, Entry>(&arg0.entries, v0);
        assert!(v1.enabled, 6);
        v1
    }

    public fun feed_id(arg0: &Entry) : vector<u8> {
        arg0.feed_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SetupCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SetupCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_route_tightening(arg0: &Route, arg1: &Route) : bool {
        if (arg1.cost_bps <= arg0.cost_bps) {
            if (arg1.dust_micros <= arg0.dust_micros) {
                if (is_subset(&arg1.pools, &arg0.pools)) {
                    arg0.enabled || !arg1.enabled
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    fun is_subset(arg0: &vector<0x2::object::ID>, arg1: &vector<0x2::object::ID>) : bool {
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (!0x1::vector::contains<0x2::object::ID>(arg1, 0x1::vector::borrow<0x2::object::ID>(arg0, v0))) {
                v1 = false;
                return v1
            };
            v0 = v0 + 1;
        };
        v1 = true;
        v1
    }

    public fun is_tightening(arg0: &Entry, arg1: &Entry) : bool {
        if (arg1.kind == arg0.kind) {
            if (arg1.decimals == arg0.decimals) {
                if (arg1.feed_id == arg0.feed_id) {
                    if (arg1.max_age_s <= arg0.max_age_s) {
                        if (arg1.tolerance_bps <= arg0.tolerance_bps) {
                            if (arg1.cap_micros <= arg0.cap_micros) {
                                arg0.enabled || !arg1.enabled
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun kind(arg0: &Entry) : u8 {
        arg0.kind
    }

    public fun kind_dollar() : u8 {
        0
    }

    public fun kind_priced() : u8 {
        1
    }

    public fun max_age_s(arg0: &Entry) : u64 {
        arg0.max_age_s
    }

    public fun migrate(arg0: &ConvertAdminCap, arg1: &mut ConvertRegistry) {
        check_cap(arg0, arg1);
        assert!(arg1.version < 1, 12);
        arg1.version = 1;
    }

    public fun min_delay_ms() : u64 {
        300000
    }

    public fun min_version<T0>(arg0: &ConvertRegistry) : u64 {
        let v0 = MinVersionsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<MinVersionsKey>(&arg0.id, v0)) {
            return 0
        };
        let v1 = MinVersionsKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<MinVersionsKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&arg0.id, v1);
        let v3 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(v2, &v3)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(v2, &v3)
        } else {
            0
        }
    }

    public fun new_entry(arg0: u8, arg1: u8, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: bool) : Entry {
        let v0 = Entry{
            kind          : arg0,
            decimals      : arg1,
            feed_id       : arg2,
            max_age_s     : arg3,
            tolerance_bps : arg4,
            cap_micros    : arg5,
            enabled       : arg6,
        };
        check_entry(&v0);
        v0
    }

    public fun new_route(arg0: u64, arg1: u64, arg2: vector<0x2::object::ID>, arg3: bool) : Route {
        let v0 = Route{
            cost_bps    : arg0,
            dust_micros : arg1,
            pools       : arg2,
            enabled     : arg3,
        };
        check_route(&v0);
        v0
    }

    public fun pending_min_version<T0>(arg0: &ConvertRegistry) : 0x1::option::Option<PendingMinVersion> {
        let v0 = PendingMinVersionsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<PendingMinVersionsKey>(&arg0.id, v0)) {
            return 0x1::option::none<PendingMinVersion>()
        };
        let v1 = PendingMinVersionsKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<PendingMinVersionsKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, PendingMinVersion>>(&arg0.id, v1);
        let v3 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, PendingMinVersion>(v2, &v3)) {
            0x1::option::some<PendingMinVersion>(*0x2::vec_map::get<0x1::type_name::TypeName, PendingMinVersion>(v2, &v3))
        } else {
            0x1::option::none<PendingMinVersion>()
        }
    }

    public fun pools(arg0: &Route) : vector<0x2::object::ID> {
        arg0.pools
    }

    fun pow10(arg0: u64) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    fun put_min(arg0: &mut ConvertRegistry, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = MinVersionsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<MinVersionsKey>(&arg0.id, v0)) {
            let v1 = MinVersionsKey{dummy_field: false};
            0x2::dynamic_field::add<MinVersionsKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&mut arg0.id, v1, 0x2::vec_map::empty<0x1::type_name::TypeName, u64>());
        };
        let v2 = MinVersionsKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<MinVersionsKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&mut arg0.id, v2);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(v3, &arg1)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(v3, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(v3, arg1, arg2);
        };
    }

    public fun route<T0, T1>(arg0: &ConvertRegistry) : Route {
        let v0 = route_key<T0, T1>();
        assert!(0x2::table::contains<RouteKey, Route>(&arg0.routes, v0), 10);
        let v1 = *0x2::table::borrow<RouteKey, Route>(&arg0.routes, v0);
        assert!(v1.enabled, 6);
        v1
    }

    public fun route_enabled(arg0: &Route) : bool {
        arg0.enabled
    }

    fun route_key<T0, T1>() : RouteKey {
        RouteKey{
            from : 0x1::type_name::with_defining_ids<T0>(),
            to   : 0x1::type_name::with_defining_ids<T1>(),
        }
    }

    public fun set_coin<T0>(arg0: &ConvertAdminCap, arg1: &mut ConvertRegistry, arg2: Entry, arg3: &0x2::clock::Clock) {
        check_cap(arg0, arg1);
        check_version(arg1);
        check_entry(&arg2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, Entry>(&arg1.entries, v0) && is_tightening(0x2::table::borrow<0x1::type_name::TypeName, Entry>(&arg1.entries, v0), &arg2)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, Entry>(&mut arg1.entries, v0) = arg2;
            if (0x2::table::contains<0x1::type_name::TypeName, Pending>(&arg1.pending, v0)) {
                0x2::table::remove<0x1::type_name::TypeName, Pending>(&mut arg1.pending, v0);
            };
            let v1 = CoinChanged{
                coin  : v0,
                entry : arg2,
                at_ms : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<CoinChanged>(v1);
        } else {
            if (0x2::table::contains<0x1::type_name::TypeName, Pending>(&arg1.pending, v0)) {
                0x2::table::remove<0x1::type_name::TypeName, Pending>(&mut arg1.pending, v0);
            };
            let v2 = 0x2::clock::timestamp_ms(arg3) + arg1.delay_ms;
            let v3 = Pending{
                entry        : arg2,
                effective_ms : v2,
            };
            0x2::table::add<0x1::type_name::TypeName, Pending>(&mut arg1.pending, v0, v3);
            let v4 = CoinChangeProposed{
                coin         : v0,
                entry        : arg2,
                effective_ms : v2,
            };
            0x2::event::emit<CoinChangeProposed>(v4);
        };
    }

    public fun set_delay(arg0: &ConvertAdminCap, arg1: &mut ConvertRegistry, arg2: u64, arg3: &0x2::clock::Clock) {
        check_cap(arg0, arg1);
        check_version(arg1);
        assert!(arg2 >= 300000, 11);
        if (arg2 >= arg1.delay_ms) {
            arg1.delay_ms = arg2;
            arg1.pending_delay = 0x1::option::none<PendingDelay>();
            let v0 = DelayChanged{delay_ms: arg2};
            0x2::event::emit<DelayChanged>(v0);
        } else {
            let v1 = 0x2::clock::timestamp_ms(arg3) + arg1.delay_ms;
            let v2 = PendingDelay{
                delay_ms     : arg2,
                effective_ms : v1,
            };
            arg1.pending_delay = 0x1::option::some<PendingDelay>(v2);
            let v3 = DelayChangeProposed{
                delay_ms     : arg2,
                effective_ms : v1,
            };
            0x2::event::emit<DelayChangeProposed>(v3);
        };
    }

    public fun set_min_version<T0>(arg0: &ConvertAdminCap, arg1: &mut ConvertRegistry, arg2: u64, arg3: &0x2::clock::Clock) {
        check_cap(arg0, arg1);
        check_version(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (arg2 >= min_version<T0>(arg1)) {
            put_min(arg1, v0, arg2);
            drop_pending_min(arg1, v0);
            let v1 = MinVersionChanged{
                adapter : v0,
                version : arg2,
            };
            0x2::event::emit<MinVersionChanged>(v1);
        } else {
            let v2 = 0x2::clock::timestamp_ms(arg3) + arg1.delay_ms;
            let v3 = PendingMinVersionsKey{dummy_field: false};
            if (!0x2::dynamic_field::exists<PendingMinVersionsKey>(&arg1.id, v3)) {
                let v4 = PendingMinVersionsKey{dummy_field: false};
                0x2::dynamic_field::add<PendingMinVersionsKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, PendingMinVersion>>(&mut arg1.id, v4, 0x2::vec_map::empty<0x1::type_name::TypeName, PendingMinVersion>());
            };
            let v5 = PendingMinVersionsKey{dummy_field: false};
            let v6 = 0x2::dynamic_field::borrow_mut<PendingMinVersionsKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, PendingMinVersion>>(&mut arg1.id, v5);
            if (0x2::vec_map::contains<0x1::type_name::TypeName, PendingMinVersion>(v6, &v0)) {
                let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, PendingMinVersion>(v6, &v0);
            };
            let v9 = PendingMinVersion{
                version      : arg2,
                effective_ms : v2,
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, PendingMinVersion>(v6, v0, v9);
            let v10 = MinVersionChangeProposed{
                adapter      : v0,
                version      : arg2,
                effective_ms : v2,
            };
            0x2::event::emit<MinVersionChangeProposed>(v10);
        };
    }

    public fun set_route<T0, T1>(arg0: &ConvertAdminCap, arg1: &mut ConvertRegistry, arg2: Route, arg3: &0x2::clock::Clock) {
        check_cap(arg0, arg1);
        check_version(arg1);
        check_route(&arg2);
        let v0 = route_key<T0, T1>();
        if (0x2::table::contains<RouteKey, PendingRoute>(&arg1.pending_routes, v0)) {
            0x2::table::remove<RouteKey, PendingRoute>(&mut arg1.pending_routes, v0);
        };
        if (0x2::table::contains<RouteKey, Route>(&arg1.routes, v0) && is_route_tightening(0x2::table::borrow<RouteKey, Route>(&arg1.routes, v0), &arg2)) {
            *0x2::table::borrow_mut<RouteKey, Route>(&mut arg1.routes, v0) = arg2;
            let v1 = RouteChanged{
                key   : v0,
                route : arg2,
                at_ms : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<RouteChanged>(v1);
        } else {
            let v2 = 0x2::clock::timestamp_ms(arg3) + arg1.delay_ms;
            let v3 = PendingRoute{
                route        : arg2,
                effective_ms : v2,
            };
            0x2::table::add<RouteKey, PendingRoute>(&mut arg1.pending_routes, v0, v3);
            let v4 = RouteChangeProposed{
                key          : v0,
                route        : arg2,
                effective_ms : v2,
            };
            0x2::event::emit<RouteChangeProposed>(v4);
        };
    }

    public fun tolerance_bps(arg0: &Entry) : u64 {
        arg0.tolerance_bps
    }

    public fun version(arg0: &ConvertRegistry) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

