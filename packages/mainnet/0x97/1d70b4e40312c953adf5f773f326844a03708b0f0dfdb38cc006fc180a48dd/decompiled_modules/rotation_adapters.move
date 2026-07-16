module 0x971d70b4e40312c953adf5f773f326844a03708b0f0dfdb38cc006fc180a48dd::rotation_adapters {
    struct Registry has key {
        id: 0x2::object::UID,
        admin_cap_id: 0x2::object::ID,
        profit_recipient: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct BluefinDeepSuiToCetusUsdcSuiCap<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct CetusUsdcSuiToBluefinDeepSuiCap<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct BluefinDeepRewardAdapter<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct CetusDeepRewardAdapter<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct CetusSuiRewardAdapter<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        profit_recipient: address,
    }

    struct AdapterRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        adapter_kind: u8,
    }

    struct BluefinToCetusRotated has copy, drop {
        reward_deep: u64,
        fee_deep: u64,
        fee_sui: u64,
        profit_sui: u64,
        source_principal_deep: u64,
        source_principal_sui: u64,
        principal_deep_to_sui: u64,
        principal_deep_as_sui: u64,
        principal_sui_to_usdc: u64,
        principal_usdc_out: u64,
        tick_lower: u32,
        tick_upper: u32,
        deposited_usdc: u64,
        deposited_sui: u64,
        residual_deep: u64,
        residual_usdc: u64,
        residual_sui: u64,
    }

    struct CetusToBluefinRotated has copy, drop {
        reward_deep: u64,
        reward_sui: u64,
        fee_usdc: u64,
        fee_sui: u64,
        profit_sui: u64,
        source_principal_usdc: u64,
        source_principal_sui: u64,
        principal_usdc_to_sui: u64,
        principal_usdc_as_sui: u64,
        principal_sui_to_deep: u64,
        principal_deep_out: u64,
        tick_lower: u32,
        tick_upper: u32,
        deposited_deep: u64,
        deposited_sui: u64,
        residual_usdc: u64,
        residual_deep: u64,
        residual_sui: u64,
    }

    fun assert_admin(arg0: &Registry, arg1: &AdminCap) {
        assert!(arg0.profit_recipient == @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292, 2);
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 0);
        assert!(0x2::object::id<AdminCap>(arg1) == arg0.admin_cap_id, 0);
    }

    fun assert_bluefin_deep_reward_adapter<T0, T1>(arg0: &Registry, arg1: &BluefinDeepRewardAdapter<T0, T1>) {
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 1);
    }

    fun assert_cetus_deep_reward_adapter<T0, T1, T2>(arg0: &Registry, arg1: &CetusDeepRewardAdapter<T0, T1, T2>) {
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 1);
    }

    fun assert_cetus_sui_reward_adapter<T0, T1>(arg0: &Registry, arg1: &CetusSuiRewardAdapter<T0, T1>) {
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 1);
    }

    fun assert_registry(arg0: &Registry) {
        assert!(arg0.profit_recipient == @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292, 2);
    }

    fun assert_route_bluefin_to_cetus<T0, T1, T2>(arg0: &Registry, arg1: &BluefinDeepSuiToCetusUsdcSuiCap<T0, T1, T2>) {
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 1);
    }

    fun assert_route_cetus_to_bluefin<T0, T1, T2>(arg0: &Registry, arg1: &CetusUsdcSuiToBluefinDeepSuiCap<T0, T1, T2>) {
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 1);
    }

    fun centered_range(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u32, arg2: u32) : (u32, u32) {
        assert!(arg2 > 0, 3);
        assert!(arg1 >= arg2, 3);
        assert!(arg1 % arg2 == 0, 3);
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg2);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg1 / 2));
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(v1, v0), v0);
        let v3 = v2;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(v1) && !0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(v1, v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero())) {
            v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v2, v0);
        };
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg1));
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(arg0, v3) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg0, v4), 3);
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v3), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v4))
    }

    public(friend) fun centered_range_for_test(arg0: u32, arg1: u32, arg2: u32) : (u32, u32) {
        centered_range(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0), arg1, arg2)
    }

    fun close_bluefin_with_fees<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = &mut arg3;
        let (v1, v2) = collect_bluefin_fees_if_any<T0, T1>(arg0, arg1, arg2, v0);
        let v3 = v2;
        let v4 = v1;
        let (_, _, v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut arg3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg3), arg0);
        let v9 = &mut arg3;
        let (v10, v11) = collect_bluefin_fees_if_any<T0, T1>(arg0, arg1, arg2, v9);
        0x2::balance::join<T0>(&mut v4, v10);
        0x2::balance::join<T1>(&mut v3, v11);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg0, arg1, arg2, arg3);
        (v7, v8, v4, v3)
    }

    fun close_cetus_with_fees<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &arg3, false);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg3), arg0);
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &arg3, false);
        0x2::balance::join<T0>(&mut v3, v6);
        0x2::balance::join<T1>(&mut v2, v7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg2, arg3);
        (v4, v5, v3, v2)
    }

    fun collect_bluefin_fees_if_any<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::get_accrued_fee(arg3);
        if (v0 > 0 || v1 > 0) {
            let (_, _, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg0, arg1, arg2, arg3);
            (v6, v7)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = AdminCap{
            id          : 0x2::object::new(arg0),
            registry_id : v1,
        };
        let v3 = 0x2::object::id<AdminCap>(&v2);
        let v4 = Registry{
            id               : v0,
            admin_cap_id     : v3,
            profit_recipient : @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292,
        };
        let v5 = RegistryCreated{
            registry_id      : v1,
            admin_cap_id     : v3,
            profit_recipient : @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292,
        };
        0x2::event::emit<RegistryCreated>(v5);
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Registry>(v4);
    }

    public fun register_bluefin_deep_reward_adapter<T0, T1>(arg0: &Registry, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = BluefinDeepRewardAdapter<T0, T1>{
            id          : 0x2::object::new(arg2),
            registry_id : 0x2::object::id<Registry>(arg0),
        };
        let v1 = AdapterRegistered{
            registry_id  : 0x2::object::id<Registry>(arg0),
            adapter_kind : 3,
        };
        0x2::event::emit<AdapterRegistered>(v1);
        0x2::transfer::public_transfer<BluefinDeepRewardAdapter<T0, T1>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun register_bluefin_deep_sui_to_cetus_usdc_sui<T0, T1, T2>(arg0: &Registry, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = BluefinDeepSuiToCetusUsdcSuiCap<T0, T1, T2>{
            id          : 0x2::object::new(arg2),
            registry_id : 0x2::object::id<Registry>(arg0),
        };
        let v1 = AdapterRegistered{
            registry_id  : 0x2::object::id<Registry>(arg0),
            adapter_kind : 1,
        };
        0x2::event::emit<AdapterRegistered>(v1);
        0x2::transfer::public_transfer<BluefinDeepSuiToCetusUsdcSuiCap<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun register_cetus_deep_reward_adapter<T0, T1, T2>(arg0: &Registry, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = CetusDeepRewardAdapter<T0, T1, T2>{
            id          : 0x2::object::new(arg2),
            registry_id : 0x2::object::id<Registry>(arg0),
        };
        let v1 = AdapterRegistered{
            registry_id  : 0x2::object::id<Registry>(arg0),
            adapter_kind : 4,
        };
        0x2::event::emit<AdapterRegistered>(v1);
        0x2::transfer::public_transfer<CetusDeepRewardAdapter<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun register_cetus_sui_reward_adapter<T0, T1>(arg0: &Registry, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = CetusSuiRewardAdapter<T0, T1>{
            id          : 0x2::object::new(arg2),
            registry_id : 0x2::object::id<Registry>(arg0),
        };
        let v1 = AdapterRegistered{
            registry_id  : 0x2::object::id<Registry>(arg0),
            adapter_kind : 5,
        };
        0x2::event::emit<AdapterRegistered>(v1);
        0x2::transfer::public_transfer<CetusSuiRewardAdapter<T0, T1>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun register_cetus_usdc_sui_to_bluefin_deep_sui<T0, T1, T2>(arg0: &Registry, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = CetusUsdcSuiToBluefinDeepSuiCap<T0, T1, T2>{
            id          : 0x2::object::new(arg2),
            registry_id : 0x2::object::id<Registry>(arg0),
        };
        let v1 = AdapterRegistered{
            registry_id  : 0x2::object::id<Registry>(arg0),
            adapter_kind : 2,
        };
        0x2::event::emit<AdapterRegistered>(v1);
        0x2::transfer::public_transfer<CetusUsdcSuiToBluefinDeepSuiCap<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun rotate_bluefin_deep_sui_to_cetus_usdc_sui<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &BluefinDeepSuiToCetusUsdcSuiCap<T0, T1, T2>, arg3: &BluefinDeepRewardAdapter<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg9: u64, arg10: u64, arg11: u32, arg12: u64, arg13: bool, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: &mut 0x2::tx_context::TxContext) {
        assert_registry(arg1);
        assert_route_bluefin_to_cetus<T0, T1, T2>(arg1, arg2);
        assert_bluefin_deep_reward_adapter<T0, T1>(arg1, arg3);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg4, arg5, &mut arg6);
        let (v1, v2, v3, v4) = close_bluefin_with_fees<T0, T1>(arg0, arg4, arg5, arg6);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = 0x2::balance::value<T0>(&v8);
        let v10 = 0x2::balance::value<T1>(&v7);
        assert!(v9 >= arg14, 4);
        assert!(v10 >= arg15, 5);
        0x2::balance::join<T0>(&mut v6, v0);
        let v11 = swap_bluefin_a_to_b<T0, T1>(arg0, arg4, arg5, v6);
        0x2::balance::join<T1>(&mut v11, v5);
        let v12 = 0x2::balance::value<T1>(&v11);
        assert!(v12 >= arg16, 6);
        0x2::balance::send_funds<T1>(v11, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        assert!(0x2::balance::value<T0>(&v8) >= arg9, 7);
        let v13 = swap_bluefin_a_to_b<T0, T1>(arg0, arg4, arg5, 0x2::balance::split<T0>(&mut v8, arg9));
        0x2::balance::join<T1>(&mut v7, v13);
        assert!(0x2::balance::value<T1>(&v7) >= arg10, 7);
        let v14 = swap_cetus_b_to_a<T2, T1>(arg0, arg7, arg8, 0x2::balance::split<T1>(&mut v7, arg10));
        let (v15, v16) = centered_range(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T2, T1>(arg8), arg11, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T2, T1>(arg8));
        let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T2, T1>(arg7, arg8, v15, v16, arg22);
        let v18 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T2, T1>(arg7, arg8, &mut v17, arg12, arg13, arg0);
        let (v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T2, T1>(&v18);
        assert!(0x2::balance::value<T2>(&v14) >= v19, 8);
        assert!(0x2::balance::value<T1>(&v7) >= v20, 9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T2, T1>(arg7, arg8, 0x2::balance::split<T2>(&mut v14, v19), 0x2::balance::split<T1>(&mut v7, v20), v18);
        let v21 = 0x2::balance::value<T0>(&v8);
        let v22 = 0x2::balance::value<T2>(&v14);
        let v23 = 0x2::balance::value<T1>(&v7);
        assert!(v19 >= arg17, 8);
        assert!(v20 >= arg18, 9);
        assert!(v21 <= arg19, 10);
        assert!(v22 <= arg20, 10);
        assert!(v23 <= arg21, 11);
        let v24 = BluefinToCetusRotated{
            reward_deep           : 0x2::balance::value<T0>(&v0),
            fee_deep              : 0x2::balance::value<T0>(&v6),
            fee_sui               : 0x2::balance::value<T1>(&v5),
            profit_sui            : v12,
            source_principal_deep : v9,
            source_principal_sui  : v10,
            principal_deep_to_sui : arg9,
            principal_deep_as_sui : 0x2::balance::value<T1>(&v13),
            principal_sui_to_usdc : arg10,
            principal_usdc_out    : 0x2::balance::value<T2>(&v14),
            tick_lower            : v15,
            tick_upper            : v16,
            deposited_usdc        : v19,
            deposited_sui         : v20,
            residual_deep         : v21,
            residual_usdc         : v22,
            residual_sui          : v23,
        };
        0x2::event::emit<BluefinToCetusRotated>(v24);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v17, 0x2::tx_context::sender(arg22));
        let v25 = 0x2::tx_context::sender(arg22);
        transfer_nonzero<T0>(v8, v25, arg22);
        let v26 = 0x2::tx_context::sender(arg22);
        transfer_nonzero<T2>(v14, v26, arg22);
        let v27 = 0x2::tx_context::sender(arg22);
        transfer_nonzero<T1>(v7, v27, arg22);
    }

    public fun rotate_cetus_usdc_sui_to_bluefin_deep_sui<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &CetusUsdcSuiToBluefinDeepSuiCap<T0, T1, T2>, arg3: &CetusDeepRewardAdapter<T0, T1, T2>, arg4: &CetusSuiRewardAdapter<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg9: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg10: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg11: u64, arg12: u64, arg13: u32, arg14: u64, arg15: bool, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: &mut 0x2::tx_context::TxContext) {
        assert_registry(arg1);
        assert_route_cetus_to_bluefin<T0, T1, T2>(arg1, arg2);
        assert_cetus_deep_reward_adapter<T0, T1, T2>(arg1, arg3);
        assert_cetus_sui_reward_adapter<T0, T1>(arg1, arg4);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg5, arg6, &arg7, arg8, true, arg0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg5, arg6, &arg7, arg8, true, arg0);
        let (v2, v3, v4, v5) = close_cetus_with_fees<T0, T1>(arg0, arg5, arg6, arg7);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = v2;
        let v10 = 0x2::balance::value<T0>(&v9);
        let v11 = 0x2::balance::value<T1>(&v8);
        assert!(v10 >= arg16, 4);
        assert!(v11 >= arg17, 5);
        let v12 = swap_bluefin_a_to_b<T2, T1>(arg0, arg9, arg10, v0);
        let v13 = swap_cetus_a_to_b<T0, T1>(arg0, arg5, arg6, v7);
        0x2::balance::join<T1>(&mut v1, v12);
        0x2::balance::join<T1>(&mut v1, v6);
        0x2::balance::join<T1>(&mut v1, v13);
        let v14 = 0x2::balance::value<T1>(&v1);
        assert!(v14 >= arg18, 6);
        0x2::balance::send_funds<T1>(v1, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        assert!(0x2::balance::value<T0>(&v9) >= arg11, 7);
        let v15 = swap_cetus_a_to_b<T0, T1>(arg0, arg5, arg6, 0x2::balance::split<T0>(&mut v9, arg11));
        0x2::balance::join<T1>(&mut v8, v15);
        assert!(0x2::balance::value<T1>(&v8) >= arg12, 7);
        let v16 = swap_bluefin_b_to_a<T2, T1>(arg0, arg9, arg10, 0x2::balance::split<T1>(&mut v8, arg12));
        let (v17, v18) = centered_range(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T2, T1>(arg10), arg13, 1);
        let v19 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T2, T1>(arg9, arg10, v17, v18, arg24);
        let (v20, v21, v22, v23) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T2, T1>(arg0, arg9, arg10, &mut v19, v16, v8, arg14, arg15);
        let v24 = v22;
        v8 = v23;
        let v25 = 0x2::balance::value<T0>(&v9);
        let v26 = 0x2::balance::value<T2>(&v24);
        let v27 = 0x2::balance::value<T1>(&v8);
        assert!(v20 >= arg19, 8);
        assert!(v21 >= arg20, 9);
        assert!(v25 <= arg21, 10);
        assert!(v26 <= arg22, 10);
        assert!(v27 <= arg23, 11);
        let v28 = CetusToBluefinRotated{
            reward_deep           : 0x2::balance::value<T2>(&v0),
            reward_sui            : 0x2::balance::value<T1>(&v1),
            fee_usdc              : 0x2::balance::value<T0>(&v7),
            fee_sui               : 0x2::balance::value<T1>(&v6),
            profit_sui            : v14,
            source_principal_usdc : v10,
            source_principal_sui  : v11,
            principal_usdc_to_sui : arg11,
            principal_usdc_as_sui : 0x2::balance::value<T1>(&v15),
            principal_sui_to_deep : arg12,
            principal_deep_out    : 0x2::balance::value<T2>(&v16),
            tick_lower            : v17,
            tick_upper            : v18,
            deposited_deep        : v20,
            deposited_sui         : v21,
            residual_usdc         : v25,
            residual_deep         : v26,
            residual_sui          : v27,
        };
        0x2::event::emit<CetusToBluefinRotated>(v28);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v19, 0x2::tx_context::sender(arg24));
        let v29 = 0x2::tx_context::sender(arg24);
        transfer_nonzero<T0>(v9, v29, arg24);
        let v30 = 0x2::tx_context::sender(arg24);
        transfer_nonzero<T2>(v24, v30, arg24);
        let v31 = 0x2::tx_context::sender(arg24);
        transfer_nonzero<T1>(v8, v31, arg24);
    }

    fun swap_bluefin_a_to_b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg3);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg3);
            0x2::balance::zero<T1>()
        } else {
            let (v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg0, arg1, arg2, true, true, v0, 4295048017 + 1);
            0x2::balance::join<T0>(&mut arg3, v2);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, arg3, 0x2::balance::zero<T1>(), v4);
            v3
        }
    }

    fun swap_bluefin_b_to_a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg3);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T1>(arg3);
            0x2::balance::zero<T0>()
        } else {
            let (v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg0, arg1, arg2, false, true, v0, 79226673515401279992447579055 - 1);
            0x2::balance::join<T1>(&mut arg3, v3);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), arg3, v4);
            v2
        }
    }

    fun swap_cetus_a_to_b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg3);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg3);
            0x2::balance::zero<T1>()
        } else {
            let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, v0, 4295048017 + 1, arg0);
            0x2::balance::join<T0>(&mut arg3, v2);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, arg3, 0x2::balance::zero<T1>(), v4);
            v3
        }
    }

    fun swap_cetus_b_to_a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg3);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T1>(arg3);
            0x2::balance::zero<T0>()
        } else {
            let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, v0, 79226673515401279992447579055 - 1, arg0);
            0x2::balance::join<T1>(&mut arg3, v3);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), arg3, v4);
            v2
        }
    }

    fun transfer_nonzero<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

