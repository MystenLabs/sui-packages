module 0x4e2f02146f207c71f50a1169d6f118f983cbad09abaf60c3184169be60e2e531::point {
    struct PointKey<phantom T0> has store {
        dummy_field: bool,
    }

    struct AddPointRequest<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        value: u256,
    }

    struct SubPointRequest<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        value: u256,
    }

    struct PointDashBoard<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_points: u256,
        user_points: 0x2::table::Table<address, u256>,
    }

    struct LiquidlinkAddPointEvent<phantom T0> has copy, drop {
        owner: address,
        value: u256,
    }

    struct LiquidlinkSubPointEvent<phantom T0> has copy, drop {
        owner: address,
        value: u256,
    }

    public(friend) fun add_point<T0>(arg0: &mut PointDashBoard<T0>, arg1: AddPointRequest<T0>) {
        let AddPointRequest {
            id    : v0,
            owner : v1,
            value : v2,
        } = arg1;
        0x2::object::delete(v0);
        if (!0x2::table::contains<address, u256>(&arg0.user_points, v1)) {
            0x2::table::add<address, u256>(&mut arg0.user_points, v1, 0);
        };
        arg0.total_points = arg0.total_points + v2;
        *0x2::table::borrow_mut<address, u256>(&mut arg0.user_points, v1) = *0x2::table::borrow<address, u256>(&arg0.user_points, v1) + v2;
    }

    public(friend) fun drop_point_key<T0>(arg0: PointKey<T0>) {
        let PointKey {  } = arg0;
    }

    public fun get_user_points<T0>(arg0: &PointDashBoard<T0>, arg1: address) : u256 {
        if (0x2::table::contains<address, u256>(&arg0.user_points, arg1)) {
            *0x2::table::borrow<address, u256>(&arg0.user_points, arg1)
        } else {
            0
        }
    }

    public(friend) fun new_point_dashboard<T0>(arg0: &mut 0x2::tx_context::TxContext) : PointDashBoard<T0> {
        PointDashBoard<T0>{
            id           : 0x2::object::new(arg0),
            total_points : 0,
            user_points  : 0x2::table::new<address, u256>(arg0),
        }
    }

    public(friend) fun new_point_key<T0>() : PointKey<T0> {
        PointKey<T0>{dummy_field: false}
    }

    public fun send_add_point_req<T0: drop>(arg0: u256, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        send_add_point_req_<T0>(0x4e2f02146f207c71f50a1169d6f118f983cbad09abaf60c3184169be60e2e531::constant::point_updater(), v0, arg0, arg2);
    }

    fun send_add_point_req_<T0>(arg0: address, arg1: address, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = AddPointRequest<T0>{
            id    : 0x2::object::new(arg3),
            owner : arg1,
            value : arg2,
        };
        let v1 = LiquidlinkAddPointEvent<T0>{
            owner : arg1,
            value : arg2,
        };
        0x2::event::emit<LiquidlinkAddPointEvent<T0>>(v1);
        0x2::transfer::transfer<AddPointRequest<T0>>(v0, arg0);
    }

    public fun send_add_point_req_with_owner<T0>(arg0: address, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        send_add_point_req_<T0>(0x4e2f02146f207c71f50a1169d6f118f983cbad09abaf60c3184169be60e2e531::constant::point_updater(), arg0, arg1, arg2);
    }

    public fun send_sub_point_req<T0>(arg0: u256, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        send_sub_point_req_<T0>(0x4e2f02146f207c71f50a1169d6f118f983cbad09abaf60c3184169be60e2e531::constant::point_updater(), v0, arg0, arg1);
    }

    fun send_sub_point_req_<T0>(arg0: address, arg1: address, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = SubPointRequest<T0>{
            id    : 0x2::object::new(arg3),
            owner : arg1,
            value : arg2,
        };
        let v1 = LiquidlinkSubPointEvent<T0>{
            owner : arg1,
            value : arg2,
        };
        0x2::event::emit<LiquidlinkSubPointEvent<T0>>(v1);
        0x2::transfer::transfer<SubPointRequest<T0>>(v0, arg0);
    }

    public fun send_sub_point_req_with_owner<T0>(arg0: address, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        send_sub_point_req_<T0>(0x4e2f02146f207c71f50a1169d6f118f983cbad09abaf60c3184169be60e2e531::constant::point_updater(), arg0, arg1, arg2);
    }

    public(friend) fun sub_point<T0>(arg0: &mut PointDashBoard<T0>, arg1: SubPointRequest<T0>) {
        let SubPointRequest {
            id    : v0,
            owner : v1,
            value : v2,
        } = arg1;
        0x2::object::delete(v0);
        arg0.total_points = arg0.total_points - v2;
        let v3 = *0x2::table::borrow<address, u256>(&arg0.user_points, v1);
        if (v3 <= v2) {
            0x2::table::remove<address, u256>(&mut arg0.user_points, v1);
        } else {
            *0x2::table::borrow_mut<address, u256>(&mut arg0.user_points, v1) = v3 - v2;
        };
    }

    public fun total_points<T0>(arg0: &PointDashBoard<T0>) : u256 {
        arg0.total_points
    }

    // decompiled from Move bytecode v6
}

