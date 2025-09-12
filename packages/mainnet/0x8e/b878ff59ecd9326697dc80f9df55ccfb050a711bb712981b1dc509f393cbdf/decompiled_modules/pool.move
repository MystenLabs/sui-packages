module 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool {
    struct POOL has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        index: u64,
        v_parameters: 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::parameters::VariableParameters,
        active_id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        base_fee_rate: u64,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        protocol_fee_a: u64,
        protocol_fee_b: u64,
        reward_manager: 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::reward::RewardManager,
        bin_manager: 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::BinManager,
        position_manager: 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::PositionManager,
        url: 0x1::string::String,
        permissions: Permissions,
        active_open_positions: u64,
    }

    struct Permissions has copy, drop, store {
        disable_add: bool,
        disable_remove: bool,
        disable_swap: bool,
        disable_collect_fee: bool,
        disable_collect_reward: bool,
        disable_add_reward: bool,
    }

    struct SwapResult has copy, drop {
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        ref_fee: u64,
        protocol_fee: u64,
        steps: vector<BinSwap>,
    }

    struct BinSwap has copy, drop {
        bin_id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        var_fee_rate: u64,
    }

    struct FeeRate has copy, drop {
        base_fee_rate: u64,
        var_fee_rate: u64,
        total_fee_rate: u64,
    }

    struct BinLiquidityDelta has copy, drop {
        bin_id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        liquidity_share: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct FlashSwapReceipt<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        a2b: bool,
        partner_id: 0x2::object::ID,
        pay_amount: u64,
        ref_fee_amount: u64,
    }

    struct ProtocolFeeCollectCap has store, key {
        id: 0x2::object::UID,
    }

    struct OpenPositionCert<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        width: u16,
        next_bin_id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        position_info: 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::PositionInfo,
        total_amount_a: u64,
        total_amount_b: u64,
        active_id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        active_id_amount_a: u64,
        active_id_amount_b: u64,
        fee_a: u64,
        fee_b: u64,
        active_id_added: bool,
        liquidity_deltas: vector<BinLiquidityDelta>,
    }

    struct AddLiquidityCert<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        position_info: 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::PositionInfo,
        total_amount_a: u64,
        total_amount_b: u64,
        active_id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        active_id_amount_a: u64,
        active_id_amount_b: u64,
        fee_a: u64,
        fee_b: u64,
        active_id_added: bool,
        liquidity_deltas: vector<BinLiquidityDelta>,
    }

    struct OpenPositionEvent has copy, drop {
        pool: 0x2::object::ID,
        position_id: 0x2::object::ID,
        lower_bin_id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        width: u16,
        active_id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
    }

    struct ClosePositionEvent has copy, drop {
        pool: 0x2::object::ID,
        position_id: 0x2::object::ID,
        active_id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        total_amount_a: u64,
        total_amount_b: u64,
        fee_a: u64,
        fee_b: u64,
        rewards: vector<u64>,
        liquidity_deltas: vector<BinLiquidityDelta>,
    }

    struct AddLiquidityEvent has copy, drop {
        pool: 0x2::object::ID,
        position_id: 0x2::object::ID,
        active_id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        total_amount_a: u64,
        total_amount_b: u64,
        fee_a: u64,
        fee_b: u64,
        liquidity_deltas: vector<BinLiquidityDelta>,
    }

    struct RemoveLiquidityEvent has copy, drop {
        pool: 0x2::object::ID,
        position_id: 0x2::object::ID,
        active_id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        total_amount_a: u64,
        total_amount_b: u64,
        liquidity_deltas: vector<BinLiquidityDelta>,
    }

    struct SwapEvent has copy, drop {
        pool: 0x2::object::ID,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        partner: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        protocol_fee: u64,
        ref_fee: u64,
        vault_a: u64,
        vault_b: u64,
        bin_swaps: vector<BinSwap>,
    }

    struct CollectProtocolFeeEvent has copy, drop {
        pool: 0x2::object::ID,
        fee_a: u64,
        fee_b: u64,
    }

    struct CollectFeeEvent has copy, drop {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        fee_a: u64,
        fee_b: u64,
    }

    struct CollectRewardEvent has copy, drop {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        reward: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct InitializeRewardEvent has copy, drop {
        pool: 0x2::object::ID,
        reward: 0x1::type_name::TypeName,
    }

    struct AddRewardEvent has copy, drop {
        pool: 0x2::object::ID,
        reward: 0x1::type_name::TypeName,
        amount: u64,
        start_time: u64,
        end_time: u64,
    }

    struct UpdatePermissionsEvent has copy, drop {
        pool: 0x2::object::ID,
        old_permissions: Permissions,
        new_permissions: Permissions,
    }

    struct MakeRewardPublicEvent has copy, drop {
        pool: 0x2::object::ID,
    }

    struct MakeRewardPrivateEvent has copy, drop {
        pool: 0x2::object::ID,
    }

    struct EmergencyPauseRewardEvent has copy, drop {
        pool: 0x2::object::ID,
    }

    struct EmergencyUnpauseRewardEvent has copy, drop {
        pool: 0x2::object::ID,
    }

    struct EmergencyWithdrawRefundRewardEvent has copy, drop {
        pool: 0x2::object::ID,
        reward: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct UpdateBaseFeeRateEvent has copy, drop {
        pool: 0x2::object::ID,
        old_base_fee_rate: u64,
        new_base_fee_rate: u64,
    }

    public fun add_group_if_absent<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned) : &mut 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::BinGroupRef {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg2);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::add_group_if_absent(&mut arg0.bin_manager, arg1)
    }

    public fun borrow_bin<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::Bin {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_bin(&arg0.bin_manager, arg1)
    }

    public fun borrow_group_ref<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::BinGroupRef {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_group_ref(&arg0.bin_manager, arg1)
    }

    public fun borrow_mut_group_ref<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) : &mut 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::BinGroupRef {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_mut_group_ref(&mut arg0.bin_manager, arg1)
    }

    public fun contains_group<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : bool {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::contains_group(&arg0.bin_manager, arg1)
    }

    public fun fetch_bins<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x1::option::Option<u32>, arg2: u64) : vector<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::BinInfo> {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::fetch_bins(&arg0.bin_manager, arg1, arg2)
    }

    public fun bin_step<T0, T1>(arg0: &Pool<T0, T1>) : u16 {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::parameters::bin_step(&arg0.v_parameters)
    }

    public fun get_variable_fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::parameters::get_variable_fee_rate(&arg0.v_parameters)
    }

    public fun active_id<T0, T1>(arg0: &Pool<T0, T1>) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.active_id
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position, arg2: vector<u32>, arg3: vector<u64>, arg4: vector<u64>, arg5: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg6: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : AddLiquidityCert<T0, T1> {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg6);
        operation_check<T0, T1>(arg0, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::restriction::add_kind(), 0x2::tx_context::sender(arg8), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position>(arg1)), arg5);
        let v0 = if (0x1::vector::length<u32>(&arg2) == 0x1::vector::length<u64>(&arg3)) {
            if (0x1::vector::length<u32>(&arg2) == 0x1::vector::length<u64>(&arg4)) {
                0x1::vector::length<u32>(&arg2) > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13906839998319427591);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::pool_id(arg1), 13906840006909100035);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(&arg2, 0));
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v1, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::lower_bin_id(arg1)) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(&arg2, 0x1::vector::length<u32>(&arg2) - 1)), 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::upper_bin_id(arg1)), 13906840019797147699);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::mark_add_pending(arg1);
        arg0.active_open_positions = arg0.active_open_positions + 1;
        reward_settle<T0, T1>(arg0, arg7);
        let v2 = AddLiquidityCert<T0, T1>{
            pool_id            : 0x2::object::id<Pool<T0, T1>>(arg0),
            position_id        : 0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position>(arg1),
            position_info      : 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::extract_position_info(&mut arg0.position_manager, 0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position>(arg1)),
            total_amount_a     : 0,
            total_amount_b     : 0,
            active_id          : arg0.active_id,
            active_id_amount_a : 0,
            active_id_amount_b : 0,
            fee_a              : 0,
            fee_b              : 0,
            active_id_added    : false,
            liquidity_deltas   : 0x1::vector::empty<BinLiquidityDelta>(),
        };
        let v3 = 0;
        let (v4, _) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::resolve_bin_position(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::bin_score(v1));
        let v6 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::add_group_if_absent(&mut arg0.bin_manager, v4);
        while (v3 < 0x1::vector::length<u32>(&arg2)) {
            let v7 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(&arg2, v3));
            let (v8, v9) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::resolve_bin_position(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::bin_score(v7));
            if (v8 != v4) {
                v6 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::add_group_if_absent(&mut arg0.bin_manager, v8);
            };
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v7, v2.active_id)) {
                0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::parameters::update_volatility_parameter(&mut arg0.v_parameters, v7, 0x2::clock::timestamp_ms(arg7) / 1000);
                let v10 = calculate_total_fee_rate(&arg0.v_parameters, arg0.base_fee_rate);
                let (v11, v12, v13, v14) = apply_active_bin_composition_fees(v6, v7, *0x1::vector::borrow<u64>(&arg3, v3), *0x1::vector::borrow<u64>(&arg4, v3), v10.total_fee_rate, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::parameters::protocol_fee_rate(&arg0.v_parameters));
                v2.fee_a = v2.fee_a + v11;
                v2.fee_b = v2.fee_b + v12;
                v2.active_id_amount_a = v2.active_id_amount_a + *0x1::vector::borrow<u64>(&arg3, v3);
                v2.active_id_amount_b = v2.active_id_amount_b + *0x1::vector::borrow<u64>(&arg4, v3);
                arg0.protocol_fee_a = arg0.protocol_fee_a + v13;
                arg0.protocol_fee_b = arg0.protocol_fee_b + v14;
            };
            let v15 = &mut v2;
            add_liquidity_on_bin<T0, T1>(arg1, v15, v6, v9, *0x1::vector::borrow<u64>(&arg3, v3), *0x1::vector::borrow<u64>(&arg4, v3), arg6);
            v3 = v3 + 1;
        };
        v2
    }

    public fun add_liquidity_on_bin<T0, T1>(arg0: &mut 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position, arg1: &mut AddLiquidityCert<T0, T1>, arg2: &mut 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::BinGroupRef, arg3: u8, arg4: u64, arg5: u64, arg6: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg6);
        assert!(arg1.position_id == 0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position>(arg0), 13906839646131978245);
        assert!(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::pool_id(arg2) == arg1.pool_id, 13906839650429829169);
        if (arg4 == 0 && arg5 == 0) {
            return
        };
        let v0 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::add_bin_in_group_if_absent(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_bin_group_mut(arg2), arg3);
        arg1.total_amount_a = arg1.total_amount_a + arg4;
        arg1.total_amount_b = arg1.total_amount_b + arg5;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::id(v0), arg1.active_id)) {
            assert!(!arg1.active_id_added, 13906839697674076203);
            arg1.active_id_added = true;
            assert!(arg4 == arg1.active_id_amount_a && arg5 == arg1.active_id_amount_b, 13906839714853814313);
            arg4 = arg4 - arg1.fee_a;
            arg5 = arg5 - arg1.fee_b;
        };
        let (v1, v2, v3) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::increase_liquidity(v0, arg4, arg5, arg1.active_id);
        arg1.total_amount_a = arg1.total_amount_a - v1;
        arg1.total_amount_b = arg1.total_amount_b - v2;
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::increase_liquidity(&mut arg1.position_info, arg0, v0, v3);
        let v4 = BinLiquidityDelta{
            bin_id          : 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::id(v0),
            liquidity_share : v3,
            amount_a        : arg4 - v1,
            amount_b        : arg5 - v2,
        };
        0x1::vector::push_back<BinLiquidityDelta>(&mut arg1.liquidity_deltas, v4);
    }

    public fun add_reward<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T2>, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: u64, arg5: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg6: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg6);
        operation_check<T0, T1>(arg0, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::restriction::add_reward_kind(), 0x2::tx_context::sender(arg8), 0x1::option::none<0x2::object::ID>(), arg5);
        if (!0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::reward::is_public(&arg0.reward_manager) || !0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::is_reward_public(arg5)) {
            0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::check_reward_manager_role(arg5, 0x2::tx_context::sender(arg8));
        };
        let v0 = if (0x1::option::is_none<u64>(&arg3)) {
            0x2::clock::timestamp_ms(arg7) / 1000
        } else {
            *0x1::option::borrow<u64>(&arg3)
        };
        assert!(v0 < arg4, 13906845736397570083);
        if (!0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::has_reward_manager_role(arg5, 0x2::tx_context::sender(arg8))) {
            assert!(arg4 - v0 >= 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::min_reward_duration(arg5), 13906845762167111711);
            assert!((arg4 - 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::reward_period_start_at()) % 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::reward_period() == 0, 13906845779347243043);
        };
        reward_settle<T0, T1>(arg0, arg7);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::reward::add_reward<T2>(&mut arg0.reward_manager, arg3, arg4, 0x2::coin::into_balance<T2>(arg1), arg7);
        let v1 = AddRewardEvent{
            pool       : 0x2::object::id<Pool<T0, T1>>(arg0),
            reward     : 0x1::type_name::with_original_ids<T2>(),
            amount     : arg2,
            start_time : v0,
            end_time   : arg4,
        };
        0x2::event::emit<AddRewardEvent>(v1);
    }

    public fun amounts<T0, T1>(arg0: &AddLiquidityCert<T0, T1>) : (u64, u64) {
        (arg0.total_amount_a, arg0.total_amount_b)
    }

    public fun amounts_in_active_bin<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        if (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::contains(&arg0.bin_manager, arg0.active_id)) {
            let v2 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_bin(&arg0.bin_manager, arg0.active_id);
            (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::amount_a(v2), 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::amount_b(v2))
        } else {
            (0, 0)
        }
    }

    fun apply_active_bin_composition_fees(arg0: &mut 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::BinGroupRef, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64, u64, u64) {
        if (arg2 == 0 && arg3 == 0) {
            return (0, 0, 0, 0)
        };
        let (_, v1) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::resolve_bin_position(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::bin_score(arg1));
        let v2 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_bin_group_mut(arg0);
        if (!0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::contain_in_group(v2, v1)) {
            return (0, 0, 0, 0)
        };
        let v3 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_mut_bin_from_group(v2, v1);
        let (v4, v5) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::get_composition_fees(v3, arg2, arg3, arg4);
        let v6 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::dlmm_math::calculate_fee_inclusive(v4, arg5);
        let v7 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::dlmm_math::calculate_fee_inclusive(v5, arg5);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::accumulate_fee(v3, v4 - v6, v5 - v7);
        (v4, v5, v6, v7)
    }

    public fun base_fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.base_fee_rate
    }

    public fun bin_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::BinManager {
        &arg0.bin_manager
    }

    public fun calculate_total_fee_rate(arg0: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::parameters::VariableParameters, arg1: u64) : FeeRate {
        let v0 = (0x1::u128::min((arg1 as u128) + (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::parameters::get_variable_fee_rate(arg0) as u128), (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::max_fee_rate() as u128)) as u64);
        FeeRate{
            base_fee_rate  : arg1,
            var_fee_rate   : v0 - arg1,
            total_fee_rate : v0,
        }
    }

    public fun close_position<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position, arg2: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg3: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::ClosePositionCert, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg3);
        operation_check<T0, T1>(arg0, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::restriction::remove_kind(), 0x2::tx_context::sender(arg5), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position>(&arg1)), arg2);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::pool_id(&arg1), 13906843120760389635);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::assert_no_pending_add(&arg1);
        reward_settle<T0, T1>(arg0, arg4);
        let v0 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::close_position(&mut arg0.position_manager, arg1);
        let v1 = 0x1::vector::empty<BinLiquidityDelta>();
        let (v2, _) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::resolve_bin_position(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::bin_score(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::upper_bin_id_on_position_info(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::position_info(&v0))));
        let v4 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::zero_bin_group_ref();
        let v5 = false;
        let v6 = if (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::contains_group(&arg0.bin_manager, v2)) {
            v5 = true;
            0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_mut_group_ref(&mut arg0.bin_manager, v2)
        } else {
            &mut v4
        };
        let v7 = v6;
        while (!0x1::vector::is_empty<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::BinStat>(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::cert_stats(&v0))) {
            let v8 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::pop_position_bin(&mut v0);
            let v9 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::liquidity_share(&v8);
            let v10 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::bin_id(&v8);
            let (v11, v12) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::resolve_bin_position(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::bin_score(v10));
            if (v11 != v2) {
                let v13 = if (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::contains_group(&arg0.bin_manager, v11)) {
                    v5 = true;
                    0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_mut_group_ref(&mut arg0.bin_manager, v11)
                } else {
                    v5 = false;
                    &mut v4
                };
                v7 = v13;
            };
            let v14 = v5 && 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::contain_in_group(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_bin_group(v7), v12);
            let (v15, v16) = if (!v14) {
                assert!(v9 == 0, 13906843271085817883);
                0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::destroy_bin_stat(v8);
                (0, 0)
            } else {
                let v17 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_mut_bin_from_group(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_bin_group_mut(v7), v12);
                let (v18, v19) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::close_position_bin(&mut v0, v17, v8);
                if (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::liquidity_supply(v17) == 0) {
                    0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::remove_bin_from_group(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_bin_group_mut(v7), v12);
                    if (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::is_empty_group(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_bin_group(v7))) {
                        let v20 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::group_idx(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_bin_group(v7));
                        v7 = &mut v4;
                        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::remove_group(&mut arg0.bin_manager, (v20 as u64));
                    };
                };
                (v18, v19)
            };
            let v21 = BinLiquidityDelta{
                bin_id          : v10,
                liquidity_share : v9,
                amount_a        : v15,
                amount_b        : v16,
            };
            0x1::vector::push_back<BinLiquidityDelta>(&mut v1, v21);
        };
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::destroy_zero_bin_group_ref(v4);
        let (v22, v23) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::take_amounts_from_close_cert(&mut v0);
        let (v24, v25) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::take_fee_from_close_cert(&mut v0);
        let v26 = ClosePositionEvent{
            pool             : 0x2::object::id<Pool<T0, T1>>(arg0),
            position_id      : 0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position>(&arg1),
            active_id        : arg0.active_id,
            total_amount_a   : v22,
            total_amount_b   : v23,
            fee_a            : v24,
            fee_b            : v25,
            rewards          : *0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::cert_rewards_owned(&v0),
            liquidity_deltas : v1,
        };
        0x2::event::emit<ClosePositionEvent>(v26);
        (v0, 0x2::balance::split<T0>(&mut arg0.balance_a, v22 + v24), 0x2::balance::split<T1>(&mut arg0.balance_b, v23 + v25))
    }

    public fun collect_position_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position, arg2: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg3: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg3);
        operation_check<T0, T1>(arg0, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::restriction::collect_fee_kind(), 0x2::tx_context::sender(arg4), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position>(arg1)), arg2);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::pool_id(arg1), 13906842639724052483);
        let (v0, v1) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::take_fee_from_position(&mut arg0.position_manager, arg1);
        let v2 = CollectFeeEvent{
            pool     : 0x2::object::id<Pool<T0, T1>>(arg0),
            position : 0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position>(arg1),
            fee_a    : v0,
            fee_b    : v1,
        };
        0x2::event::emit<CollectFeeEvent>(v2);
        (0x2::balance::split<T0>(&mut arg0.balance_a, v0), 0x2::balance::split<T1>(&mut arg0.balance_b, v1))
    }

    public fun collect_position_reward<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position, arg2: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg3: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg3);
        operation_check<T0, T1>(arg0, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::restriction::collect_reward_kind(), 0x2::tx_context::sender(arg4), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position>(arg1)), arg2);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::pool_id(arg1), 13906842875947253763);
        let v0 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::take_reward_from_position(&mut arg0.position_manager, arg1, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::reward::get_index<T2>(&arg0.reward_manager));
        let v1 = CollectRewardEvent{
            pool     : 0x2::object::id<Pool<T0, T1>>(arg0),
            position : 0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position>(arg1),
            reward   : 0x1::type_name::with_original_ids<T2>(),
            amount   : v0,
        };
        0x2::event::emit<CollectRewardEvent>(v1);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::reward::withdraw<T2>(&mut arg0.reward_manager, v0)
    }

    public fun collect_protocol_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg2: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg2);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::check_protocol_fee_manager_role(arg1, 0x2::tx_context::sender(arg3));
        let v0 = arg0.protocol_fee_a;
        let v1 = arg0.protocol_fee_b;
        arg0.protocol_fee_a = 0;
        arg0.protocol_fee_b = 0;
        let v2 = CollectProtocolFeeEvent{
            pool  : 0x2::object::id<Pool<T0, T1>>(arg0),
            fee_a : v0,
            fee_b : v1,
        };
        0x2::event::emit<CollectProtocolFeeEvent>(v2);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_a, v0), arg3), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance_b, v1), arg3))
    }

    public fun collect_protocol_fee_with_cap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg2: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg3: &ProtocolFeeCollectCap) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg2);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::check_protocol_fee_manager_role(arg1, 0x2::object::id_address<ProtocolFeeCollectCap>(arg3));
        let v0 = arg0.protocol_fee_a;
        let v1 = arg0.protocol_fee_b;
        arg0.protocol_fee_a = 0;
        arg0.protocol_fee_b = 0;
        let v2 = CollectProtocolFeeEvent{
            pool  : 0x2::object::id<Pool<T0, T1>>(arg0),
            fee_a : v0,
            fee_b : v1,
        };
        0x2::event::emit<CollectProtocolFeeEvent>(v2);
        (0x2::balance::split<T0>(&mut arg0.balance_a, v0), 0x2::balance::split<T1>(&mut arg0.balance_b, v1))
    }

    public fun contains_bin<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : bool {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::contains(&arg0.bin_manager, arg1)
    }

    fun default_swap_result() : SwapResult {
        SwapResult{
            amount_in    : 0,
            amount_out   : 0,
            fee          : 0,
            ref_fee      : 0,
            protocol_fee : 0,
            steps        : 0x1::vector::empty<BinSwap>(),
        }
    }

    public fun destroy_close_position_cert(arg0: 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::ClosePositionCert, arg1: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg1);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::destroy_cert(arg0);
    }

    public fun disable_add(arg0: &Permissions) : bool {
        arg0.disable_add
    }

    public fun disable_add_reward(arg0: &Permissions) : bool {
        arg0.disable_add_reward
    }

    public fun disable_collect_fee(arg0: &Permissions) : bool {
        arg0.disable_collect_fee
    }

    public fun disable_collect_reward(arg0: &Permissions) : bool {
        arg0.disable_collect_reward
    }

    public fun disable_remove(arg0: &Permissions) : bool {
        arg0.disable_remove
    }

    public fun disable_swap(arg0: &Permissions) : bool {
        arg0.disable_swap
    }

    public fun emergency_pause_reward<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg2: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg2);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::reward::emergency_pause(&mut arg0.reward_manager);
        let v0 = EmergencyPauseRewardEvent{pool: 0x2::object::id<Pool<T0, T1>>(arg0)};
        0x2::event::emit<EmergencyPauseRewardEvent>(v0);
    }

    public fun emergency_unpause_reward<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg2: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg2);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::reward::emergency_unpause(&mut arg0.reward_manager);
        let v0 = EmergencyUnpauseRewardEvent{pool: 0x2::object::id<Pool<T0, T1>>(arg0)};
        0x2::event::emit<EmergencyUnpauseRewardEvent>(v0);
    }

    public fun emergency_withdraw_refund_reward<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg2: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg2);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::check_reward_manager_role(arg1, 0x2::tx_context::sender(arg3));
        let v0 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::reward::emergency_withdraw_refund_reward<T2>(&mut arg0.reward_manager);
        let v1 = EmergencyWithdrawRefundRewardEvent{
            pool   : 0x2::object::id<Pool<T0, T1>>(arg0),
            reward : 0x1::type_name::with_original_ids<T2>(),
            amount : 0x2::balance::value<T2>(&v0),
        };
        0x2::event::emit<EmergencyWithdrawRefundRewardEvent>(v1);
        0x2::coin::from_balance<T2>(v0, arg3)
    }

    public fun flash_swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg5: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg5);
        operation_check<T0, T1>(arg0, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::restriction::swap_kind(), 0x2::tx_context::sender(arg7), 0x1::option::none<0x2::object::ID>(), arg4);
        flash_swap_internal<T0, T1>(arg0, 0x2::object::id_from_address(@0x0), 0, arg1, arg2, arg3, arg6)
    }

    fun flash_swap_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::object::ID, arg2: u64, arg3: bool, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        assert!(arg5 > 0, 13906846277562400787);
        reward_settle<T0, T1>(arg0, arg6);
        assert!(arg0.active_open_positions == 0, 13906846286154170415);
        let v0 = swap_in_pool<T0, T1>(arg0, arg5, arg3, arg4, arg2, arg6);
        let (v1, v2) = if (arg3) {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg0.balance_b, v0.amount_out))
        } else {
            (0x2::balance::split<T0>(&mut arg0.balance_a, v0.amount_out), 0x2::balance::zero<T1>())
        };
        assert!(v0.amount_out > 0, 13906846333397106709);
        let (v3, v4) = if (arg3) {
            (0x1::type_name::with_original_ids<T0>(), 0x1::type_name::with_original_ids<T1>())
        } else {
            (0x1::type_name::with_original_ids<T1>(), 0x1::type_name::with_original_ids<T0>())
        };
        let v5 = SwapEvent{
            pool         : 0x2::object::id<Pool<T0, T1>>(arg0),
            from         : v3,
            target       : v4,
            partner      : arg1,
            amount_in    : v0.amount_in,
            amount_out   : v0.amount_out,
            fee          : v0.fee,
            protocol_fee : v0.protocol_fee,
            ref_fee      : v0.ref_fee,
            vault_a      : 0x2::balance::value<T0>(&arg0.balance_a),
            vault_b      : 0x2::balance::value<T1>(&arg0.balance_b),
            bin_swaps    : v0.steps,
        };
        0x2::event::emit<SwapEvent>(v5);
        let v6 = FlashSwapReceipt<T0, T1>{
            pool_id        : 0x2::object::id<Pool<T0, T1>>(arg0),
            a2b            : arg3,
            partner_id     : arg1,
            pay_amount     : v0.amount_in,
            ref_fee_amount : v0.ref_fee,
        };
        (v1, v2, v6)
    }

    public fun flash_swap_with_partner<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::partner::Partner, arg2: bool, arg3: bool, arg4: u64, arg5: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg6: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg6);
        operation_check<T0, T1>(arg0, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::restriction::swap_kind(), 0x2::tx_context::sender(arg8), 0x1::option::none<0x2::object::ID>(), arg5);
        flash_swap_internal<T0, T1>(arg0, 0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::partner::Partner>(arg1), 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::partner::current_ref_fee_rate(arg1, 0x2::clock::timestamp_ms(arg7) / 1000), arg2, arg3, arg4, arg7)
    }

    public fun get_total_fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : FeeRate {
        let v0 = (0x1::u128::min((arg0.base_fee_rate as u128) + (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::parameters::get_variable_fee_rate(&arg0.v_parameters) as u128), (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::max_fee_rate() as u128)) as u64);
        FeeRate{
            base_fee_rate  : arg0.base_fee_rate,
            var_fee_rate   : v0 - arg0.base_fee_rate,
            total_fee_rate : v0,
        }
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<POOL>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun initialize_reward<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg2: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg2);
        operation_check<T0, T1>(arg0, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::restriction::add_reward_kind(), 0x2::tx_context::sender(arg4), 0x1::option::none<0x2::object::ID>(), arg1);
        if (!0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::reward::is_public(&arg0.reward_manager) || !0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::is_reward_public(arg1)) {
            0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::check_reward_manager_role(arg1, 0x2::tx_context::sender(arg4));
        };
        if (!0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::has_reward_manager_role(arg1, 0x2::tx_context::sender(arg4))) {
            let v0 = if (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::is_whitelist<T2>(arg1)) {
                true
            } else if (0x1::type_name::with_original_ids<T0>() == 0x1::type_name::with_original_ids<T2>()) {
                true
            } else {
                0x1::type_name::with_original_ids<T1>() == 0x1::type_name::with_original_ids<T2>()
            };
            assert!(v0, 13906845482992926731);
            assert!(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::reward::reward_num(&arg0.reward_manager) < (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::non_manager_initialize_reward_cap(arg1) as u64), 13906845500174237729);
        };
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::reward::initialize_reward<T2>(&mut arg0.reward_manager, arg3, arg4);
        let v1 = InitializeRewardEvent{
            pool   : 0x2::object::id<Pool<T0, T1>>(arg0),
            reward : 0x1::type_name::with_original_ids<T2>(),
        };
        0x2::event::emit<InitializeRewardEvent>(v1);
    }

    public fun make_reward_private<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg2: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg3: &0x2::tx_context::TxContext) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg2);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::check_reward_manager_role(arg1, 0x2::tx_context::sender(arg3));
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::reward::make_private(&mut arg0.reward_manager);
        let v0 = MakeRewardPrivateEvent{pool: 0x2::object::id<Pool<T0, T1>>(arg0)};
        0x2::event::emit<MakeRewardPrivateEvent>(v0);
    }

    public fun make_reward_public<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg2: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg3: &0x2::tx_context::TxContext) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg2);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::check_reward_manager_role(arg1, 0x2::tx_context::sender(arg3));
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::reward::make_public(&mut arg0.reward_manager);
        let v0 = MakeRewardPublicEvent{pool: 0x2::object::id<Pool<T0, T1>>(arg0)};
        0x2::event::emit<MakeRewardPublicEvent>(v0);
    }

    public fun mint_protocol_fee_collect_cap(arg0: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::admin_cap::AdminCap, arg1: address, arg2: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg2);
        let v0 = ProtocolFeeCollectCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<ProtocolFeeCollectCap>(v0, arg1);
    }

    public fun new_add_liquidity_cert<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position, arg2: u64, arg3: u64, arg4: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg5: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : AddLiquidityCert<T0, T1> {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg5);
        operation_check<T0, T1>(arg0, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::restriction::add_kind(), 0x2::tx_context::sender(arg7), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position>(arg1)), arg4);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::pool_id(arg1), 13906839358369038339);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::mark_add_pending(arg1);
        arg0.active_open_positions = arg0.active_open_positions + 1;
        reward_settle<T0, T1>(arg0, arg6);
        let v0 = arg0.active_id;
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::parameters::update_volatility_parameter(&mut arg0.v_parameters, v0, 0x2::clock::timestamp_ms(arg6) / 1000);
        let v1 = calculate_total_fee_rate(&arg0.v_parameters, arg0.base_fee_rate);
        let (v2, _) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::resolve_bin_position(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::bin_score(v0));
        let v4 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::add_group_if_absent(&mut arg0.bin_manager, v2);
        let (v5, v6, v7, v8) = apply_active_bin_composition_fees(v4, v0, arg2, arg3, v1.total_fee_rate, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::parameters::protocol_fee_rate(&arg0.v_parameters));
        arg0.protocol_fee_a = arg0.protocol_fee_a + v7;
        arg0.protocol_fee_b = arg0.protocol_fee_b + v8;
        AddLiquidityCert<T0, T1>{
            pool_id            : 0x2::object::id<Pool<T0, T1>>(arg0),
            position_id        : 0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position>(arg1),
            position_info      : 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::extract_position_info(&mut arg0.position_manager, 0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position>(arg1)),
            total_amount_a     : 0,
            total_amount_b     : 0,
            active_id          : arg0.active_id,
            active_id_amount_a : arg2,
            active_id_amount_b : arg3,
            fee_a              : v5,
            fee_b              : v6,
            active_id_added    : false,
            liquidity_deltas   : 0x1::vector::empty<BinLiquidityDelta>(),
        }
    }

    public fun new_open_position_cert<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u32, arg2: u16, arg3: u64, arg4: u64, arg5: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg6: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position, OpenPositionCert<T0, T1>) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg6);
        operation_check<T0, T1>(arg0, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::restriction::add_kind(), 0x2::tx_context::sender(arg8), 0x1::option::none<0x2::object::ID>(), arg5);
        arg0.active_open_positions = arg0.active_open_positions + 1;
        assert!(arg2 <= 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::max_bin_per_position(), 13906838671175712793);
        reward_settle<T0, T1>(arg0, arg7);
        let v0 = arg0.active_id;
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::parameters::update_volatility_parameter(&mut arg0.v_parameters, v0, 0x2::clock::timestamp_ms(arg7) / 1000);
        let v1 = calculate_total_fee_rate(&arg0.v_parameters, arg0.base_fee_rate);
        let (v2, _) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::resolve_bin_position(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::bin_score(v0));
        let v4 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::add_group_if_absent(&mut arg0.bin_manager, v2);
        let (v5, v6, v7, v8) = apply_active_bin_composition_fees(v4, v0, arg3, arg4, v1.total_fee_rate, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::parameters::protocol_fee_rate(&arg0.v_parameters));
        arg0.protocol_fee_a = arg0.protocol_fee_a + v7;
        arg0.protocol_fee_b = arg0.protocol_fee_b + v8;
        let v9 = 0x2::object::id<Pool<T0, T1>>(arg0);
        let v10 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1);
        let v11 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::open_position<T0, T1>(&mut arg0.position_manager, v9, arg0.index, v10, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v10, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from((arg2 as u32))), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1)), arg0.url, arg8);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::mark_add_pending(&mut v11);
        let v12 = 0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position>(&v11);
        let v13 = OpenPositionCert<T0, T1>{
            pool_id            : v9,
            position_id        : v12,
            width              : arg2,
            next_bin_id        : v10,
            position_info      : 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::extract_position_info(&mut arg0.position_manager, v12),
            total_amount_a     : 0,
            total_amount_b     : 0,
            active_id          : arg0.active_id,
            active_id_amount_a : arg3,
            active_id_amount_b : arg4,
            fee_a              : v5,
            fee_b              : v6,
            active_id_added    : false,
            liquidity_deltas   : 0x1::vector::empty<BinLiquidityDelta>(),
        };
        let v14 = OpenPositionEvent{
            pool         : v9,
            position_id  : v12,
            lower_bin_id : v10,
            width        : arg2,
            active_id    : arg0.active_id,
        };
        0x2::event::emit<OpenPositionEvent>(v14);
        (v11, v13)
    }

    public(friend) fun new_pool<T0, T1>(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u64, arg2: 0x1::string::String, arg3: 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::BinStepConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        let v0 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::bin_step(&arg3);
        let v1 = 0x2::object::new(arg5);
        let v2 = Permissions{
            disable_add            : false,
            disable_remove         : false,
            disable_swap           : false,
            disable_collect_fee    : false,
            disable_collect_reward : false,
            disable_add_reward     : false,
        };
        Pool<T0, T1>{
            id                    : v1,
            index                 : arg1,
            v_parameters          : 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::parameters::new_variable_parameters(arg3, arg0),
            active_id             : arg0,
            base_fee_rate         : (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::base_factor(&arg3) as u64) * (v0 as u64) * 10,
            balance_a             : 0x2::balance::zero<T0>(),
            balance_b             : 0x2::balance::zero<T1>(),
            protocol_fee_a        : 0,
            protocol_fee_b        : 0,
            reward_manager        : 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::reward::new_reward_manager(arg5),
            bin_manager           : 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::new_bin_manager(0x2::object::uid_to_inner(&v1), v0, 0x2::clock::timestamp_ms(arg4), arg5),
            position_manager      : 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::new_position_manager(v0, arg5),
            url                   : arg2,
            permissions           : v2,
            active_open_positions : 0,
        }
    }

    public fun open_cert_amounts<T0, T1>(arg0: &OpenPositionCert<T0, T1>) : (u64, u64) {
        (arg0.total_amount_a, arg0.total_amount_b)
    }

    public fun open_position<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<u32>, arg2: vector<u64>, arg3: vector<u64>, arg4: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg5: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position, OpenPositionCert<T0, T1>) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg5);
        operation_check<T0, T1>(arg0, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::restriction::add_kind(), 0x2::tx_context::sender(arg7), 0x1::option::none<0x2::object::ID>(), arg4);
        arg0.active_open_positions = arg0.active_open_positions + 1;
        let v0 = if (0x1::vector::length<u32>(&arg1) == 0x1::vector::length<u64>(&arg2)) {
            if (0x1::vector::length<u32>(&arg1) == 0x1::vector::length<u64>(&arg3)) {
                0x1::vector::length<u32>(&arg1) > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13906838147188523015);
        let v1 = (0x1::vector::length<u32>(&arg1) as u16);
        assert!(v1 <= 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::max_bin_per_position(), 13906838160075915309);
        reward_settle<T0, T1>(arg0, arg6);
        let v2 = 0x2::object::id<Pool<T0, T1>>(arg0);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(&arg1, 0));
        let v4 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::open_position<T0, T1>(&mut arg0.position_manager, v2, arg0.index, v3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from((v1 as u32))), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1)), arg0.url, arg7);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::mark_add_pending(&mut v4);
        let v5 = 0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position>(&v4);
        let v6 = OpenPositionCert<T0, T1>{
            pool_id            : v2,
            position_id        : v5,
            width              : v1,
            next_bin_id        : v3,
            position_info      : 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::extract_position_info(&mut arg0.position_manager, v5),
            total_amount_a     : 0,
            total_amount_b     : 0,
            active_id          : arg0.active_id,
            active_id_amount_a : 0,
            active_id_amount_b : 0,
            fee_a              : 0,
            fee_b              : 0,
            active_id_added    : false,
            liquidity_deltas   : 0x1::vector::empty<BinLiquidityDelta>(),
        };
        let v7 = 0;
        let (v8, _) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::resolve_bin_position(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::bin_score(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(&arg1, 0))));
        let v10 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::add_group_if_absent(&mut arg0.bin_manager, v8);
        while (v7 < 0x1::vector::length<u32>(&arg1)) {
            let v11 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(&arg1, v7));
            let (v12, v13) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::resolve_bin_position(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::bin_score(v11));
            if (v12 != v8) {
                v10 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::add_group_if_absent(&mut arg0.bin_manager, v12);
            };
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v11, v6.active_id)) {
                0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::parameters::update_volatility_parameter(&mut arg0.v_parameters, v11, 0x2::clock::timestamp_ms(arg6) / 1000);
                let v14 = calculate_total_fee_rate(&arg0.v_parameters, arg0.base_fee_rate);
                let (v15, v16, v17, v18) = apply_active_bin_composition_fees(v10, v11, *0x1::vector::borrow<u64>(&arg2, v7), *0x1::vector::borrow<u64>(&arg3, v7), v14.total_fee_rate, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::parameters::protocol_fee_rate(&arg0.v_parameters));
                v6.fee_a = v6.fee_a + v15;
                v6.fee_b = v6.fee_b + v16;
                v6.active_id_amount_a = v6.active_id_amount_a + *0x1::vector::borrow<u64>(&arg2, v7);
                v6.active_id_amount_b = v6.active_id_amount_b + *0x1::vector::borrow<u64>(&arg3, v7);
                arg0.protocol_fee_a = arg0.protocol_fee_a + v17;
                arg0.protocol_fee_b = arg0.protocol_fee_b + v18;
            };
            let v19 = &mut v4;
            let v20 = &mut v6;
            open_position_on_bin<T0, T1>(v19, v20, v10, v13, *0x1::vector::borrow<u64>(&arg2, v7), *0x1::vector::borrow<u64>(&arg3, v7), arg5);
            v7 = v7 + 1;
        };
        (v4, v6)
    }

    public fun open_position_on_bin<T0, T1>(arg0: &mut 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position, arg1: &mut OpenPositionCert<T0, T1>, arg2: &mut 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::BinGroupRef, arg3: u8, arg4: u64, arg5: u64, arg6: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg6);
        assert!(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::pool_id(arg2) == arg1.pool_id, 13906839066314276913);
        let v0 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::add_bin_in_group_if_absent(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_bin_group_mut(arg2), arg3);
        let v1 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::id(v0);
        assert!(arg1.position_id == 0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position>(arg0), 13906839079196295173);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v1, arg1.next_bin_id), 13906839087787540505);
        arg1.next_bin_id = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(arg1.next_bin_id, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        arg1.total_amount_a = arg1.total_amount_a + arg4;
        arg1.total_amount_b = arg1.total_amount_b + arg5;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::id(v0), arg1.active_id)) {
            assert!(!arg1.active_id_added, 13906839117853491243);
            arg1.active_id_added = true;
            assert!(arg4 == arg1.active_id_amount_a && arg5 == arg1.active_id_amount_b, 13906839135033229353);
            arg4 = arg4 - arg1.fee_a;
            arg5 = arg5 - arg1.fee_b;
        };
        let (v2, v3, v4) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::increase_liquidity(v0, arg4, arg5, arg1.active_id);
        arg1.total_amount_a = arg1.total_amount_a - v2;
        arg1.total_amount_b = arg1.total_amount_b - v3;
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::add_liquidity(&mut arg1.position_info, arg0, v0, v4);
        let v5 = BinLiquidityDelta{
            bin_id          : v1,
            liquidity_share : v4,
            amount_a        : arg4 - v2,
            amount_b        : arg5 - v3,
        };
        0x1::vector::push_back<BinLiquidityDelta>(&mut arg1.liquidity_deltas, v5);
    }

    fun operation_check<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::restriction::OperationKind, arg2: address, arg3: 0x1::option::Option<0x2::object::ID>, arg4: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::check_user_operation(arg4, arg2, arg1);
        if (0x1::option::is_some<0x2::object::ID>(&arg3)) {
            0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::check_position_operation(arg4, *0x1::option::borrow<0x2::object::ID>(&arg3), arg1);
        };
        if (arg1 == 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::restriction::add_kind()) {
            assert!(!arg0.permissions.disable_add, 13906848803001991169);
        } else if (arg1 == 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::restriction::remove_kind()) {
            assert!(!arg0.permissions.disable_remove, 13906848811591925761);
        } else if (arg1 == 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::restriction::swap_kind()) {
            assert!(!arg0.permissions.disable_swap, 13906848820181860353);
        } else if (arg1 == 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::restriction::collect_fee_kind()) {
            assert!(!arg0.permissions.disable_collect_fee, 13906848828771794945);
        } else if (arg1 == 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::restriction::collect_reward_kind()) {
            assert!(!arg0.permissions.disable_collect_reward, 13906848837361729537);
        } else if (arg1 == 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::restriction::add_reward_kind()) {
            assert!(!arg0.permissions.disable_add_reward, 13906848845951664129);
        };
    }

    public fun pay_amount<T0, T1>(arg0: &FlashSwapReceipt<T0, T1>) : u64 {
        arg0.pay_amount
    }

    public fun permissions<T0, T1>(arg0: &Pool<T0, T1>) : &Permissions {
        &arg0.permissions
    }

    public fun position_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::PositionManager {
        &arg0.position_manager
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position, arg2: vector<u32>, arg3: vector<u128>, arg4: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg5: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg5);
        operation_check<T0, T1>(arg0, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::restriction::remove_kind(), 0x2::tx_context::sender(arg7), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position>(arg1)), arg4);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::pool_id(arg1), 13906841063471054851);
        assert!(0x1::vector::length<u32>(&arg2) == 0x1::vector::length<u128>(&arg3), 13906841067767726109);
        let v0 = 0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position>(arg1);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::assert_no_pending_add(arg1);
        reward_settle<T0, T1>(arg0, arg6);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::empty<BinLiquidityDelta>();
        let v4 = 0;
        let v5 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::borrow_mut_position_info(&mut arg0.position_manager, v0);
        let (v6, _) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::resolve_bin_position(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::bin_score(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(&arg2, 0))));
        let v8 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::zero_bin_group_ref();
        let v9 = false;
        let v10 = if (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::contains_group(&arg0.bin_manager, v6)) {
            v9 = true;
            0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_mut_group_ref(&mut arg0.bin_manager, v6)
        } else {
            &mut v8
        };
        let v11 = v10;
        while (v4 < 0x1::vector::length<u32>(&arg2)) {
            let v12 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(&arg2, v4));
            assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v12, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::lower_bin_id(arg1)) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v12, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::upper_bin_id(arg1)), 13906841183732498471);
            let v13 = *0x1::vector::borrow<u128>(&arg3, v4);
            let (v14, v15) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::resolve_bin_position(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::bin_score(v12));
            if (v14 != v6) {
                let v16 = if (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::contains_group(&arg0.bin_manager, v14)) {
                    v9 = true;
                    0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_mut_group_ref(&mut arg0.bin_manager, v14)
                } else {
                    v9 = false;
                    &mut v8
                };
                v11 = v16;
            };
            let v17 = v9 && 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::contain_in_group(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_bin_group(v11), v15);
            if (!v17 || v13 == 0) {
                assert!(v13 == 0, 13906841265336090651);
                v4 = v4 + 1;
                let v18 = BinLiquidityDelta{
                    bin_id          : v12,
                    liquidity_share : 0,
                    amount_a        : 0,
                    amount_b        : 0,
                };
                0x1::vector::push_back<BinLiquidityDelta>(&mut v3, v18);
                continue
            };
            let v19 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_mut_bin_from_group(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_bin_group_mut(v11), v15);
            let (v20, v21) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::decrease_liquidity(v19, v13);
            0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::decrease_liquidity(v5, arg1, v19, v13);
            if (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::liquidity_supply(v19) == 0) {
                0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::remove_bin_from_group(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_bin_group_mut(v11), v15);
                if (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::is_empty_group(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_bin_group(v11))) {
                    let v22 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::group_idx(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_bin_group(v11));
                    v11 = &mut v8;
                    0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::remove_group(&mut arg0.bin_manager, (v22 as u64));
                };
            };
            v1 = v1 + v20;
            v2 = v2 + v21;
            let v23 = BinLiquidityDelta{
                bin_id          : v12,
                liquidity_share : v13,
                amount_a        : v20,
                amount_b        : v21,
            };
            0x1::vector::push_back<BinLiquidityDelta>(&mut v3, v23);
            v4 = v4 + 1;
        };
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::destroy_zero_bin_group_ref(v8);
        let v24 = RemoveLiquidityEvent{
            pool             : 0x2::object::id<Pool<T0, T1>>(arg0),
            position_id      : v0,
            active_id        : arg0.active_id,
            total_amount_a   : v1,
            total_amount_b   : v2,
            liquidity_deltas : v3,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v24);
        (0x2::balance::split<T0>(&mut arg0.balance_a, v1), 0x2::balance::split<T1>(&mut arg0.balance_b, v2))
    }

    public fun remove_liquidity_by_percent<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position, arg2: u32, arg3: u32, arg4: u16, arg5: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg6: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg6);
        operation_check<T0, T1>(arg0, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::restriction::remove_kind(), 0x2::tx_context::sender(arg8), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position>(arg1)), arg5);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::pool_id(arg1), 13906841690536280067);
        assert!((arg4 as u64) <= 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::basis_point(), 13906841694834524213);
        let v0 = 0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position>(arg1);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::assert_no_pending_add(arg1);
        reward_settle<T0, T1>(arg0, arg7);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::empty<BinLiquidityDelta>();
        let v4 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::borrow_mut_position_info(&mut arg0.position_manager, v0);
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2);
        let v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3);
        let v7 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v5, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::lower_bin_id(arg1))) {
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v6, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::upper_bin_id(arg1))) {
                0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v5, v6)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 13906841767848837171);
        let (v8, _) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::resolve_bin_position(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::bin_score(v5));
        let v10 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::zero_bin_group_ref();
        let v11 = false;
        let v12 = if (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::contains_group(&arg0.bin_manager, v8)) {
            v11 = true;
            0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_mut_group_ref(&mut arg0.bin_manager, v8)
        } else {
            &mut v10
        };
        let v13 = v12;
        let v14 = v5;
        while (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v14, v6)) {
            let (v15, v16) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::resolve_bin_position(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::bin_score(v14));
            if (v15 != v8) {
                let v17 = if (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::contains_group(&arg0.bin_manager, v15)) {
                    v11 = true;
                    0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_mut_group_ref(&mut arg0.bin_manager, v15)
                } else {
                    v11 = false;
                    &mut v10
                };
                v13 = v17;
            };
            let v18 = v11 && 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::contain_in_group(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_bin_group(v13), v16);
            if (!v18) {
                let v19 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v14, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
                v14 = v19;
                let v20 = BinLiquidityDelta{
                    bin_id          : v19,
                    liquidity_share : 0,
                    amount_a        : 0,
                    amount_b        : 0,
                };
                0x1::vector::push_back<BinLiquidityDelta>(&mut v3, v20);
                continue
            };
            let v21 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_mut_bin_from_group(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_bin_group_mut(v13), v16);
            let v22 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::liquidity_share(0x1::vector::borrow<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::BinStat>(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::info_stats(v4), (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v14, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::lower_bin_id(arg1))) as u64))) * (arg4 as u128) / (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::basis_point() as u128);
            let (v23, v24) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::decrease_liquidity(v21, v22);
            0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::decrease_liquidity(v4, arg1, v21, v22);
            if (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::liquidity_supply(v21) == 0) {
                0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::remove_bin_from_group(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_bin_group_mut(v13), v16);
                if (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::is_empty_group(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_bin_group(v13))) {
                    let v25 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::group_idx(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_bin_group(v13));
                    v13 = &mut v10;
                    0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::remove_group(&mut arg0.bin_manager, (v25 as u64));
                };
            };
            v1 = v1 + v23;
            v2 = v2 + v24;
            let v26 = BinLiquidityDelta{
                bin_id          : v14,
                liquidity_share : v22,
                amount_a        : v23,
                amount_b        : v24,
            };
            0x1::vector::push_back<BinLiquidityDelta>(&mut v3, v26);
            v14 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v14, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        };
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::destroy_zero_bin_group_ref(v10);
        let v27 = RemoveLiquidityEvent{
            pool             : 0x2::object::id<Pool<T0, T1>>(arg0),
            position_id      : v0,
            active_id        : arg0.active_id,
            total_amount_a   : v1,
            total_amount_b   : v2,
            liquidity_deltas : v3,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v27);
        (0x2::balance::split<T0>(&mut arg0.balance_a, v1), 0x2::balance::split<T1>(&mut arg0.balance_b, v2))
    }

    public fun repay_add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position, arg2: AddLiquidityCert<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg5);
        let AddLiquidityCert {
            pool_id            : v0,
            position_id        : v1,
            position_info      : v2,
            total_amount_a     : v3,
            total_amount_b     : v4,
            active_id          : _,
            active_id_amount_a : _,
            active_id_amount_b : _,
            fee_a              : v8,
            fee_b              : v9,
            active_id_added    : _,
            liquidity_deltas   : v11,
        } = arg2;
        let v12 = AddLiquidityEvent{
            pool             : 0x2::object::id<Pool<T0, T1>>(arg0),
            position_id      : 0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position>(arg1),
            active_id        : arg0.active_id,
            total_amount_a   : v3,
            total_amount_b   : v4,
            fee_a            : v8,
            fee_b            : v9,
            liquidity_deltas : v11,
        };
        0x2::event::emit<AddLiquidityEvent>(v12);
        assert!(0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position>(arg1) == v1, 13906840818658050053);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::pool_id(arg1) && 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::pool_id(arg1) == v0, 13906840831542820867);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::clear_pending_add(arg1);
        arg0.active_open_positions = arg0.active_open_positions - 1;
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::restore_position_info(&mut arg0.position_manager, v1, v2);
        assert!(0x2::balance::value<T0>(&arg3) == v3, 13906840861607985161);
        assert!(0x2::balance::value<T1>(&arg4) == v4, 13906840865902952457);
        0x2::balance::join<T0>(&mut arg0.balance_a, arg3);
        0x2::balance::join<T1>(&mut arg0.balance_b, arg4);
    }

    public fun repay_flash_swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: FlashSwapReceipt<T0, T1>, arg4: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg4);
        let FlashSwapReceipt {
            pool_id        : v0,
            a2b            : v1,
            partner_id     : _,
            pay_amount     : v3,
            ref_fee_amount : v4,
        } = arg3;
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == v0, 13906844026999144461);
        assert!(v4 == 0, 13906844031294111757);
        if (v1) {
            assert!(0x2::balance::value<T0>(&arg1) == v3, 13906844039884177423);
            0x2::balance::join<T0>(&mut arg0.balance_a, arg1);
            0x2::balance::destroy_zero<T1>(arg2);
        } else {
            assert!(0x2::balance::value<T1>(&arg2) == v3, 13906844057064046607);
            0x2::balance::join<T1>(&mut arg0.balance_b, arg2);
            0x2::balance::destroy_zero<T0>(arg1);
        };
    }

    public fun repay_flash_swap_with_partner<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::partner::Partner, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: FlashSwapReceipt<T0, T1>, arg5: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg5);
        let FlashSwapReceipt {
            pool_id        : v0,
            a2b            : v1,
            partner_id     : v2,
            pay_amount     : v3,
            ref_fee_amount : v4,
        } = arg4;
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == v0, 13906844447905939469);
        assert!(0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::partner::Partner>(arg1) == v2, 13906844452200906765);
        if (v1) {
            assert!(0x2::balance::value<T0>(&arg2) == v3, 13906844460790972431);
            if (v4 > 0) {
                0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::partner::receive_ref_fee<T0>(arg1, 0x2::balance::split<T0>(&mut arg2, v4));
            };
            0x2::balance::join<T0>(&mut arg0.balance_a, arg2);
            0x2::balance::destroy_zero<T1>(arg3);
        } else {
            assert!(0x2::balance::value<T1>(&arg3) == v3, 13906844499445678095);
            if (v4 > 0) {
                0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::partner::receive_ref_fee<T1>(arg1, 0x2::balance::split<T1>(&mut arg3, v4));
            };
            0x2::balance::join<T1>(&mut arg0.balance_b, arg3);
            0x2::balance::destroy_zero<T0>(arg2);
        };
    }

    public fun repay_open_position<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position, arg2: OpenPositionCert<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg5);
        let OpenPositionCert {
            pool_id            : v0,
            position_id        : v1,
            width              : v2,
            next_bin_id        : _,
            position_info      : v4,
            total_amount_a     : v5,
            total_amount_b     : v6,
            active_id          : _,
            active_id_amount_a : _,
            active_id_amount_b : _,
            fee_a              : v10,
            fee_b              : v11,
            active_id_added    : _,
            liquidity_deltas   : v13,
        } = arg2;
        let v14 = AddLiquidityEvent{
            pool             : 0x2::object::id<Pool<T0, T1>>(arg0),
            position_id      : 0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position>(arg1),
            active_id        : arg0.active_id,
            total_amount_a   : v5,
            total_amount_b   : v6,
            fee_a            : v10,
            fee_b            : v11,
            liquidity_deltas : v13,
        };
        0x2::event::emit<AddLiquidityEvent>(v14);
        assert!(0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position>(arg1) == v1, 13906840526600273925);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::pool_id(arg1) && 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::pool_id(arg1) == v0, 13906840539485044739);
        assert!(v5 > 0 || v6 > 0, 13906840548078387255);
        assert!(v2 == 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::width(arg1) && v2 <= 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::max_bin_per_position(), 13906840565257601069);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::clear_pending_add(arg1);
        arg0.active_open_positions = arg0.active_open_positions - 1;
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::restore_position_info(&mut arg0.position_manager, v1, v4);
        assert!(0x2::balance::value<T0>(&arg3) == v5, 13906840595320012809);
        assert!(0x2::balance::value<T1>(&arg4) == v6, 13906840599614980105);
        0x2::balance::join<T0>(&mut arg0.balance_a, arg3);
        0x2::balance::join<T1>(&mut arg0.balance_b, arg4);
    }

    public fun reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance_a), 0x2::balance::value<T1>(&arg0.balance_b))
    }

    public fun reward_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::reward::RewardManager {
        &arg0.reward_manager
    }

    fun reward_settle<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::reward::settle_rewards(&mut arg0.reward_manager, arg1);
        if (0x1::vector::is_empty<u128>(&v0)) {
            return
        };
        if (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::is_active_bin_empty(&arg0.bin_manager, arg0.active_id)) {
            0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::reward::rollover_refunds_into_remaining_time(&mut arg0.reward_manager, v0, arg1);
            return
        };
        if (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::reward::emergency_reward_pause(&arg0.reward_manager)) {
            0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::reward::refund_rewards(&mut arg0.reward_manager, v0);
            return
        };
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::accumulate_rewards(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_mut_bin(&mut arg0.bin_manager, arg0.active_id), v0);
    }

    fun swap_in_pool<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: bool, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock) : SwapResult {
        assert!(arg4 <= 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::fee_precision(), 13906846603980177431);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::parameters::update_references(&mut arg0.v_parameters, arg0.active_id, 0x2::clock::timestamp_ms(arg5) / 1000);
        let v0 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::first_score_for_swap(&arg0.bin_manager, arg0.active_id, arg2);
        let v1 = default_swap_result();
        let v2 = 0;
        while (arg1 > 0) {
            assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v0), 13906846646929457169);
            arg0.active_id = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::id(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_bin_from_score(&arg0.bin_manager, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v0)));
            0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::parameters::update_volatility_accumulator(&mut arg0.v_parameters, arg0.active_id);
            let v3 = get_total_fee_rate<T0, T1>(arg0);
            let (v4, v5) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::next_bin_for_swap(&mut arg0.bin_manager, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v0), arg2);
            let (v6, v7, v8, v9) = if (arg3) {
                0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::swap_exact_amount_in(v4, arg1, arg2, v3.total_fee_rate, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::parameters::protocol_fee_rate(&arg0.v_parameters))
            } else {
                0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::swap_exact_amount_out(v4, arg1, arg2, v3.total_fee_rate, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::parameters::protocol_fee_rate(&arg0.v_parameters))
            };
            let v10 = BinSwap{
                bin_id       : 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::id(v4),
                amount_in    : v6,
                amount_out   : v7,
                fee          : v8,
                var_fee_rate : v3.var_fee_rate,
            };
            if (arg3) {
                arg1 = arg1 - v6;
            } else {
                arg1 = arg1 - v7;
            };
            v2 = v2 + v9;
            let v11 = &mut v1;
            update_swap_result(v11, v10);
            v0 = v5;
        };
        let v12 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::dlmm_math::calculate_fee_inclusive(v2, arg4);
        v1.ref_fee = v12;
        v1.protocol_fee = v2;
        if (arg2) {
            arg0.protocol_fee_a = arg0.protocol_fee_a + v2 - v12;
        } else {
            arg0.protocol_fee_b = arg0.protocol_fee_b + v2 - v12;
        };
        v1
    }

    public fun take_reward_from_close_position_cert<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::ClosePositionCert, arg2: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned) : 0x2::balance::Balance<T2> {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg2);
        assert!(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::cert_pool_id(arg1) == 0x2::object::id<Pool<T0, T1>>(arg0), 13906843580324118565);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::reward::withdraw<T2>(&mut arg0.reward_manager, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::take_reward_from_close_cert(arg1, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::reward::get_index<T2>(&arg0.reward_manager)))
    }

    public fun update_base_fee_rate<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg2: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext, arg4: u64) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg2);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        let v0 = UpdateBaseFeeRateEvent{
            pool              : 0x2::object::id<Pool<T0, T1>>(arg0),
            old_base_fee_rate : arg0.base_fee_rate,
            new_base_fee_rate : arg4,
        };
        0x2::event::emit<UpdateBaseFeeRateEvent>(v0);
        arg0.base_fee_rate = arg4;
    }

    public fun update_permissions<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool, arg2: bool, arg3: bool, arg4: bool, arg5: bool, arg6: bool, arg7: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg8: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg9: &0x2::tx_context::TxContext) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg8);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::check_pool_manager_role(arg7, 0x2::tx_context::sender(arg9));
        arg0.permissions.disable_add = arg1;
        arg0.permissions.disable_remove = arg2;
        arg0.permissions.disable_swap = arg3;
        arg0.permissions.disable_collect_fee = arg4;
        arg0.permissions.disable_collect_reward = arg5;
        arg0.permissions.disable_add_reward = arg6;
        let v0 = UpdatePermissionsEvent{
            pool            : 0x2::object::id<Pool<T0, T1>>(arg0),
            old_permissions : arg0.permissions,
            new_permissions : arg0.permissions,
        };
        0x2::event::emit<UpdatePermissionsEvent>(v0);
    }

    public fun update_position_fee_and_rewards<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::object::ID, arg2: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg3: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg3);
        operation_check<T0, T1>(arg0, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::restriction::collect_fee_kind(), 0x2::tx_context::sender(arg5), 0x1::option::some<0x2::object::ID>(arg1), arg2);
        operation_check<T0, T1>(arg0, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::restriction::collect_reward_kind(), 0x2::tx_context::sender(arg5), 0x1::option::some<0x2::object::ID>(arg1), arg2);
        reward_settle<T0, T1>(arg0, arg4);
        let v0 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::borrow_position_info(&arg0.position_manager, arg1);
        let v1 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::lower_bin_id_on_position_info(v0);
        let v2 = 0;
        let v3 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::borrow_mut_position_info(&mut arg0.position_manager, arg1);
        let (v4, _) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::resolve_bin_position(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::bin_score(v1));
        let v6 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::zero_bin_group_ref();
        let v7 = false;
        let v8 = if (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::contains_group(&arg0.bin_manager, v4)) {
            v7 = true;
            0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_mut_group_ref(&mut arg0.bin_manager, v4)
        } else {
            &mut v6
        };
        let v9 = v8;
        while (v2 < 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::width_on_position_info(v0)) {
            let (v10, v11) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::resolve_bin_position(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::bin_score(v1));
            if (v10 != v4) {
                let v12 = if (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::contains_group(&arg0.bin_manager, v10)) {
                    v7 = true;
                    0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_mut_group_ref(&mut arg0.bin_manager, v10)
                } else {
                    v7 = false;
                    &mut v6
                };
                v9 = v12;
            };
            if (v7 && 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::contain_in_group(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_bin_group(v9), v11)) {
                let v13 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_mut_bin_from_group(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::borrow_bin_group_mut(v9), v11);
                0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::update_fee(v3, v13);
                0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::update_rewards(v3, v13);
            };
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
            v2 = v2 + 1;
        };
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::destroy_zero_bin_group_ref(v6);
    }

    fun update_swap_result(arg0: &mut SwapResult, arg1: BinSwap) {
        arg0.amount_in = arg0.amount_in + arg1.amount_in;
        arg0.amount_out = arg0.amount_out + arg1.amount_out;
        arg0.fee = arg0.fee + arg1.fee;
        0x1::vector::push_back<BinSwap>(&mut arg0.steps, arg1);
    }

    public fun v_parameters<T0, T1>(arg0: &Pool<T0, T1>) : &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::parameters::VariableParameters {
        &arg0.v_parameters
    }

    // decompiled from Move bytecode v6
}

