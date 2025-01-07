module 0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager {
    struct TurbosPositionKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct CetusPositionKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct Keys has copy, drop, store {
        idx: u8,
    }

    struct Balances has copy, drop, store {
        type_: 0x1::type_name::TypeName,
    }

    struct ManagerCap has store, key {
        id: 0x2::object::UID,
        manager_id: 0x2::object::ID,
    }

    struct LiquidityManager has store, key {
        id: 0x2::object::UID,
        timer: 0x1::option::Option<u64>,
        fields: 0x2::bag::Bag,
    }

    struct TurbosLockedPosition has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct CetusLockedPosition has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
    }

    public fun add_cetus_position(arg0: &mut LiquidityManager, arg1: &ManagerCap, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = CetusLockedPosition{
            id          : 0x2::object::new(arg3),
            position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg2),
        };
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg2);
        let v2 = CetusPositionKey{id: v1};
        0x2::bag::add<CetusPositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.fields, v2, arg2);
        insert_cetus_key(arg0, v1);
        0x2::transfer::public_transfer<CetusLockedPosition>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun add_cetus_positions(arg0: &mut LiquidityManager, arg1: &ManagerCap, arg2: vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg2);
        while (v0 > 0) {
            let v1 = 0x1::vector::pop_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg2);
            let v2 = CetusLockedPosition{
                id          : 0x2::object::new(arg3),
                position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v1),
            };
            let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v1);
            let v4 = CetusPositionKey{id: v3};
            0x2::bag::add<CetusPositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.fields, v4, v1);
            insert_cetus_key(arg0, v3);
            0x2::transfer::public_transfer<CetusLockedPosition>(v2, 0x2::tx_context::sender(arg3));
            v0 = v0 - 1;
        };
        0x1::vector::destroy_empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg2);
    }

    public fun add_turbos_position(arg0: &mut LiquidityManager, arg1: &ManagerCap, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = TurbosLockedPosition{
            id          : 0x2::object::new(arg3),
            nft_id      : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&arg2),
            position_id : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::position_id(&arg2),
        };
        let v1 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&arg2);
        let v2 = TurbosPositionKey{id: v1};
        0x2::bag::add<TurbosPositionKey, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut arg0.fields, v2, arg2);
        insert_turbos_key(arg0, v1);
        0x2::transfer::public_transfer<TurbosLockedPosition>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun add_turbos_positions(arg0: &mut LiquidityManager, arg1: &ManagerCap, arg2: vector<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = 0x1::vector::length<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&arg2);
        while (v0 > 0) {
            let v1 = 0x1::vector::pop_back<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut arg2);
            let v2 = TurbosLockedPosition{
                id          : 0x2::object::new(arg3),
                nft_id      : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&v1),
                position_id : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::position_id(&v1),
            };
            let v3 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&v1);
            let v4 = TurbosPositionKey{id: v3};
            0x2::bag::add<TurbosPositionKey, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut arg0.fields, v4, v1);
            insert_turbos_key(arg0, v3);
            0x2::transfer::public_transfer<TurbosLockedPosition>(v2, 0x2::tx_context::sender(arg3));
            v0 = v0 - 1;
        };
        0x1::vector::destroy_empty<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg2);
    }

    public(friend) fun assert_admin(arg0: &LiquidityManager, arg1: &ManagerCap) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.manager_id, 0);
    }

    public fun borrow_cetus_position(arg0: &LiquidityManager, arg1: &ManagerCap, arg2: 0x2::object::ID) : &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        assert_admin(arg0, arg1);
        let v0 = CetusPositionKey{id: arg2};
        0x2::bag::borrow<CetusPositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.fields, v0)
    }

    public fun borrow_turbos_position(arg0: &LiquidityManager, arg1: &ManagerCap, arg2: 0x2::object::ID) : &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT {
        assert_admin(arg0, arg1);
        let v0 = TurbosPositionKey{id: arg2};
        0x2::bag::borrow<TurbosPositionKey, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&arg0.fields, v0)
    }

    public fun cetus_position_id(arg0: &CetusLockedPosition) : 0x2::object::ID {
        arg0.position_id
    }

    public(friend) fun get_balance<T0>(arg0: &mut LiquidityManager) : &0x2::balance::Balance<T0> {
        let v0 = Balances{type_: 0x1::type_name::get<T0>()};
        if (!0x2::bag::contains<Balances>(&arg0.fields, v0)) {
            let v1 = Balances{type_: 0x1::type_name::get<T0>()};
            0x2::bag::add<Balances, 0x2::balance::Balance<T0>>(&mut arg0.fields, v1, 0x2::balance::zero<T0>());
        };
        let v2 = Balances{type_: 0x1::type_name::get<T0>()};
        0x2::bag::borrow<Balances, 0x2::balance::Balance<T0>>(&arg0.fields, v2)
    }

    public(friend) fun get_balance_mut<T0>(arg0: &mut LiquidityManager) : &mut 0x2::balance::Balance<T0> {
        let v0 = Balances{type_: 0x1::type_name::get<T0>()};
        if (!0x2::bag::contains<Balances>(&arg0.fields, v0)) {
            let v1 = Balances{type_: 0x1::type_name::get<T0>()};
            0x2::bag::add<Balances, 0x2::balance::Balance<T0>>(&mut arg0.fields, v1, 0x2::balance::zero<T0>());
        };
        let v2 = Balances{type_: 0x1::type_name::get<T0>()};
        0x2::bag::borrow_mut<Balances, 0x2::balance::Balance<T0>>(&mut arg0.fields, v2)
    }

    public fun get_cetus_keys(arg0: &LiquidityManager, arg1: &ManagerCap) : &vector<0x2::object::ID> {
        assert_admin(arg0, arg1);
        let v0 = Keys{idx: 1};
        0x2::bag::borrow<Keys, vector<0x2::object::ID>>(&arg0.fields, v0)
    }

    public(friend) fun get_cetus_position(arg0: &mut LiquidityManager, arg1: 0x2::object::ID) : &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        let v0 = CetusPositionKey{id: arg1};
        0x2::bag::borrow_mut<CetusPositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.fields, v0)
    }

    public fun get_turbos_keys(arg0: &LiquidityManager, arg1: &ManagerCap) : &vector<0x2::object::ID> {
        assert_admin(arg0, arg1);
        let v0 = Keys{idx: 0};
        0x2::bag::borrow<Keys, vector<0x2::object::ID>>(&arg0.fields, v0)
    }

    public(friend) fun get_turbos_position(arg0: &mut LiquidityManager, arg1: 0x2::object::ID) : &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT {
        let v0 = TurbosPositionKey{id: arg1};
        0x2::bag::borrow_mut<TurbosPositionKey, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut arg0.fields, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LiquidityManager{
            id     : 0x2::object::new(arg0),
            timer  : 0x1::option::none<u64>(),
            fields : 0x2::bag::new(arg0),
        };
        let v1 = ManagerCap{
            id         : 0x2::object::new(arg0),
            manager_id : 0x2::object::uid_to_inner(&v0.id),
        };
        0x2::transfer::public_share_object<LiquidityManager>(v0);
        0x2::transfer::public_transfer<ManagerCap>(v1, @0xf3fab23da0ce35a901f995dc8da5f4492ad78510ed33b3422417609d22730e7d);
    }

    fun insert_cetus_key(arg0: &mut LiquidityManager, arg1: 0x2::object::ID) {
        let v0 = Keys{idx: 1};
        if (!0x2::bag::contains<Keys>(&arg0.fields, v0)) {
            let v1 = Keys{idx: 1};
            0x2::bag::add<Keys, vector<0x2::object::ID>>(&mut arg0.fields, v1, 0x1::vector::empty<0x2::object::ID>());
        };
        let v2 = Keys{idx: 1};
        0x1::vector::push_back<0x2::object::ID>(0x2::bag::borrow_mut<Keys, vector<0x2::object::ID>>(&mut arg0.fields, v2), arg1);
    }

    fun insert_turbos_key(arg0: &mut LiquidityManager, arg1: 0x2::object::ID) {
        let v0 = Keys{idx: 0};
        if (!0x2::bag::contains<Keys>(&arg0.fields, v0)) {
            let v1 = Keys{idx: 0};
            0x2::bag::add<Keys, vector<0x2::object::ID>>(&mut arg0.fields, v1, 0x1::vector::empty<0x2::object::ID>());
        };
        let v2 = Keys{idx: 0};
        0x1::vector::push_back<0x2::object::ID>(0x2::bag::borrow_mut<Keys, vector<0x2::object::ID>>(&mut arg0.fields, v2), arg1);
    }

    public fun set_lock_time(arg0: &mut LiquidityManager, arg1: &ManagerCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_admin(arg0, arg1);
        if (0x1::option::is_some<u64>(&arg0.timer)) {
            assert!(*0x1::option::borrow<u64>(&arg0.timer) >= 0x2::clock::timestamp_ms(arg3), 1);
            0x1::option::swap<u64>(&mut arg0.timer, arg2);
        } else {
            0x1::option::fill<u64>(&mut arg0.timer, arg2);
        };
    }

    public fun turbos_nft_id(arg0: &TurbosLockedPosition) : 0x2::object::ID {
        arg0.nft_id
    }

    public fun turbos_position_id(arg0: &TurbosLockedPosition) : 0x2::object::ID {
        arg0.position_id
    }

    public fun withdraw_cetus_position_after_timeout(arg0: &mut LiquidityManager, arg1: &ManagerCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        assert_admin(arg0, arg1);
        assert!(0x1::option::is_some<u64>(&arg0.timer), 2);
        assert!(0x2::clock::timestamp_ms(arg3) >= *0x1::option::borrow<u64>(&arg0.timer), 1);
        let v0 = CetusPositionKey{id: arg2};
        0x2::bag::remove<CetusPositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.fields, v0)
    }

    public fun withdraw_turbos_position_after_timeout(arg0: &mut LiquidityManager, arg1: &ManagerCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT {
        assert_admin(arg0, arg1);
        assert!(0x1::option::is_some<u64>(&arg0.timer), 2);
        assert!(0x2::clock::timestamp_ms(arg3) >= *0x1::option::borrow<u64>(&arg0.timer), 1);
        let v0 = TurbosPositionKey{id: arg2};
        0x2::bag::remove<TurbosPositionKey, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut arg0.fields, v0)
    }

    // decompiled from Move bytecode v6
}

