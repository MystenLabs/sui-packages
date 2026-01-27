module 0x6c9f00904651d8f204452b2213469725741b4a35ee22e8231d98609d7ada4669::router {
    struct RoutingTable has key {
        id: 0x2::object::UID,
        paths: 0x2::table::Table<0x1::ascii::String, RouteConfig>,
        version: u8,
    }

    struct RouteConfig has store {
        owner: address,
        gateway: address,
        status: u8,
        destination_a: address,
        destination_b: address,
        split_ratio: u8,
        paths: 0x2::table::Table<0x2::object::ID, PathEntry>,
    }

    struct PathEntry has copy, drop, store {
        path_type: 0x1::ascii::String,
        bandwidth: u64,
        routed: bool,
    }

    struct RouteCreated has copy, drop {
        route_id: 0x1::ascii::String,
        owner: address,
    }

    struct PathAdded has copy, drop {
        route_id: 0x1::ascii::String,
        path_id: 0x2::object::ID,
        path_type: 0x1::ascii::String,
        bandwidth: u64,
    }

    struct RoutingCompleted has copy, drop {
        route_id: 0x1::ascii::String,
        path_id: 0x2::object::ID,
        result_bandwidth: u64,
    }

    public entry fun add_path(arg0: &mut RoutingTable, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x1::ascii::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, RouteConfig>(&arg0.paths, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, RouteConfig>(&mut arg0.paths, arg1);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.owner || v1 == v0.gateway, 100);
        let v2 = PathEntry{
            path_type : arg3,
            bandwidth : arg4,
            routed    : false,
        };
        if (0x2::table::contains<0x2::object::ID, PathEntry>(&v0.paths, arg2)) {
            *0x2::table::borrow_mut<0x2::object::ID, PathEntry>(&mut v0.paths, arg2) = v2;
        } else {
            0x2::table::add<0x2::object::ID, PathEntry>(&mut v0.paths, arg2, v2);
        };
        let v3 = PathAdded{
            route_id  : arg1,
            path_id   : arg2,
            path_type : arg3,
            bandwidth : arg4,
        };
        0x2::event::emit<PathAdded>(v3);
    }

    public fun archive_path(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut RoutingTable, arg2: 0x1::ascii::String, arg3: 0x2::object::ID, arg4: 0x3::staking_pool::StakedSui, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, RouteConfig>(&arg1.paths, arg2), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, RouteConfig>(&mut arg1.paths, arg2);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.gateway, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, PathEntry>(&v0.paths, arg3)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, PathEntry>(&v0.paths, arg3);
            !v3.routed && v3.bandwidth > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, PathEntry>(&v0.paths, arg3)) {
            0x2::table::borrow_mut<0x2::object::ID, PathEntry>(&mut v0.paths, arg3).routed = true;
        };
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg4, arg5), arg5);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&v4);
        let v6 = v5 * (v0.split_ratio as u64) / 100;
        if (v6 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.destination_b);
        } else if (v6 == v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.destination_a);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v6, arg5), v0.destination_a);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.destination_b);
        };
        let v7 = RoutingCompleted{
            route_id         : arg2,
            path_id          : arg3,
            result_bandwidth : v5,
        };
        0x2::event::emit<RoutingCompleted>(v7);
    }

    public entry fun create_route(arg0: &mut RoutingTable, arg1: 0x1::ascii::String, arg2: address, arg3: address, arg4: address, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 <= 100, 106);
        let v0 = RouteConfig{
            owner         : 0x2::tx_context::sender(arg6),
            gateway       : arg2,
            status        : 0,
            destination_a : arg3,
            destination_b : arg4,
            split_ratio   : arg5,
            paths         : 0x2::table::new<0x2::object::ID, PathEntry>(arg6),
        };
        0x2::table::add<0x1::ascii::String, RouteConfig>(&mut arg0.paths, arg1, v0);
        let v1 = RouteCreated{
            route_id : arg1,
            owner    : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<RouteCreated>(v1);
    }

    public entry fun enable_route(arg0: &mut RoutingTable, arg1: 0x1::ascii::String, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, RouteConfig>(&arg0.paths, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, RouteConfig>(&mut arg0.paths, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.owner, 100);
        if (arg2) {
            v0.status = v0.status | 1;
        } else {
            v0.status = v0.status & (255 ^ 1);
        };
    }

    public fun forward_packet<T0: store + key>(arg0: &mut RoutingTable, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, RouteConfig>(&arg0.paths, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, RouteConfig>(&mut arg0.paths, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.gateway, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, PathEntry>(&v0.paths, arg2)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, PathEntry>(&v0.paths, arg2);
            !v3.routed && v3.bandwidth > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, PathEntry>(&v0.paths, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, PathEntry>(&mut v0.paths, arg2).routed = true;
        };
        0x2::transfer::public_transfer<T0>(arg3, v0.destination_a);
        let v4 = RoutingCompleted{
            route_id         : arg1,
            path_id          : arg2,
            result_bandwidth : 1,
        };
        0x2::event::emit<RoutingCompleted>(v4);
    }

    public fun get_path_bandwidth(arg0: &RoutingTable, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : u64 {
        assert!(0x2::table::contains<0x1::ascii::String, RouteConfig>(&arg0.paths, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, RouteConfig>(&arg0.paths, arg1);
        if (v0.status & 1 == 0) {
            return 0
        };
        if (!0x2::table::contains<0x2::object::ID, PathEntry>(&v0.paths, arg2)) {
            return 0
        };
        let v1 = 0x2::table::borrow<0x2::object::ID, PathEntry>(&v0.paths, arg2);
        if (v1.routed) {
            return 0
        };
        v1.bandwidth
    }

    public fun get_path_info(arg0: &RoutingTable, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : (0x1::ascii::String, u64, bool) {
        assert!(0x2::table::contains<0x1::ascii::String, RouteConfig>(&arg0.paths, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, RouteConfig>(&arg0.paths, arg1);
        assert!(0x2::table::contains<0x2::object::ID, PathEntry>(&v0.paths, arg2), 102);
        let v1 = 0x2::table::borrow<0x2::object::ID, PathEntry>(&v0.paths, arg2);
        (v1.path_type, v1.bandwidth, v1.routed)
    }

    public fun get_route_info(arg0: &RoutingTable, arg1: 0x1::ascii::String) : (address, address, bool, address, address, u8) {
        assert!(0x2::table::contains<0x1::ascii::String, RouteConfig>(&arg0.paths, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, RouteConfig>(&arg0.paths, arg1);
        (v0.owner, v0.gateway, v0.status & 1 != 0, v0.destination_a, v0.destination_b, v0.split_ratio)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RoutingTable{
            id      : 0x2::object::new(arg0),
            paths   : 0x2::table::new<0x1::ascii::String, RouteConfig>(arg0),
            version : 1,
        };
        0x2::transfer::share_object<RoutingTable>(v0);
    }

    public fun route_batch<T0>(arg0: &mut RoutingTable, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, RouteConfig>(&arg0.paths, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, RouteConfig>(&mut arg0.paths, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.gateway, 100);
        let v2 = 0x2::coin::value<T0>(&arg3);
        if (v2 == 0 || !(v0.status & 1 != 0)) {
            if (v2 == 0) {
                0x2::coin::destroy_zero<T0>(arg3);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v1);
            };
            return
        };
        if (0x2::table::contains<0x2::object::ID, PathEntry>(&v0.paths, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, PathEntry>(&mut v0.paths, arg2).routed = true;
        };
        let v3 = v2 * (v0.split_ratio as u64) / 100;
        if (v3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.destination_b);
        } else if (v3 == v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.destination_a);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v3, arg4), v0.destination_a);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.destination_b);
        };
        let v4 = RoutingCompleted{
            route_id         : arg1,
            path_id          : arg2,
            result_bandwidth : v2,
        };
        0x2::event::emit<RoutingCompleted>(v4);
    }

    public fun should_route(arg0: &RoutingTable, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : bool {
        get_path_bandwidth(arg0, arg1, arg2) > 0
    }

    public entry fun update_bandwidth(arg0: &mut RoutingTable, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, RouteConfig>(&arg0.paths, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, RouteConfig>(&mut arg0.paths, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.owner || v1 == v0.gateway, 100);
        assert!(0x2::table::contains<0x2::object::ID, PathEntry>(&v0.paths, arg2), 102);
        0x2::table::borrow_mut<0x2::object::ID, PathEntry>(&mut v0.paths, arg2).bandwidth = arg3;
    }

    // decompiled from Move bytecode v6
}

