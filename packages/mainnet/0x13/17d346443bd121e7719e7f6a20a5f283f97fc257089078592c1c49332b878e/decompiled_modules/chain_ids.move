module 0x1317d346443bd121e7719e7f6a20a5f283f97fc257089078592c1c49332b878e::chain_ids {
    struct BridgeSupportedRoutes has copy, drop, store {
        routes: 0x2::vec_map::VecMap<BridgeRoute, BridgeRouteValue>,
    }

    struct BridgeRoute has copy, drop, store {
        destination: u8,
        token: u8,
    }

    struct BridgeRouteValue has copy, drop, store {
        fee_percentage: u64,
        bridge_amount: u64,
        supported: bool,
        min_amount: u64,
    }

    struct UpdateTokenBridgeMinAmountEvent has copy, drop {
        destination: u8,
        token_id: u8,
        new_min_amount: u64,
    }

    struct UpdateTokenBridgeFeePercentageEvent has copy, drop {
        destination: u8,
        token_id: u8,
        new_fee_percentage: u64,
    }

    public(friend) fun add_new_route(arg0: &mut BridgeSupportedRoutes, arg1: u8, arg2: u8, arg3: u64, arg4: u64, arg5: bool, arg6: u64) {
        assert!(arg3 < 1000000, 2);
        let v0 = BridgeRoute{
            destination : arg1,
            token       : arg2,
        };
        let v1 = BridgeRouteValue{
            fee_percentage : arg3,
            bridge_amount  : arg4,
            supported      : arg5,
            min_amount     : arg6,
        };
        if (0x2::vec_map::contains<BridgeRoute, BridgeRouteValue>(&arg0.routes, &v0)) {
            *0x2::vec_map::get_mut<BridgeRoute, BridgeRouteValue>(&mut arg0.routes, &v0) = v1;
        } else {
            0x2::vec_map::insert<BridgeRoute, BridgeRouteValue>(&mut arg0.routes, v0, v1);
        };
    }

    public fun assert_valid_chain_id(arg0: u8) {
        assert!(arg0 == 16, 0);
    }

    public fun chain_id() : u8 {
        16
    }

    public(friend) fun create() : BridgeSupportedRoutes {
        BridgeSupportedRoutes{routes: 0x2::vec_map::empty<BridgeRoute, BridgeRouteValue>()}
    }

    public(friend) fun get_fees(arg0: &BridgeSupportedRoutes, arg1: &BridgeRoute, arg2: u64) : u64 {
        let v0 = 0x2::vec_map::try_get<BridgeRoute, BridgeRouteValue>(&arg0.routes, arg1);
        assert!(0x1::option::is_some<BridgeRouteValue>(&v0), 4);
        let v1 = 0x1::option::destroy_some<BridgeRouteValue>(v0);
        (((v1.fee_percentage as u128) * (arg2 as u128) / (1000000 as u128)) as u64)
    }

    public(friend) fun get_min_amount(arg0: &BridgeSupportedRoutes, arg1: &BridgeRoute) : u64 {
        let v0 = 0x2::vec_map::try_get<BridgeRoute, BridgeRouteValue>(&arg0.routes, arg1);
        assert!(0x1::option::is_some<BridgeRouteValue>(&v0), 4);
        let v1 = 0x1::option::destroy_some<BridgeRouteValue>(v0);
        v1.min_amount
    }

    public fun get_route(arg0: &BridgeSupportedRoutes, arg1: u8, arg2: u8) : BridgeRoute {
        let v0 = BridgeRoute{
            destination : arg1,
            token       : arg2,
        };
        assert!(is_valid_route(arg0, arg1, arg2), 0);
        v0
    }

    public fun is_valid_route(arg0: &BridgeSupportedRoutes, arg1: u8, arg2: u8) : bool {
        let v0 = BridgeRoute{
            destination : arg1,
            token       : arg2,
        };
        let v1 = 0x2::vec_map::try_get<BridgeRoute, BridgeRouteValue>(&arg0.routes, &v0);
        if (0x1::option::is_some<BridgeRouteValue>(&v1)) {
            let v3 = 0x1::option::destroy_some<BridgeRouteValue>(v1);
            v3.supported
        } else {
            false
        }
    }

    public fun route_destination(arg0: &BridgeRoute) : &u8 {
        &arg0.destination
    }

    public fun route_token(arg0: &BridgeRoute) : &u8 {
        &arg0.token
    }

    public(friend) fun update_bridge_amount(arg0: &mut BridgeSupportedRoutes, arg1: &BridgeRoute, arg2: u64, arg3: bool) {
        let v0 = 0x2::vec_map::get_mut<BridgeRoute, BridgeRouteValue>(&mut arg0.routes, arg1);
        if (arg3) {
            v0.bridge_amount = v0.bridge_amount + arg2;
        } else {
            assert!(v0.bridge_amount >= arg2, 3);
            v0.bridge_amount = v0.bridge_amount - arg2;
        };
    }

    public(friend) fun update_bridge_fee_percentage(arg0: &mut BridgeSupportedRoutes, arg1: &BridgeRoute, arg2: u64) {
        assert!(arg2 < 1000000, 2);
        0x2::vec_map::get_mut<BridgeRoute, BridgeRouteValue>(&mut arg0.routes, arg1).fee_percentage = arg2;
        let v0 = UpdateTokenBridgeFeePercentageEvent{
            destination        : arg1.destination,
            token_id           : arg1.token,
            new_fee_percentage : arg2,
        };
        0x2::event::emit<UpdateTokenBridgeFeePercentageEvent>(v0);
    }

    public(friend) fun update_bridge_min_amount(arg0: &mut BridgeSupportedRoutes, arg1: &BridgeRoute, arg2: u64) {
        0x2::vec_map::get_mut<BridgeRoute, BridgeRouteValue>(&mut arg0.routes, arg1).min_amount = arg2;
        let v0 = UpdateTokenBridgeMinAmountEvent{
            destination    : arg1.destination,
            token_id       : arg1.token,
            new_min_amount : arg2,
        };
        0x2::event::emit<UpdateTokenBridgeMinAmountEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

