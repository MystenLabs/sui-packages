module 0x1580207c562f936d03f38ffe80db7f770b3304784927c98f82ee691c9a6e97c7::swap {
    struct SwapPointsEvent has copy, drop {
        recipient: address,
        points_awarded: u64,
        total_points: u64,
        v_amount: u64,
    }

    struct SwapPoints has store, key {
        id: 0x2::object::UID,
        points: u64,
    }

    struct SwapCap has store, key {
        id: 0x2::object::UID,
    }

    struct SwapPointsConfig has store, key {
        id: 0x2::object::UID,
        v_to_sui: u64,
        sui_to_v: u64,
        paused: bool,
        type_name: 0x1::type_name::TypeName,
    }

    struct GameRewardPool has key {
        id: 0x2::object::UID,
        total_xp: u64,
        reserve_xp: u64,
        reserve_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        claimed_sui_amount: u64,
        status: bool,
    }

    struct FeeConfig has store, key {
        id: 0x2::object::UID,
        dev_share: u64,
        committee_share: u64,
        pool_share: u64,
        dev_address: address,
        committee_address: address,
        total_fee: u64,
    }

    entry fun add_reserve(arg0: &0x1580207c562f936d03f38ffe80db7f770b3304784927c98f82ee691c9a6e97c7::swap_version::AdminCap, arg1: &0x1580207c562f936d03f38ffe80db7f770b3304784927c98f82ee691c9a6e97c7::swap_version::SwapVersion, arg2: &mut GameRewardPool, arg3: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x1580207c562f936d03f38ffe80db7f770b3304784927c98f82ee691c9a6e97c7::swap_version::validate_version(arg1);
        add_reserve_sui(arg2, arg3);
    }

    fun add_reserve_sui(arg0: &mut GameRewardPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reserve_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun add_reserve_xp(arg0: &SwapCap, arg1: &mut GameRewardPool, arg2: u64) {
        arg1.total_xp = arg1.total_xp + arg2;
        arg1.reserve_xp = arg1.reserve_xp + arg2;
    }

    fun add_swap_points(arg0: &mut SwapPoints, arg1: u64) {
        arg0.points = arg0.points + arg1;
    }

    entry fun add_type_to_swap_points_config<T0>(arg0: &0x1580207c562f936d03f38ffe80db7f770b3304784927c98f82ee691c9a6e97c7::swap_version::AdminCap, arg1: &0x1580207c562f936d03f38ffe80db7f770b3304784927c98f82ee691c9a6e97c7::swap_version::SwapVersion, arg2: &mut SwapPointsConfig) {
        0x1580207c562f936d03f38ffe80db7f770b3304784927c98f82ee691c9a6e97c7::swap_version::validate_version(arg1);
        arg2.type_name = 0x1::type_name::get<T0>();
    }

    public fun borrow_game_reward_pool_claimed_sui_amount(arg0: &GameRewardPool) : u64 {
        arg0.claimed_sui_amount
    }

    public fun borrow_game_reward_pool_reserve_sui(arg0: &GameRewardPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.reserve_sui)
    }

    public fun borrow_game_reward_pool_reserve_xp(arg0: &GameRewardPool) : u64 {
        arg0.reserve_xp
    }

    public fun borrow_game_reward_pool_status(arg0: &GameRewardPool) : bool {
        arg0.status
    }

    public fun borrow_game_reward_pool_total_xp(arg0: &GameRewardPool) : u64 {
        arg0.total_xp
    }

    public fun create_swap_points(arg0: &SwapCap, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = SwapPoints{
            id     : 0x2::object::new(arg1),
            points : 0,
        };
        0x2::transfer::public_share_object<SwapPoints>(v0);
        0x2::object::id<SwapPoints>(&v0)
    }

    public fun get_committee_address(arg0: &FeeConfig) : address {
        arg0.committee_address
    }

    public fun get_committee_share(arg0: &FeeConfig) : u64 {
        arg0.committee_share
    }

    public fun get_dev_address(arg0: &FeeConfig) : address {
        arg0.dev_address
    }

    public fun get_dev_share(arg0: &FeeConfig) : u64 {
        arg0.dev_share
    }

    public fun get_earned_sui_from_pool(arg0: &SwapCap, arg1: &mut GameRewardPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        arg1.claimed_sui_amount = arg1.claimed_sui_amount + arg2;
        arg1.reserve_xp = arg1.reserve_xp - arg2;
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.reserve_sui, arg2), arg3)
    }

    public fun get_pool_share(arg0: &FeeConfig) : u64 {
        arg0.pool_share
    }

    public fun get_sui_to_v(arg0: &SwapPointsConfig) : u64 {
        arg0.sui_to_v
    }

    public fun get_swap_points(arg0: &SwapPoints) : u64 {
        arg0.points
    }

    public fun get_total_fee(arg0: &FeeConfig) : u64 {
        arg0.total_fee
    }

    public fun get_v_to_sui(arg0: &SwapPointsConfig) : u64 {
        arg0.v_to_sui
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameRewardPool{
            id                 : 0x2::object::new(arg0),
            total_xp           : 0,
            reserve_xp         : 0,
            reserve_sui        : 0x2::balance::zero<0x2::sui::SUI>(),
            claimed_sui_amount : 0,
            status             : false,
        };
        0x2::transfer::share_object<GameRewardPool>(v0);
        let v1 = SwapPointsConfig{
            id        : 0x2::object::new(arg0),
            v_to_sui  : 0,
            sui_to_v  : 0,
            paused    : true,
            type_name : 0x1::type_name::get<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<SwapPointsConfig>(v1);
        let v2 = FeeConfig{
            id                : 0x2::object::new(arg0),
            dev_share         : 0,
            committee_share   : 0,
            pool_share        : 0,
            dev_address       : @0x0,
            committee_address : @0x0,
            total_fee         : 0,
        };
        0x2::transfer::share_object<FeeConfig>(v2);
        let v3 = SwapCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<SwapCap>(v3, 0x2::tx_context::sender(arg0));
    }

    fun percentage(arg0: u128, arg1: u128) : u128 {
        arg0 * arg1 / (10000 as u128)
    }

    entry fun set_swap_points_sui_to_v(arg0: &0x1580207c562f936d03f38ffe80db7f770b3304784927c98f82ee691c9a6e97c7::swap_version::AdminCap, arg1: &0x1580207c562f936d03f38ffe80db7f770b3304784927c98f82ee691c9a6e97c7::swap_version::SwapVersion, arg2: &mut SwapPointsConfig, arg3: u64) {
        0x1580207c562f936d03f38ffe80db7f770b3304784927c98f82ee691c9a6e97c7::swap_version::validate_version(arg1);
        arg2.sui_to_v = arg3;
    }

    entry fun set_swap_points_v_to_sui(arg0: &0x1580207c562f936d03f38ffe80db7f770b3304784927c98f82ee691c9a6e97c7::swap_version::AdminCap, arg1: &0x1580207c562f936d03f38ffe80db7f770b3304784927c98f82ee691c9a6e97c7::swap_version::SwapVersion, arg2: &mut SwapPointsConfig, arg3: u64) {
        0x1580207c562f936d03f38ffe80db7f770b3304784927c98f82ee691c9a6e97c7::swap_version::validate_version(arg1);
        arg2.v_to_sui = arg3;
    }

    entry fun swap_flowx<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u128, arg5: u64, arg6: bool, arg7: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg8: &0x2::clock::Clock, arg9: &mut SwapPoints, arg10: &SwapPointsConfig, arg11: &FeeConfig, arg12: &mut GameRewardPool, arg13: &0x1580207c562f936d03f38ffe80db7f770b3304784927c98f82ee691c9a6e97c7::swap_version::SwapVersion, arg14: &mut 0x2::tx_context::TxContext) {
        0x1580207c562f936d03f38ffe80db7f770b3304784927c98f82ee691c9a6e97c7::swap_version::validate_version(arg13);
        assert!(!arg10.paused, 2);
        assert!(0x1::type_name::get<T0>() == 0x1::type_name::get<0x2::sui::SUI>() || 0x1::type_name::get<T0>() == arg10.type_name, 3);
        assert!(0x1::type_name::get<T1>() == 0x1::type_name::get<0x2::sui::SUI>() || 0x1::type_name::get<T1>() == arg10.type_name, 3);
        let (v0, v1) = if (arg6) {
            let v2 = 0x2::coin::value<T0>(&arg2);
            let v3 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg14);
            let v4 = (percentage((0x2::coin::value<0x2::sui::SUI>(&v3) as u128), (get_total_fee(arg11) as u128)) as u64);
            let v5 = (percentage((v4 as u128), (get_dev_share(arg11) as u128)) as u64);
            let v6 = (percentage((v4 as u128), (get_committee_share(arg11) as u128)) as u64);
            let v7 = v4 - v5 - v6;
            assert!(v5 + v6 + v7 == v4, 4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v3, v5, arg14), get_dev_address(arg11));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v3, v6, arg14), get_committee_address(arg11));
            add_reserve_sui(arg12, 0x2::coin::split<0x2::sui::SUI>(&mut v3, v7, arg14));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, 0x2::tx_context::sender(arg14));
            ((percentage((v2 as u128), (get_v_to_sui(arg10) as u128)) as u64), v2)
        } else {
            let v8 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg14);
            let v9 = 0x2::coin::value<T1>(&v8);
            let v10 = (percentage((v9 as u128), (get_total_fee(arg11) as u128)) as u64);
            let v11 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<T1, 0x2::sui::SUI>(arg0, arg1, 0x2::coin::split<T1>(&mut v8, v10, arg14), arg3, arg4, arg5, arg7, arg8, arg14);
            let v12 = 0x2::coin::value<0x2::sui::SUI>(&v11);
            let v13 = (percentage((v12 as u128), (get_dev_share(arg11) as u128)) as u64);
            let v14 = (percentage((v12 as u128), (get_committee_share(arg11) as u128)) as u64);
            assert!(v13 + v14 + v10 - v13 - v14 == v10, 4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v11, v13, arg14), get_dev_address(arg11));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v11, v14, arg14), get_committee_address(arg11));
            add_reserve_sui(arg12, v11);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v8, 0x2::tx_context::sender(arg14));
            ((percentage((v9 as u128), (get_sui_to_v(arg10) as u128)) as u64), v9)
        };
        add_swap_points(arg9, v0);
        let v15 = SwapPointsEvent{
            recipient      : 0x2::tx_context::sender(arg14),
            points_awarded : v0,
            total_points   : get_swap_points(arg9),
            v_amount       : v1,
        };
        0x2::event::emit<SwapPointsEvent>(v15);
    }

    entry fun toggle_swap_points_paused(arg0: &0x1580207c562f936d03f38ffe80db7f770b3304784927c98f82ee691c9a6e97c7::swap_version::AdminCap, arg1: &0x1580207c562f936d03f38ffe80db7f770b3304784927c98f82ee691c9a6e97c7::swap_version::SwapVersion, arg2: &mut SwapPointsConfig) {
        0x1580207c562f936d03f38ffe80db7f770b3304784927c98f82ee691c9a6e97c7::swap_version::validate_version(arg1);
        arg2.paused = !arg2.paused;
    }

    fun update_fee_config(arg0: &mut FeeConfig, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: address, arg6: u64) {
        validate_percentage(arg1 + arg2 + arg3);
        arg0.dev_share = arg1;
        arg0.committee_share = arg2;
        arg0.pool_share = arg3;
        arg0.dev_address = arg4;
        arg0.committee_address = arg5;
        arg0.total_fee = arg6;
    }

    entry fun update_swap_points_fee_config(arg0: &0x1580207c562f936d03f38ffe80db7f770b3304784927c98f82ee691c9a6e97c7::swap_version::AdminCap, arg1: &0x1580207c562f936d03f38ffe80db7f770b3304784927c98f82ee691c9a6e97c7::swap_version::SwapVersion, arg2: &mut FeeConfig, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: address, arg8: u64) {
        0x1580207c562f936d03f38ffe80db7f770b3304784927c98f82ee691c9a6e97c7::swap_version::validate_version(arg1);
        update_fee_config(arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun validate_percentage(arg0: u64) {
        assert!(arg0 == 10000, 1);
    }

    // decompiled from Move bytecode v6
}

