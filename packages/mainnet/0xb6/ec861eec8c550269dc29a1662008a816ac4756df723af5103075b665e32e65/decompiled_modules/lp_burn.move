module 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LP_BURN has drop {
        dummy_field: bool,
    }

    struct BurnManager has key {
        id: 0x2::object::UID,
        position: 0x2::table::Table<0x2::object::ID, 0x2::table::Table<0x2::object::ID, BurnedPositionInfo>>,
        must_full_range: bool,
        package_version: u64,
    }

    struct CetusLPBurnProof has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        position: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position,
    }

    struct BurnedPositionInfo has store {
        burned_position_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
    }

    struct BurnPositionEvent has copy, drop {
        position_id: 0x2::object::ID,
        burned_position_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
    }

    struct InitEvent has copy, drop {
        manager_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct SetPackageVersion has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    public entry fun burn<T0, T1>(arg0: &mut BurnManager, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = burn_lp<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<CetusLPBurnProof>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun burn_lp<T0, T1>(arg0: &mut BurnManager, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: &mut 0x2::tx_context::TxContext) : CetusLPBurnProof {
        checked_package_version(arg0);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg2);
        assert!(v0 == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), 3);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&arg2);
        if (arg0.must_full_range) {
            valid_full_range(v1, v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg1));
        };
        let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg2);
        let v4 = CetusLPBurnProof{
            id          : 0x2::object::new(arg3),
            name        : position_name(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::index<T0, T1>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::index(&arg2)),
            description : 0x1::string::utf8(b"Proof of Cetus LP Burn"),
            image_url   : 0x1::string::utf8(b"https://bq7bkvdje7gvgmv66hrxdy7wx5h5ggtrrnmt66rdkkehb64rvz3q.arweave.net/DD4VVGknzVMyvvHjceP2v0_TGnGLWT96I1KIcPuRrnc"),
            position    : arg2,
        };
        let v5 = 0x2::object::id<CetusLPBurnProof>(&v4);
        let v6 = BurnedPositionInfo{
            burned_position_id : v5,
            position_id        : v3,
            pool_id            : v0,
        };
        if (!0x2::table::contains<0x2::object::ID, 0x2::table::Table<0x2::object::ID, BurnedPositionInfo>>(&arg0.position, v0)) {
            0x2::table::add<0x2::object::ID, 0x2::table::Table<0x2::object::ID, BurnedPositionInfo>>(&mut arg0.position, v0, 0x2::table::new<0x2::object::ID, BurnedPositionInfo>(arg3));
        };
        0x2::table::add<0x2::object::ID, BurnedPositionInfo>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<0x2::object::ID, BurnedPositionInfo>>(&mut arg0.position, v0), v3, v6);
        let v7 = BurnPositionEvent{
            position_id        : v3,
            burned_position_id : v5,
            pool_id            : v0,
        };
        0x2::event::emit<BurnPositionEvent>(v7);
        v4
    }

    public fun burn_lp_v2(arg0: &mut BurnManager, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: &mut 0x2::tx_context::TxContext) : CetusLPBurnProof {
        checked_package_version(arg0);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&arg1);
        valid_full_range_v2(v0, v1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg1);
        let v4 = CetusLPBurnProof{
            id          : 0x2::object::new(arg2),
            name        : position_name_v2(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::index(&arg1)),
            description : 0x1::string::utf8(b"Proof of Cetus LP Burn"),
            image_url   : 0x1::string::utf8(b"https://bq7bkvdje7gvgmv66hrxdy7wx5h5ggtrrnmt66rdkkehb64rvz3q.arweave.net/DD4VVGknzVMyvvHjceP2v0_TGnGLWT96I1KIcPuRrnc"),
            position    : arg1,
        };
        let v5 = 0x2::object::id<CetusLPBurnProof>(&v4);
        let v6 = BurnedPositionInfo{
            burned_position_id : v5,
            position_id        : v2,
            pool_id            : v3,
        };
        if (!0x2::table::contains<0x2::object::ID, 0x2::table::Table<0x2::object::ID, BurnedPositionInfo>>(&arg0.position, v3)) {
            0x2::table::add<0x2::object::ID, 0x2::table::Table<0x2::object::ID, BurnedPositionInfo>>(&mut arg0.position, v3, 0x2::table::new<0x2::object::ID, BurnedPositionInfo>(arg2));
        };
        0x2::table::add<0x2::object::ID, BurnedPositionInfo>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<0x2::object::ID, BurnedPositionInfo>>(&mut arg0.position, v3), v2, v6);
        let v7 = BurnPositionEvent{
            position_id        : v2,
            burned_position_id : v5,
            pool_id            : v3,
        };
        0x2::event::emit<BurnPositionEvent>(v7);
        v4
    }

    public entry fun burn_v2(arg0: &mut BurnManager, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = burn_lp_v2(arg0, arg1, arg2);
        0x2::transfer::public_transfer<CetusLPBurnProof>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun checked_package_version(arg0: &BurnManager) {
        assert!(package_version() >= arg0.package_version, 1);
    }

    public fun collect_fee<T0, T1>(arg0: &BurnManager, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut CetusLPBurnProof, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        checked_package_version(arg0);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &arg3.position, true);
        (0x2::coin::from_balance<T0>(v0, arg4), 0x2::coin::from_balance<T1>(v1, arg4))
    }

    public fun collect_reward<T0, T1, T2>(arg0: &BurnManager, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut CetusLPBurnProof, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        checked_package_version(arg0);
        0x2::coin::from_balance<T2>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg1, arg2, &arg3.position, arg4, true, arg5), arg6)
    }

    fun init(arg0: LP_BURN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        let v4 = 0x2::package::claim<LP_BURN>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<CetusLPBurnProof>(&v4, v0, v2, arg1);
        0x2::display::update_version<CetusLPBurnProof>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CetusLPBurnProof>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = BurnManager{
            id              : 0x2::object::new(arg1),
            position        : 0x2::table::new<0x2::object::ID, 0x2::table::Table<0x2::object::ID, BurnedPositionInfo>>(arg1),
            must_full_range : true,
            package_version : 1,
        };
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<BurnManager>(v6);
        0x2::transfer::transfer<AdminCap>(v7, 0x2::tx_context::sender(arg1));
        let v8 = InitEvent{
            manager_id : 0x2::object::id<BurnManager>(&v6),
            cap_id     : 0x2::object::id<AdminCap>(&v7),
        };
        0x2::event::emit<InitEvent>(v8);
    }

    public fun package_version() : u64 {
        4
    }

    fun position_name(arg0: u64, arg1: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"Cetus Burned LP | Pool");
        0x1::string::append(&mut v0, str(arg0));
        0x1::string::append_utf8(&mut v0, b"-");
        0x1::string::append(&mut v0, str(arg1));
        v0
    }

    fun position_name_v2(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"Cetus Burned LP | Pool");
        0x1::string::append_utf8(&mut v0, b"-");
        0x1::string::append(&mut v0, str(arg0));
        v0
    }

    fun str(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            let v1 = ((arg0 % 10) as u8);
            arg0 = arg0 / 10;
            0x1::vector::push_back<u8>(&mut v0, v1 + 48);
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public entry fun update_must_range(arg0: &AdminCap, arg1: &mut BurnManager, arg2: bool) {
        arg1.must_full_range = arg2;
    }

    public fun update_package_version(arg0: &AdminCap, arg1: &mut BurnManager, arg2: u64) {
        arg1.package_version = arg2;
        let v0 = SetPackageVersion{
            new_version : arg2,
            old_version : arg1.package_version,
        };
        0x2::event::emit<SetPackageVersion>(v0);
    }

    public fun valid_full_range(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u32) {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::tick_bound() % arg2);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_tick(), v0)), 2);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(arg1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_tick(), v0)), 2);
    }

    public fun valid_full_range_v2(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::neg_from(443000)), 2);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(arg1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(443000)), 2);
    }

    // decompiled from Move bytecode v6
}

