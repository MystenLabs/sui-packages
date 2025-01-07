module 0xed8e8894181fbcda554bea8adb062b9f9b8556f78e8e10dbd21cda6ca8b7a86b::point {
    struct PointKey<phantom T0> has store {
        dummy_field: bool,
    }

    struct AddPointRequest<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        action: 0x1::ascii::String,
        value: u256,
    }

    struct SubPointRequest<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        action: 0x1::ascii::String,
        value: u256,
    }

    struct StakePointRequest<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        action: 0x1::ascii::String,
        weight: u256,
        duration: u64,
        timestamp: u64,
    }

    struct UnstakePointRequest<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        action: 0x1::ascii::String,
        weight: u256,
        duration: u64,
        timestamp: u64,
    }

    struct UserInfo has copy, drop, store {
        points: 0x2::vec_map::VecMap<0x1::ascii::String, u256>,
        configs: 0x2::vec_map::VecMap<0x1::ascii::String, Config>,
    }

    struct Config has copy, drop, store {
        weight: u256,
        last_update: u64,
        duration: u64,
    }

    struct PointDashBoard<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_points: u256,
        user_infos: 0x2::table::Table<address, UserInfo>,
    }

    struct LiquidlinkAddPointEvent<phantom T0> has copy, drop {
        owner: address,
        action: 0x1::ascii::String,
        req: 0x2::object::ID,
        value: u256,
    }

    struct LiquidlinkSubPointEvent<phantom T0> has copy, drop {
        owner: address,
        action: 0x1::ascii::String,
        req: 0x2::object::ID,
        value: u256,
    }

    struct LiquidlinkStakePointEvent<phantom T0> has copy, drop {
        owner: address,
        action: 0x1::ascii::String,
        req: 0x2::object::ID,
        weight: u256,
        timestamp: u64,
        duration: u64,
    }

    struct LiquidlinkUnstakePointEvent<phantom T0> has copy, drop {
        owner: address,
        action: 0x1::ascii::String,
        req: 0x2::object::ID,
        weight: u256,
        timestamp: u64,
        duration: u64,
    }

    public(friend) fun add_point<T0: drop>(arg0: &mut PointDashBoard<T0>, arg1: AddPointRequest<T0>) {
        let AddPointRequest {
            id     : v0,
            owner  : v1,
            action : v2,
            value  : v3,
        } = arg1;
        let v4 = v2;
        0x2::object::delete(v0);
        init_user_info<T0>(arg0, v1);
        let v5 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.user_infos, v1);
        if (!0x2::vec_map::contains<0x1::ascii::String, u256>(&v5.points, &v4)) {
            0x2::vec_map::insert<0x1::ascii::String, u256>(&mut v5.points, v4, v3);
        } else {
            *0x2::vec_map::get_mut<0x1::ascii::String, u256>(&mut v5.points, &v4) = *0x2::vec_map::get<0x1::ascii::String, u256>(&v5.points, &v4) + v3;
        };
        arg0.total_points = arg0.total_points + v3;
    }

    fun calculate_config_points(arg0: &Config, arg1: u64) : u256 {
        if (arg0.duration == 0) {
            return 0
        };
        (arg0.weight as u256) * ((arg1 - arg0.last_update) as u256) / (arg0.duration as u256)
    }

    fun checkpoint(arg0: &mut Config, arg1: u64, arg2: u256, arg3: u64, arg4: bool) : u256 {
        assert!(arg1 > arg0.last_update, 101);
        let v0 = if (arg4) {
            arg0.weight + arg2
        } else if (arg0.weight < arg2) {
            0
        } else {
            arg0.weight - arg2
        };
        arg0.weight = v0;
        arg0.last_update = arg1;
        arg0.duration = arg3;
        calculate_config_points(arg0, arg1)
    }

    public(friend) fun drop_point_key<T0>(arg0: PointKey<T0>) {
        let PointKey {  } = arg0;
    }

    public fun get_user_info<T0>(arg0: &PointDashBoard<T0>, arg1: address) : 0x1::option::Option<UserInfo> {
        if (0x2::table::contains<address, UserInfo>(&arg0.user_infos, arg1)) {
            0x1::option::some<UserInfo>(*0x2::table::borrow<address, UserInfo>(&arg0.user_infos, arg1))
        } else {
            0x1::option::none<UserInfo>()
        }
    }

    public fun get_user_iufo_points<T0>(arg0: &PointDashBoard<T0>, arg1: address, arg2: &0x2::clock::Clock) : u256 {
        let v0 = 0;
        let v1 = get_user_info<T0>(arg0, arg1);
        if (0x1::option::is_some<UserInfo>(&v1)) {
            let v2 = 0x1::option::borrow<UserInfo>(&v1);
            let v3 = 0x2::vec_map::keys<0x1::ascii::String, u256>(&v2.points);
            let v4 = 0;
            while (v4 < 0x1::vector::length<0x1::ascii::String>(&v3)) {
                v0 = v0 + *0x2::vec_map::get<0x1::ascii::String, u256>(&v2.points, 0x1::vector::borrow<0x1::ascii::String>(&v3, v4));
                v4 = v4 + 1;
            };
            let v5 = 0x2::vec_map::keys<0x1::ascii::String, Config>(&v2.configs);
            let v6 = 0;
            while (v6 < 0x1::vector::length<0x1::ascii::String>(&v5)) {
                v0 = v0 + calculate_config_points(0x2::vec_map::get<0x1::ascii::String, Config>(&v2.configs, 0x1::vector::borrow<0x1::ascii::String>(&v5, v6)), 0x2::clock::timestamp_ms(arg2));
                v6 = v6 + 1;
            };
        };
        v0
    }

    fun init_user_info<T0: drop>(arg0: &mut PointDashBoard<T0>, arg1: address) {
        if (!0x2::table::contains<address, UserInfo>(&arg0.user_infos, arg1)) {
            let v0 = UserInfo{
                points  : 0x2::vec_map::empty<0x1::ascii::String, u256>(),
                configs : 0x2::vec_map::empty<0x1::ascii::String, Config>(),
            };
            0x2::table::add<address, UserInfo>(&mut arg0.user_infos, arg1, v0);
        };
    }

    public(friend) fun new_point_dashboard<T0>(arg0: &mut 0x2::tx_context::TxContext) : PointDashBoard<T0> {
        PointDashBoard<T0>{
            id           : 0x2::object::new(arg0),
            total_points : 0,
            user_infos   : 0x2::table::new<address, UserInfo>(arg0),
        }
    }

    public(friend) fun new_point_key<T0>() : PointKey<T0> {
        PointKey<T0>{dummy_field: false}
    }

    public fun send_add_point_req<T0: drop>(arg0: T0, arg1: 0x1::ascii::String, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        send_add_point_req_<T0>(0xed8e8894181fbcda554bea8adb062b9f9b8556f78e8e10dbd21cda6ca8b7a86b::constant::point_updater(), v0, arg1, arg2, arg3);
    }

    fun send_add_point_req_<T0: drop>(arg0: address, arg1: address, arg2: 0x1::ascii::String, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = AddPointRequest<T0>{
            id     : 0x2::object::new(arg4),
            owner  : arg1,
            action : arg2,
            value  : arg3,
        };
        let v1 = LiquidlinkAddPointEvent<T0>{
            owner  : arg1,
            action : arg2,
            req    : 0x2::object::id<AddPointRequest<T0>>(&v0),
            value  : arg3,
        };
        0x2::event::emit<LiquidlinkAddPointEvent<T0>>(v1);
        0x2::transfer::transfer<AddPointRequest<T0>>(v0, arg0);
    }

    public fun send_add_point_req_with_owner<T0: drop>(arg0: T0, arg1: address, arg2: 0x1::ascii::String, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) {
        send_add_point_req_<T0>(0xed8e8894181fbcda554bea8adb062b9f9b8556f78e8e10dbd21cda6ca8b7a86b::constant::point_updater(), arg1, arg2, arg3, arg4);
    }

    public fun send_stake_point_req<T0: drop>(arg0: T0, arg1: 0x1::ascii::String, arg2: u256, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        send_stake_point_req_<T0>(0xed8e8894181fbcda554bea8adb062b9f9b8556f78e8e10dbd21cda6ca8b7a86b::constant::point_updater(), v0, arg1, arg2, arg3, arg4, arg5);
    }

    fun send_stake_point_req_<T0: drop>(arg0: address, arg1: address, arg2: 0x1::ascii::String, arg3: u256, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = StakePointRequest<T0>{
            id        : 0x2::object::new(arg6),
            owner     : arg1,
            action    : arg2,
            weight    : arg3,
            duration  : arg4,
            timestamp : v0,
        };
        let v2 = LiquidlinkStakePointEvent<T0>{
            owner     : arg1,
            action    : arg2,
            req       : 0x2::object::id<StakePointRequest<T0>>(&v1),
            weight    : arg3,
            timestamp : v0,
            duration  : arg4,
        };
        0x2::event::emit<LiquidlinkStakePointEvent<T0>>(v2);
        0x2::transfer::transfer<StakePointRequest<T0>>(v1, arg0);
    }

    public fun send_stake_point_req_with_owner<T0: drop>(arg0: T0, arg1: address, arg2: 0x1::ascii::String, arg3: u256, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        send_stake_point_req_<T0>(0xed8e8894181fbcda554bea8adb062b9f9b8556f78e8e10dbd21cda6ca8b7a86b::constant::point_updater(), arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun send_sub_point_req<T0: drop>(arg0: T0, arg1: 0x1::ascii::String, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        send_sub_point_req_<T0>(0xed8e8894181fbcda554bea8adb062b9f9b8556f78e8e10dbd21cda6ca8b7a86b::constant::point_updater(), v0, arg1, arg2, arg3);
    }

    fun send_sub_point_req_<T0: drop>(arg0: address, arg1: address, arg2: 0x1::ascii::String, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SubPointRequest<T0>{
            id     : 0x2::object::new(arg4),
            owner  : arg1,
            action : arg2,
            value  : arg3,
        };
        let v1 = LiquidlinkSubPointEvent<T0>{
            owner  : arg1,
            action : arg2,
            req    : 0x2::object::id<SubPointRequest<T0>>(&v0),
            value  : arg3,
        };
        0x2::event::emit<LiquidlinkSubPointEvent<T0>>(v1);
        0x2::transfer::transfer<SubPointRequest<T0>>(v0, arg0);
    }

    public fun send_sub_point_req_with_owner<T0: drop>(arg0: T0, arg1: address, arg2: 0x1::ascii::String, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) {
        send_sub_point_req_<T0>(0xed8e8894181fbcda554bea8adb062b9f9b8556f78e8e10dbd21cda6ca8b7a86b::constant::point_updater(), arg1, arg2, arg3, arg4);
    }

    public fun send_unstake_point_req<T0: drop>(arg0: T0, arg1: 0x1::ascii::String, arg2: u256, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        send_unstake_point_req_<T0>(0xed8e8894181fbcda554bea8adb062b9f9b8556f78e8e10dbd21cda6ca8b7a86b::constant::point_updater(), v0, arg1, arg2, arg3, arg4, arg5);
    }

    fun send_unstake_point_req_<T0: drop>(arg0: address, arg1: address, arg2: 0x1::ascii::String, arg3: u256, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = UnstakePointRequest<T0>{
            id        : 0x2::object::new(arg6),
            owner     : arg1,
            action    : arg2,
            weight    : arg3,
            duration  : arg4,
            timestamp : v0,
        };
        let v2 = LiquidlinkUnstakePointEvent<T0>{
            owner     : arg1,
            action    : arg2,
            req       : 0x2::object::id<UnstakePointRequest<T0>>(&v1),
            weight    : arg3,
            timestamp : v0,
            duration  : arg4,
        };
        0x2::event::emit<LiquidlinkUnstakePointEvent<T0>>(v2);
        0x2::transfer::transfer<UnstakePointRequest<T0>>(v1, arg0);
    }

    public fun send_unstake_point_req_with_owner<T0: drop>(arg0: T0, arg1: address, arg2: 0x1::ascii::String, arg3: u256, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        send_unstake_point_req_<T0>(0xed8e8894181fbcda554bea8adb062b9f9b8556f78e8e10dbd21cda6ca8b7a86b::constant::point_updater(), arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public(friend) fun stake_point<T0: drop>(arg0: &mut PointDashBoard<T0>, arg1: StakePointRequest<T0>) {
        let StakePointRequest {
            id        : v0,
            owner     : v1,
            action    : v2,
            weight    : v3,
            duration  : v4,
            timestamp : v5,
        } = arg1;
        let v6 = v2;
        0x2::object::delete(v0);
        init_user_info<T0>(arg0, v1);
        let v7 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.user_infos, v1);
        if (!0x2::vec_map::contains<0x1::ascii::String, Config>(&v7.configs, &v6)) {
            let v8 = Config{
                weight      : v3,
                last_update : v5,
                duration    : v4,
            };
            0x2::vec_map::insert<0x1::ascii::String, Config>(&mut v7.configs, v6, v8);
        } else {
            let v9 = 0x2::vec_map::get_mut<0x1::ascii::String, Config>(&mut v7.configs, &v6);
            let v10 = checkpoint(v9, v5, v3, v4, true);
            arg0.total_points = arg0.total_points + v10;
            if (!0x2::vec_map::contains<0x1::ascii::String, u256>(&v7.points, &v6)) {
                0x2::vec_map::insert<0x1::ascii::String, u256>(&mut v7.points, v6, v10);
            } else {
                *0x2::vec_map::get_mut<0x1::ascii::String, u256>(&mut v7.points, &v6) = *0x2::vec_map::get<0x1::ascii::String, u256>(&v7.points, &v6) + v10;
            };
        };
    }

    public(friend) fun sub_point<T0>(arg0: &mut PointDashBoard<T0>, arg1: SubPointRequest<T0>) {
        let SubPointRequest {
            id     : v0,
            owner  : v1,
            action : v2,
            value  : v3,
        } = arg1;
        let v4 = v2;
        0x2::object::delete(v0);
        let v5 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.user_infos, v1);
        if (0x2::vec_map::contains<0x1::ascii::String, u256>(&v5.points, &v4)) {
            let v6 = *0x2::vec_map::get<0x1::ascii::String, u256>(&v5.points, &v4);
            let v7 = if (v6 <= v3) {
                let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, u256>(&mut v5.points, &v4);
                v6
            } else {
                *0x2::vec_map::get_mut<0x1::ascii::String, u256>(&mut v5.points, &v4) = v6 - v3;
                v3
            };
            arg0.total_points = arg0.total_points - v7;
        };
    }

    public fun total_points<T0>(arg0: &PointDashBoard<T0>) : u256 {
        arg0.total_points
    }

    public(friend) fun unstake_point<T0: drop>(arg0: &mut PointDashBoard<T0>, arg1: UnstakePointRequest<T0>) {
        let UnstakePointRequest {
            id        : v0,
            owner     : v1,
            action    : v2,
            weight    : v3,
            duration  : v4,
            timestamp : v5,
        } = arg1;
        let v6 = v2;
        0x2::object::delete(v0);
        init_user_info<T0>(arg0, v1);
        let v7 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.user_infos, v1);
        if (0x2::vec_map::contains<0x1::ascii::String, Config>(&v7.configs, &v6)) {
            let v8 = 0x2::vec_map::get_mut<0x1::ascii::String, Config>(&mut v7.configs, &v6);
            let v9 = checkpoint(v8, v5, v3, v4, false);
            arg0.total_points = arg0.total_points + v9;
            if (!0x2::vec_map::contains<0x1::ascii::String, u256>(&v7.points, &v6)) {
                0x2::vec_map::insert<0x1::ascii::String, u256>(&mut v7.points, v6, v9);
            } else {
                *0x2::vec_map::get_mut<0x1::ascii::String, u256>(&mut v7.points, &v6) = *0x2::vec_map::get<0x1::ascii::String, u256>(&v7.points, &v6) + v9;
            };
        };
    }

    // decompiled from Move bytecode v6
}

