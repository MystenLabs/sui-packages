module 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool {
    struct POOL has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        index: u64,
        v_parameters: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::VariableParameters,
        active_id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        base_fee_rate: u64,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        protocol_fee_a: u64,
        protocol_fee_b: u64,
        reward_manager: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward::RewardManager,
        bin_manager: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::BinManager,
        position_manager: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::PositionManager,
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
        position_info: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::PositionInfo,
        total_amount_a: u64,
        total_amount_b: u64,
        active_id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        fee_rate: u64,
        protocol_fee_rate: u64,
        protocol_fee_a: u64,
        protocol_fee_b: u64,
        fee_a: u64,
        fee_b: u64,
        active_id_included: bool,
        active_id_filled: bool,
        liquidity_deltas: vector<BinLiquidityDelta>,
    }

    struct AddLiquidityCert<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        position_info: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::PositionInfo,
        total_amount_a: u64,
        total_amount_b: u64,
        active_id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        fee_rate: u64,
        protocol_fee_rate: u64,
        protocol_fee_a: u64,
        protocol_fee_b: u64,
        fee_a: u64,
        fee_b: u64,
        active_id_included: bool,
        active_id_filled: bool,
        liquidity_deltas: vector<BinLiquidityDelta>,
    }

    struct PositionDetail has copy, drop {
        position_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        fee_a: u64,
        fee_b: u64,
        rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        update_tx: vector<u8>,
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

    struct RewardSettleEvent has copy, drop {
        pool: 0x2::object::ID,
        bin_id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        accumulated_rewards: vector<u128>,
        duration: u64,
    }

    public fun add_group_if_absent<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) : &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::BinGroupRef {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg2);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::add_group_if_absent(&mut arg0.bin_manager, arg1)
    }

    public fun borrow_bin<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::Bin {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin(&arg0.bin_manager, arg1)
    }

    public fun borrow_group_ref<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::BinGroupRef {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_group_ref(&arg0.bin_manager, arg1)
    }

    public fun contains_group<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : bool {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::contains_group(&arg0.bin_manager, arg1)
    }

    public fun fetch_bins<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x1::option::Option<u32>, arg2: u64) : vector<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::BinInfo> {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::fetch_bins(&arg0.bin_manager, arg1, arg2)
    }

    public fun bin_step<T0, T1>(arg0: &Pool<T0, T1>) : u16 {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::bin_step(&arg0.v_parameters)
    }

    public fun get_variable_fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::get_variable_fee_rate(&arg0.v_parameters)
    }

    public fun active_id<T0, T1>(arg0: &Pool<T0, T1>) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.active_id
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg2: vector<u32>, arg3: vector<u64>, arg4: vector<u64>, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : AddLiquidityCert<T0, T1> {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg6);
        operation_check<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::restriction::add_kind(), 0x2::tx_context::sender(arg8), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(arg1)), arg5);
        let v0 = if (0x1::vector::length<u32>(&arg2) == 0x1::vector::length<u64>(&arg3)) {
            if (0x1::vector::length<u32>(&arg2) == 0x1::vector::length<u64>(&arg4)) {
                0x1::vector::length<u32>(&arg2) > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13906840251722498055);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::pool_id(arg1), 13906840260312170499);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(&arg2, 0));
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::lower_bin_id(arg1)) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(&arg2, 0x1::vector::length<u32>(&arg2) - 1)), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::upper_bin_id(arg1)), 13906840286085120051);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::mark_add_pending(arg1);
        arg0.active_open_positions = arg0.active_open_positions + 1;
        reward_settle<T0, T1>(arg0, arg7);
        let v2 = AddLiquidityCert<T0, T1>{
            pool_id            : 0x2::object::id<Pool<T0, T1>>(arg0),
            position_id        : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(arg1),
            position_info      : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::extract_position_info(&mut arg0.position_manager, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(arg1)),
            total_amount_a     : 0,
            total_amount_b     : 0,
            active_id          : arg0.active_id,
            fee_rate           : 0,
            protocol_fee_rate  : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::protocol_fee_rate(&arg0.v_parameters),
            protocol_fee_a     : 0,
            protocol_fee_b     : 0,
            fee_a              : 0,
            fee_b              : 0,
            active_id_included : false,
            active_id_filled   : false,
            liquidity_deltas   : 0x1::vector::empty<BinLiquidityDelta>(),
        };
        let v3 = 0;
        let (v4, _) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::resolve_bin_position(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(v1));
        let v6 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::add_group_if_absent(&mut arg0.bin_manager, v4);
        while (v3 < 0x1::vector::length<u32>(&arg2)) {
            let v7 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(&arg2, v3));
            assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v7, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::lower_bin_id(arg1)) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v7, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::upper_bin_id(arg1)), 13906840432113352745);
            let (v8, v9) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::resolve_bin_position(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(v7));
            if (v8 != v4) {
                v6 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::add_group_if_absent(&mut arg0.bin_manager, v8);
            };
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v7, v2.active_id) && (*0x1::vector::borrow<u64>(&arg3, v3) > 0 || *0x1::vector::borrow<u64>(&arg4, v3) > 0)) {
                0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::update_volatility_parameter(&mut arg0.v_parameters, v7, 0x2::clock::timestamp_ms(arg7) / 1000);
                let v10 = calculate_total_fee_rate(&arg0.v_parameters, arg0.base_fee_rate);
                v2.active_id_included = true;
                v2.fee_rate = v10.total_fee_rate;
            };
            let v11 = &mut v2;
            add_liquidity_on_bin<T0, T1>(arg1, v11, v6, v9, *0x1::vector::borrow<u64>(&arg3, v3), *0x1::vector::borrow<u64>(&arg4, v3), arg6);
            v3 = v3 + 1;
        };
        v2
    }

    public fun add_liquidity_on_bin<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg1: &mut AddLiquidityCert<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::BinGroupRef, arg3: u8, arg4: u64, arg5: u64, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg6);
        assert!(arg1.position_id == 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(arg0), 13906839847995441157);
        assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::pool_id(arg2) == arg1.pool_id, 13906839852293292081);
        if (arg4 == 0 && arg5 == 0) {
            return
        };
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::add_bin_in_group_if_absent(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group_mut(arg2), arg3);
        arg1.total_amount_a = arg1.total_amount_a + arg4;
        arg1.total_amount_b = arg1.total_amount_b + arg5;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(v0), arg1.active_id)) {
            assert!(arg1.active_id_included, 13906839899538718781);
            assert!(!arg1.active_id_filled, 13906839903832506411);
            arg1.active_id_filled = true;
            let (v1, v2, v3, v4) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::apply_active_bin_composition_fees(v0, arg4, arg5, arg1.fee_rate, arg1.protocol_fee_rate);
            arg1.protocol_fee_a = v3;
            arg1.protocol_fee_b = v4;
            arg1.fee_a = v1;
            arg1.fee_b = v2;
            arg4 = arg4 - arg1.fee_a;
            arg5 = arg5 - arg1.fee_b;
        };
        let (v5, v6, v7) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::increase_liquidity(v0, arg4, arg5, arg1.active_id);
        arg1.total_amount_a = arg1.total_amount_a - v5;
        arg1.total_amount_b = arg1.total_amount_b - v6;
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::increase_liquidity(&mut arg1.position_info, arg0, v0, v7);
        if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::liquidity_share(v0) == 0) {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::remove_bin_from_group(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group_mut(arg2), arg3);
        };
        let v8 = BinLiquidityDelta{
            bin_id          : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(v0),
            liquidity_share : v7,
            amount_a        : arg4 - v5,
            amount_b        : arg5 - v6,
        };
        0x1::vector::push_back<BinLiquidityDelta>(&mut arg1.liquidity_deltas, v8);
    }

    public fun add_reward<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T2>, arg2: 0x1::option::Option<u64>, arg3: u64, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg5);
        operation_check<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::restriction::add_reward_kind(), 0x2::tx_context::sender(arg7), 0x1::option::none<0x2::object::ID>(), arg4);
        if (!0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward::is_public(&arg0.reward_manager) || !0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::is_reward_public(arg4)) {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::check_reward_manager_role(arg4, 0x2::tx_context::sender(arg7));
        };
        let v0 = if (0x1::option::is_none<u64>(&arg2)) {
            0x2::clock::timestamp_ms(arg6) / 1000
        } else {
            *0x1::option::borrow<u64>(&arg2)
        };
        assert!(v0 < arg3, 13906846479427043365);
        assert!(v0 >= 1757332800, 13906846483721879587);
        let v1 = 0x2::coin::value<T2>(&arg1);
        assert!(v1 > 0, 13906846492313780289);
        let v2 = arg3 - v0;
        assert!(v2 <= 63072000, 13906846505198813251);
        assert!(v2 >= 3600, 13906846509493780547);
        if (!0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::has_reward_manager_role(arg4, 0x2::tx_context::sender(arg7))) {
            if (0x1::option::is_some<u64>(&arg2)) {
                assert!((*0x1::option::borrow<u64>(&arg2) - 1757332800) % 604800 == 0, 13906846530966519843);
            };
            assert!(v2 >= 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::min_reward_duration(arg4), 13906846552441094175);
            assert!((arg3 - 1757332800) % 604800 == 0, 13906846569621356581);
        };
        reward_settle<T0, T1>(arg0, arg6);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward::add_reward<T2>(&mut arg0.reward_manager, arg2, arg3, 0x2::coin::into_balance<T2>(arg1), arg6);
        let v3 = AddRewardEvent{
            pool       : 0x2::object::id<Pool<T0, T1>>(arg0),
            reward     : 0x1::type_name::with_defining_ids<T2>(),
            amount     : v1,
            start_time : v0,
            end_time   : arg3,
        };
        0x2::event::emit<AddRewardEvent>(v3);
    }

    public fun amounts<T0, T1>(arg0: &AddLiquidityCert<T0, T1>) : (u64, u64) {
        (arg0.total_amount_a, arg0.total_amount_b)
    }

    public fun amounts_in_active_bin<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::contains(&arg0.bin_manager, arg0.active_id)) {
            let v2 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin(&arg0.bin_manager, arg0.active_id);
            (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::amount_a(v2), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::amount_b(v2))
        } else {
            (0, 0)
        }
    }

    public fun base_fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.base_fee_rate
    }

    public fun bin_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::BinManager {
        &arg0.bin_manager
    }

    public fun calculate_total_fee_rate(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::VariableParameters, arg1: u64) : FeeRate {
        let v0 = (0x1::u128::min((arg1 as u128) + (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::get_variable_fee_rate(arg0) as u128), 100000000) as u64);
        FeeRate{
            base_fee_rate  : arg1,
            var_fee_rate   : v0 - arg1,
            total_fee_rate : v0,
        }
    }

    public fun close_position<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::ClosePositionCert, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2, v3, v4) = close_position_with_fee<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v5 = v2;
        let v6 = v1;
        0x2::balance::join<T0>(&mut v6, v3);
        0x2::balance::join<T1>(&mut v5, v4);
        (v0, v6, v5)
    }

    public fun close_position_with_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::ClosePositionCert, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg3);
        operation_check<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::restriction::remove_kind(), 0x2::tx_context::sender(arg5), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg1)), arg2);
        operation_check<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::restriction::collect_fee_kind(), 0x2::tx_context::sender(arg5), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg1)), arg2);
        operation_check<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::restriction::collect_reward_kind(), 0x2::tx_context::sender(arg5), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg1)), arg2);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::pool_id(&arg1), 13906843868084699139);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::assert_no_pending_add(&arg1);
        reward_settle<T0, T1>(arg0, arg4);
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::close_position(&mut arg0.position_manager, arg1);
        let v1 = 0x1::vector::empty<BinLiquidityDelta>();
        let (v2, _) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::resolve_bin_position(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::upper_bin_id_on_position_info(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::position_info(&v0))));
        let v4 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::zero_bin_group_ref();
        let v5 = false;
        let v6 = if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::contains_group(&arg0.bin_manager, v2)) {
            v5 = true;
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_mut_group_ref(&mut arg0.bin_manager, v2)
        } else {
            &mut v4
        };
        let v7 = v6;
        while (!0x1::vector::is_empty<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::BinStat>(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::cert_stats(&v0))) {
            let v8 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::pop_position_bin(&mut v0);
            let v9 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::liquidity_share(&v8);
            let v10 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::bin_id(&v8);
            let (v11, v12) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::resolve_bin_position(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(v10));
            if (v11 != v2) {
                let v13 = if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::contains_group(&arg0.bin_manager, v11)) {
                    v5 = true;
                    0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_mut_group_ref(&mut arg0.bin_manager, v11)
                } else {
                    v5 = false;
                    &mut v4
                };
                v7 = v13;
            };
            let v14 = v5 && 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::contain_in_group(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group(v7), v12);
            let (v15, v16) = if (!v14) {
                assert!(v9 == 0, 13906844018410127387);
                0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::destroy_bin_stat(v8);
                (0, 0)
            } else {
                let v17 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_mut_bin_from_group(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group_mut(v7), v12);
                let (v18, v19) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::close_position_bin(&mut v0, v17, v8);
                if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::liquidity_share(v17) == 0) {
                    0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::remove_bin_from_group(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group_mut(v7), v12);
                    if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::is_empty_group(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group(v7))) {
                        let v20 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::group_idx(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group(v7));
                        v7 = &mut v4;
                        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::remove_group(&mut arg0.bin_manager, (v20 as u64));
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
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::destroy_zero_bin_group_ref(v4);
        let (v22, v23) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::take_amounts_from_close_cert(&mut v0);
        let (v24, v25) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::take_fee_from_close_cert(&mut v0);
        let v26 = ClosePositionEvent{
            pool             : 0x2::object::id<Pool<T0, T1>>(arg0),
            position_id      : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg1),
            active_id        : arg0.active_id,
            total_amount_a   : v22,
            total_amount_b   : v23,
            fee_a            : v24,
            fee_b            : v25,
            rewards          : *0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::cert_rewards_owned(&v0),
            liquidity_deltas : v1,
        };
        0x2::event::emit<ClosePositionEvent>(v26);
        (v0, 0x2::balance::split<T0>(&mut arg0.balance_a, v22), 0x2::balance::split<T1>(&mut arg0.balance_b, v23), 0x2::balance::split<T0>(&mut arg0.balance_a, v24), 0x2::balance::split<T1>(&mut arg0.balance_b, v25))
    }

    public fun collect_position_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg3);
        operation_check<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::restriction::collect_fee_kind(), 0x2::tx_context::sender(arg4), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(arg1)), arg2);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::pool_id(arg1), 13906843120760389635);
        let (v0, v1) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::take_fee_from_position(&mut arg0.position_manager, arg1);
        let v2 = CollectFeeEvent{
            pool     : 0x2::object::id<Pool<T0, T1>>(arg0),
            position : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(arg1),
            fee_a    : v0,
            fee_b    : v1,
        };
        0x2::event::emit<CollectFeeEvent>(v2);
        (0x2::balance::split<T0>(&mut arg0.balance_a, v0), 0x2::balance::split<T1>(&mut arg0.balance_b, v1))
    }

    public fun collect_position_reward<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg3);
        operation_check<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::restriction::collect_reward_kind(), 0x2::tx_context::sender(arg4), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(arg1)), arg2);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::pool_id(arg1), 13906843356983590915);
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::take_reward_from_position(&mut arg0.position_manager, arg1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward::get_index<T2>(&arg0.reward_manager));
        let v1 = CollectRewardEvent{
            pool     : 0x2::object::id<Pool<T0, T1>>(arg0),
            position : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(arg1),
            reward   : 0x1::type_name::with_defining_ids<T2>(),
            amount   : v0,
        };
        0x2::event::emit<CollectRewardEvent>(v1);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward::withdraw<T2>(&mut arg0.reward_manager, v0)
    }

    public fun collect_protocol_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg2);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::check_protocol_fee_manager_role(arg1, 0x2::tx_context::sender(arg3));
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

    public fun collect_protocol_fee_with_cap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &ProtocolFeeCollectCap) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg2);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::check_protocol_fee_manager_role(arg1, 0x2::object::id_address<ProtocolFeeCollectCap>(arg3));
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
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::contains(&arg0.bin_manager, arg1)
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

    public fun destroy_close_position_cert(arg0: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::ClosePositionCert, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg1);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::destroy_cert(arg0);
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

    public fun emergency_pause_reward<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &0x2::tx_context::TxContext) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg2);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward::emergency_pause(&mut arg0.reward_manager);
        let v0 = EmergencyPauseRewardEvent{pool: 0x2::object::id<Pool<T0, T1>>(arg0)};
        0x2::event::emit<EmergencyPauseRewardEvent>(v0);
    }

    public fun emergency_unpause_reward<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &0x2::tx_context::TxContext) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg2);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward::emergency_unpause(&mut arg0.reward_manager);
        let v0 = EmergencyUnpauseRewardEvent{pool: 0x2::object::id<Pool<T0, T1>>(arg0)};
        0x2::event::emit<EmergencyUnpauseRewardEvent>(v0);
    }

    public fun emergency_withdraw_refund_reward<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg2);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::check_reward_manager_role(arg1, 0x2::tx_context::sender(arg3));
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward::emergency_withdraw_refund_reward<T2>(&mut arg0.reward_manager);
        let v1 = EmergencyWithdrawRefundRewardEvent{
            pool   : 0x2::object::id<Pool<T0, T1>>(arg0),
            reward : 0x1::type_name::with_defining_ids<T2>(),
            amount : 0x2::balance::value<T2>(&v0),
        };
        0x2::event::emit<EmergencyWithdrawRefundRewardEvent>(v1);
        0x2::coin::from_balance<T2>(v0, arg3)
    }

    public fun flash_swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg5);
        operation_check<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::restriction::swap_kind(), 0x2::tx_context::sender(arg7), 0x1::option::none<0x2::object::ID>(), arg4);
        flash_swap_internal<T0, T1>(arg0, 0x2::object::id_from_address(@0x0), 0, arg1, arg2, arg3, arg6)
    }

    fun flash_swap_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::object::ID, arg2: u64, arg3: bool, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        assert!(arg5 > 0, 13906847351304224787);
        reward_settle<T0, T1>(arg0, arg6);
        assert!(arg0.active_open_positions == 0, 13906847359895994415);
        let v0 = swap_in_pool<T0, T1>(arg0, arg5, arg3, arg4, arg2, arg6);
        let (v1, v2) = if (arg3) {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg0.balance_b, v0.amount_out))
        } else {
            (0x2::balance::split<T0>(&mut arg0.balance_a, v0.amount_out), 0x2::balance::zero<T1>())
        };
        assert!(v0.amount_out > 0, 13906847407138930709);
        let (v3, v4) = if (arg3) {
            (0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>())
        } else {
            (0x1::type_name::with_defining_ids<T1>(), 0x1::type_name::with_defining_ids<T0>())
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

    public fun flash_swap_with_partner<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg2: bool, arg3: bool, arg4: u64, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg6);
        operation_check<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::restriction::swap_kind(), 0x2::tx_context::sender(arg8), 0x1::option::none<0x2::object::ID>(), arg5);
        flash_swap_internal<T0, T1>(arg0, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner>(arg1), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::current_ref_fee_rate(arg1, 0x2::clock::timestamp_ms(arg7) / 1000), arg2, arg3, arg4, arg7)
    }

    public fun get_position_amounts<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : (u64, u64) {
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::borrow_position_info(&arg0.position_manager, arg1);
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::lower_bin_id_on_position_info(v0);
        let v2 = 0;
        let v3 = 0;
        let (v4, _) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::resolve_bin_position(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(v1));
        let v6 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::zero_bin_group_ref();
        let v7 = false;
        let v8 = if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::contains_group(&arg0.bin_manager, v4)) {
            v7 = true;
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_group_ref(&arg0.bin_manager, v4)
        } else {
            &v6
        };
        let v9 = v8;
        let v10 = v1;
        while (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v10, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::upper_bin_id_on_position_info(v0))) {
            let (v11, v12) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::resolve_bin_position(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(v10));
            if (v11 != v4) {
                let v13 = if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::contains_group(&arg0.bin_manager, v11)) {
                    v7 = true;
                    0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_group_ref(&arg0.bin_manager, v11)
                } else {
                    v7 = false;
                    &v6
                };
                v9 = v13;
            };
            if (!v7 || !0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::contain_in_group(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group(v9), v12)) {
                v10 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v10, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
                continue
            };
            let v14 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_from_group(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group(v9), v12);
            let (v15, v16) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_amounts_by_liquidity(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::amount_a(v14), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::amount_b(v14), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::liquidity_share(0x1::vector::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::BinStat>(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::info_stats(v0), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::bin_idx_on_position_info(v0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(v14)))), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::liquidity_share(v14));
            v2 = v2 + v15;
            v3 = v3 + v16;
            v10 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v10, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        };
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::destroy_zero_bin_group_ref(v6);
        (v2, v3)
    }

    public fun get_total_fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : FeeRate {
        calculate_total_fee_rate(&arg0.v_parameters, arg0.base_fee_rate)
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<POOL>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun initialize_reward<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg2);
        operation_check<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::restriction::add_reward_kind(), 0x2::tx_context::sender(arg4), 0x1::option::none<0x2::object::ID>(), arg1);
        if (!0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward::is_public(&arg0.reward_manager) || !0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::is_reward_public(arg1)) {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::check_reward_manager_role(arg1, 0x2::tx_context::sender(arg4));
        };
        if (!0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::has_reward_manager_role(arg1, 0x2::tx_context::sender(arg4))) {
            let v0 = if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::is_whitelist<T2>(arg1)) {
                true
            } else if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<T2>()) {
                true
            } else {
                0x1::type_name::with_defining_ids<T1>() == 0x1::type_name::with_defining_ids<T2>()
            };
            assert!(v0, 13906846234612203531);
            assert!(5 - 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward::reward_num(&arg0.reward_manager) > (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::manager_reserved_reward_init_slots(arg1) as u64), 13906846251793514529);
        };
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward::initialize_reward<T2>(&mut arg0.reward_manager, arg3, arg4);
        let v1 = InitializeRewardEvent{
            pool   : 0x2::object::id<Pool<T0, T1>>(arg0),
            reward : 0x1::type_name::with_defining_ids<T2>(),
        };
        0x2::event::emit<InitializeRewardEvent>(v1);
    }

    public fun make_reward_private<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &0x2::tx_context::TxContext) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg2);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::check_reward_manager_role(arg1, 0x2::tx_context::sender(arg3));
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward::make_private(&mut arg0.reward_manager);
        let v0 = MakeRewardPrivateEvent{pool: 0x2::object::id<Pool<T0, T1>>(arg0)};
        0x2::event::emit<MakeRewardPrivateEvent>(v0);
    }

    public fun make_reward_public<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &0x2::tx_context::TxContext) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg2);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::check_reward_manager_role(arg1, 0x2::tx_context::sender(arg3));
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward::make_public(&mut arg0.reward_manager);
        let v0 = MakeRewardPublicEvent{pool: 0x2::object::id<Pool<T0, T1>>(arg0)};
        0x2::event::emit<MakeRewardPublicEvent>(v0);
    }

    public fun mint_protocol_fee_collect_cap(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::admin_cap::AdminCap, arg1: address, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg2);
        let v0 = ProtocolFeeCollectCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<ProtocolFeeCollectCap>(v0, arg1);
    }

    public fun new_add_liquidity_cert<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg2: bool, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : AddLiquidityCert<T0, T1> {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg4);
        operation_check<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::restriction::add_kind(), 0x2::tx_context::sender(arg6), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(arg1)), arg3);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::pool_id(arg1), 13906839607477141507);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::mark_add_pending(arg1);
        arg0.active_open_positions = arg0.active_open_positions + 1;
        reward_settle<T0, T1>(arg0, arg5);
        let v0 = arg0.active_id;
        let v1 = 0;
        if (arg2) {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::update_volatility_parameter(&mut arg0.v_parameters, v0, 0x2::clock::timestamp_ms(arg5) / 1000);
            let v2 = calculate_total_fee_rate(&arg0.v_parameters, arg0.base_fee_rate);
            v1 = v2.total_fee_rate;
        };
        AddLiquidityCert<T0, T1>{
            pool_id            : 0x2::object::id<Pool<T0, T1>>(arg0),
            position_id        : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(arg1),
            position_info      : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::extract_position_info(&mut arg0.position_manager, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(arg1)),
            total_amount_a     : 0,
            total_amount_b     : 0,
            active_id          : v0,
            fee_rate           : v1,
            protocol_fee_rate  : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::protocol_fee_rate(&arg0.v_parameters),
            protocol_fee_a     : 0,
            protocol_fee_b     : 0,
            fee_a              : 0,
            fee_b              : 0,
            active_id_included : arg2,
            active_id_filled   : false,
            liquidity_deltas   : 0x1::vector::empty<BinLiquidityDelta>(),
        }
    }

    public fun new_open_position_cert<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u32, arg2: u16, arg3: bool, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, OpenPositionCert<T0, T1>) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg5);
        operation_check<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::restriction::add_kind(), 0x2::tx_context::sender(arg7), 0x1::option::none<0x2::object::ID>(), arg4);
        arg0.active_open_positions = arg0.active_open_positions + 1;
        assert!(arg2 <= 1000 && arg2 > 0, 13906838915991339071);
        reward_settle<T0, T1>(arg0, arg6);
        let v0 = 0x2::object::id<Pool<T0, T1>>(arg0);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1);
        let v2 = arg0.active_id;
        let v3 = 0;
        if (arg3) {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::update_volatility_parameter(&mut arg0.v_parameters, v2, 0x2::clock::timestamp_ms(arg6) / 1000);
            let v4 = calculate_total_fee_rate(&arg0.v_parameters, arg0.base_fee_rate);
            v3 = v4.total_fee_rate;
        };
        let v5 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::open_position<T0, T1>(&mut arg0.position_manager, v0, arg0.index, v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from((arg2 as u32))), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1)), arg0.url, arg7);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::mark_add_pending(&mut v5);
        let v6 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&v5);
        let v7 = OpenPositionCert<T0, T1>{
            pool_id            : v0,
            position_id        : v6,
            width              : arg2,
            next_bin_id        : v1,
            position_info      : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::extract_position_info(&mut arg0.position_manager, v6),
            total_amount_a     : 0,
            total_amount_b     : 0,
            active_id          : v2,
            fee_rate           : v3,
            protocol_fee_rate  : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::protocol_fee_rate(&arg0.v_parameters),
            protocol_fee_a     : 0,
            protocol_fee_b     : 0,
            fee_a              : 0,
            fee_b              : 0,
            active_id_included : arg3,
            active_id_filled   : false,
            liquidity_deltas   : 0x1::vector::empty<BinLiquidityDelta>(),
        };
        let v8 = OpenPositionEvent{
            pool         : v0,
            position_id  : v6,
            lower_bin_id : v1,
            width        : arg2,
            active_id    : v2,
        };
        0x2::event::emit<OpenPositionEvent>(v8);
        (v5, v7)
    }

    public(friend) fun new_pool<T0, T1>(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u64, arg2: 0x1::string::String, arg3: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::BinStepConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::bin_step(&arg3);
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
            v_parameters          : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::new_variable_parameters(arg3, arg0),
            active_id             : arg0,
            base_fee_rate         : (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::base_factor(&arg3) as u64) * (v0 as u64) * 10,
            balance_a             : 0x2::balance::zero<T0>(),
            balance_b             : 0x2::balance::zero<T1>(),
            protocol_fee_a        : 0,
            protocol_fee_b        : 0,
            reward_manager        : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward::new_reward_manager(arg5),
            bin_manager           : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::new_bin_manager(0x2::object::uid_to_inner(&v1), v0, 0x2::clock::timestamp_ms(arg4), arg5),
            position_manager      : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::new_position_manager(v0, arg5),
            url                   : arg2,
            permissions           : v2,
            active_open_positions : 0,
        }
    }

    public fun open_cert_amounts<T0, T1>(arg0: &OpenPositionCert<T0, T1>) : (u64, u64) {
        (arg0.total_amount_a, arg0.total_amount_b)
    }

    public fun open_position<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<u32>, arg2: vector<u64>, arg3: vector<u64>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, OpenPositionCert<T0, T1>) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg5);
        operation_check<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::restriction::add_kind(), 0x2::tx_context::sender(arg7), 0x1::option::none<0x2::object::ID>(), arg4);
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
        assert!(v0, 13906838409181528071);
        let v1 = (0x1::vector::length<u32>(&arg1) as u16);
        assert!(v1 <= 1000, 13906838422068920365);
        reward_settle<T0, T1>(arg0, arg6);
        let v2 = 0x2::object::id<Pool<T0, T1>>(arg0);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(&arg1, 0));
        let v4 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::open_position<T0, T1>(&mut arg0.position_manager, v2, arg0.index, v3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from((v1 as u32))), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1)), arg0.url, arg7);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::mark_add_pending(&mut v4);
        let v5 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&v4);
        let v6 = OpenPositionCert<T0, T1>{
            pool_id            : v2,
            position_id        : v5,
            width              : v1,
            next_bin_id        : v3,
            position_info      : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::extract_position_info(&mut arg0.position_manager, v5),
            total_amount_a     : 0,
            total_amount_b     : 0,
            active_id          : arg0.active_id,
            fee_rate           : 0,
            protocol_fee_rate  : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::protocol_fee_rate(&arg0.v_parameters),
            protocol_fee_a     : 0,
            protocol_fee_b     : 0,
            fee_a              : 0,
            fee_b              : 0,
            active_id_included : false,
            active_id_filled   : false,
            liquidity_deltas   : 0x1::vector::empty<BinLiquidityDelta>(),
        };
        let v7 = OpenPositionEvent{
            pool         : v2,
            position_id  : v5,
            lower_bin_id : v3,
            width        : v1,
            active_id    : arg0.active_id,
        };
        0x2::event::emit<OpenPositionEvent>(v7);
        let v8 = 0;
        let (v9, _) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::resolve_bin_position(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(&arg1, 0))));
        let v11 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::add_group_if_absent(&mut arg0.bin_manager, v9);
        while (v8 < 0x1::vector::length<u32>(&arg1)) {
            let v12 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(&arg1, v8));
            let (v13, v14) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::resolve_bin_position(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(v12));
            if (v13 != v9) {
                v11 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::add_group_if_absent(&mut arg0.bin_manager, v13);
            };
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v12, v6.active_id) && (*0x1::vector::borrow<u64>(&arg2, v8) > 0 || *0x1::vector::borrow<u64>(&arg3, v8) > 0)) {
                0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::update_volatility_parameter(&mut arg0.v_parameters, v12, 0x2::clock::timestamp_ms(arg6) / 1000);
                let v15 = calculate_total_fee_rate(&arg0.v_parameters, arg0.base_fee_rate);
                v6.active_id_included = true;
                v6.fee_rate = v15.total_fee_rate;
            };
            let v16 = &mut v4;
            let v17 = &mut v6;
            open_position_on_bin<T0, T1>(v16, v17, v11, v14, *0x1::vector::borrow<u64>(&arg2, v8), *0x1::vector::borrow<u64>(&arg3, v8), arg5);
            v8 = v8 + 1;
        };
        (v4, v6)
    }

    public fun open_position_on_bin<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg1: &mut OpenPositionCert<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::BinGroupRef, arg3: u8, arg4: u64, arg5: u64, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg6);
        assert!(arg1.position_id == 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(arg0), 13906839255289954309);
        assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::pool_id(arg2) == arg1.pool_id, 13906839259587805233);
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::add_bin_in_group_if_absent(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group_mut(arg2), arg3);
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(v0);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::lower_bin_id(arg0)) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::upper_bin_id(arg0)), 13906839285356036121);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v1, arg1.next_bin_id), 13906839289651003417);
        arg1.next_bin_id = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(arg1.next_bin_id, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        arg1.total_amount_a = arg1.total_amount_a + arg4;
        arg1.total_amount_b = arg1.total_amount_b + arg5;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(v0), arg1.active_id) && (arg4 > 0 || arg5 > 0)) {
            assert!(arg1.active_id_included, 13906839319718133821);
            assert!(!arg1.active_id_filled, 13906839324011921451);
            arg1.active_id_filled = true;
            let (v2, v3, v4, v5) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::apply_active_bin_composition_fees(v0, arg4, arg5, arg1.fee_rate, arg1.protocol_fee_rate);
            arg1.fee_a = v2;
            arg1.fee_b = v3;
            arg1.protocol_fee_a = v4;
            arg1.protocol_fee_b = v5;
            arg4 = arg4 - arg1.fee_a;
            arg5 = arg5 - arg1.fee_b;
        };
        let (v6, v7, v8) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::increase_liquidity(v0, arg4, arg5, arg1.active_id);
        arg1.total_amount_a = arg1.total_amount_a - v6;
        arg1.total_amount_b = arg1.total_amount_b - v7;
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::add_liquidity(&mut arg1.position_info, arg0, v0, v8);
        if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::liquidity_share(v0) == 0) {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::remove_bin_from_group(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group_mut(arg2), arg3);
        };
        let v9 = BinLiquidityDelta{
            bin_id          : v1,
            liquidity_share : v8,
            amount_a        : arg4 - v6,
            amount_b        : arg5 - v7,
        };
        0x1::vector::push_back<BinLiquidityDelta>(&mut arg1.liquidity_deltas, v9);
    }

    fun operation_check<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::restriction::OperationKind, arg2: address, arg3: 0x1::option::Option<0x2::object::ID>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::check_user_operation(arg4, arg2, arg1);
        if (0x1::option::is_some<0x2::object::ID>(&arg3)) {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::check_position_operation(arg4, *0x1::option::borrow<0x2::object::ID>(&arg3), arg1);
        };
        if (arg1 == 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::restriction::add_kind()) {
            assert!(!arg0.permissions.disable_add, 13906850667017797633);
        } else if (arg1 == 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::restriction::remove_kind()) {
            assert!(!arg0.permissions.disable_remove, 13906850675607732225);
        } else if (arg1 == 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::restriction::swap_kind()) {
            assert!(!arg0.permissions.disable_swap, 13906850684197666817);
        } else if (arg1 == 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::restriction::collect_fee_kind()) {
            assert!(!arg0.permissions.disable_collect_fee, 13906850692787601409);
        } else if (arg1 == 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::restriction::collect_reward_kind()) {
            assert!(!arg0.permissions.disable_collect_reward, 13906850701377536001);
        } else if (arg1 == 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::restriction::add_reward_kind()) {
            assert!(!arg0.permissions.disable_add_reward, 13906850709967470593);
        };
    }

    public fun pay_amount<T0, T1>(arg0: &FlashSwapReceipt<T0, T1>) : u64 {
        arg0.pay_amount
    }

    public fun permissions<T0, T1>(arg0: &Pool<T0, T1>) : &Permissions {
        &arg0.permissions
    }

    public fun position_detail_amounts(arg0: &PositionDetail) : (u64, u64) {
        (arg0.amount_a, arg0.amount_b)
    }

    public fun position_detail_fees(arg0: &PositionDetail) : (u64, u64) {
        (arg0.fee_a, arg0.fee_b)
    }

    public fun position_detail_position_id(arg0: &PositionDetail) : 0x2::object::ID {
        arg0.position_id
    }

    public fun position_detail_rewards(arg0: &PositionDetail) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &arg0.rewards
    }

    public fun position_detail_update_tx(arg0: &PositionDetail) : &vector<u8> {
        &arg0.update_tx
    }

    public fun position_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::PositionManager {
        &arg0.position_manager
    }

    public fun refresh_position_info<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::object::ID, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : PositionDetail {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg2);
        reward_settle<T0, T1>(arg0, arg3);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::borrow_mut_position_info(&mut arg0.position_manager, arg1);
        let v3 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::lower_bin_id_on_position_info(v2);
        let v4 = 0;
        let (v5, _) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::resolve_bin_position(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(v3));
        let v7 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::zero_bin_group_ref();
        let v8 = false;
        let v9 = if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::contains_group(&arg0.bin_manager, v5)) {
            v8 = true;
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_group_ref(&arg0.bin_manager, v5)
        } else {
            &v7
        };
        let v10 = v9;
        while (v4 < 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::width_on_position_info(v2)) {
            let (v11, v12) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::resolve_bin_position(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(v3));
            if (v11 != v5) {
                let v13 = if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::contains_group(&arg0.bin_manager, v11)) {
                    v8 = true;
                    0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_group_ref(&arg0.bin_manager, v11)
                } else {
                    v8 = false;
                    &v7
                };
                v10 = v13;
            };
            if (v8 && 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::contain_in_group(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group(v10), v12)) {
                let v14 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_from_group(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group(v10), v12);
                0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::update_fee(v2, v14);
                0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::update_rewards(v2, v14);
                let (v15, v16) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_amounts_by_liquidity(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::amount_a(v14), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::amount_b(v14), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::liquidity_share(0x1::vector::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::BinStat>(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::info_stats(v2), v4)), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::liquidity_share(v14));
                v0 = v0 + v15;
                v1 = v1 + v16;
            };
            v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
            v4 = v4 + 1;
        };
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::destroy_zero_bin_group_ref(v7);
        let (v17, v18) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::info_fees(v2);
        let v19 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::info_rewards(v2);
        let v20 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v21 = 0;
        while (v21 < 0x1::vector::length<u64>(v19)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v20, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward::reward_coin(0x1::vector::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward::Reward>(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward::rewards(&arg0.reward_manager), v21)), *0x1::vector::borrow<u64>(v19, v21));
            v21 = v21 + 1;
        };
        PositionDetail{
            position_id : arg1,
            amount_a    : v0,
            amount_b    : v1,
            fee_a       : v17,
            fee_b       : v18,
            rewards     : v20,
            update_tx   : *0x2::tx_context::digest(arg4),
        }
    }

    public fun remove_full_range_liquidity_by_percent<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg2: u128, arg3: u128, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::lower_bin_id(arg1));
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::upper_bin_id(arg1));
        remove_liquidity_by_percent_internal<T0, T1>(arg0, arg1, v0, v1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg2: vector<u32>, arg3: vector<u128>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg5);
        operation_check<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::restriction::remove_kind(), 0x2::tx_context::sender(arg7), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(arg1)), arg4);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::pool_id(arg1), 13906841359823798275);
        assert!(0x1::vector::length<u32>(&arg2) == 0x1::vector::length<u128>(&arg3) && 0x1::vector::length<u32>(&arg2) > 0, 13906841372710404125);
        let v0 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(arg1);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::assert_no_pending_add(arg1);
        reward_settle<T0, T1>(arg0, arg6);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::empty<BinLiquidityDelta>();
        let (v4, _) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::resolve_bin_position(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(&arg2, 0))));
        let v6 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::zero_bin_group_ref();
        let v7 = false;
        let v8 = if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::contains_group(&arg0.bin_manager, v4)) {
            v7 = true;
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_mut_group_ref(&mut arg0.bin_manager, v4)
        } else {
            &mut v6
        };
        let v9 = v8;
        let v10 = 0;
        let v11 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::borrow_mut_position_info(&mut arg0.position_manager, v0);
        while (v10 < 0x1::vector::length<u32>(&arg2)) {
            let v12 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(&arg2, v10));
            assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v12, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::lower_bin_id(arg1)) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v12, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::upper_bin_id(arg1)), 13906841492970274857);
            let v13 = *0x1::vector::borrow<u128>(&arg3, v10);
            let (v14, v15) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::resolve_bin_position(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(v12));
            if (v14 != v4) {
                let v16 = if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::contains_group(&arg0.bin_manager, v14)) {
                    v7 = true;
                    0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_mut_group_ref(&mut arg0.bin_manager, v14)
                } else {
                    v7 = false;
                    &mut v6
                };
                v9 = v16;
            };
            let v17 = v7 && 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::contain_in_group(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group(v9), v15);
            if (!v17 || v13 == 0) {
                assert!(v13 == 0, 13906841574573735963);
                v10 = v10 + 1;
                let v18 = BinLiquidityDelta{
                    bin_id          : v12,
                    liquidity_share : 0,
                    amount_a        : 0,
                    amount_b        : 0,
                };
                0x1::vector::push_back<BinLiquidityDelta>(&mut v3, v18);
                continue
            };
            let v19 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_mut_bin_from_group(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group_mut(v9), v15);
            let (v20, v21) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::decrease_liquidity(v19, v13);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::decrease_liquidity(v11, arg1, v19, v13);
            if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::liquidity_share(v19) == 0) {
                0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::remove_bin_from_group(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group_mut(v9), v15);
                if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::is_empty_group(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group(v9))) {
                    let v22 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::group_idx(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group(v9));
                    v9 = &mut v6;
                    0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::remove_group(&mut arg0.bin_manager, (v22 as u64));
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
            v10 = v10 + 1;
        };
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::destroy_zero_bin_group_ref(v6);
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

    public fun remove_liquidity_by_percent<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg2: u32, arg3: u32, arg4: u16, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        remove_liquidity_by_percent_internal<T0, T1>(arg0, arg1, arg2, arg3, (arg4 as u128), 10000, arg5, arg6, arg7, arg8)
    }

    fun remove_liquidity_by_percent_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg2: u32, arg3: u32, arg4: u128, arg5: u128, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg7: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg7);
        operation_check<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::restriction::remove_kind(), 0x2::tx_context::sender(arg9), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(arg1)), arg6);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::pool_id(arg1), 13906849765074796547);
        assert!(arg4 > 0 && arg4 <= arg5, 13906849769373040693);
        let v0 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(arg1);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::assert_no_pending_add(arg1);
        reward_settle<T0, T1>(arg0, arg8);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::empty<BinLiquidityDelta>();
        let v4 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::borrow_mut_position_info(&mut arg0.position_manager, v0);
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2);
        let v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3);
        let v7 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v5, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::lower_bin_id(arg1))) {
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v6, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::upper_bin_id(arg1))) {
                0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v5, v6)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 13906849842387353651);
        let (v8, _) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::resolve_bin_position(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(v5));
        let v10 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::zero_bin_group_ref();
        let v11 = false;
        let v12 = if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::contains_group(&arg0.bin_manager, v8)) {
            v11 = true;
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_mut_group_ref(&mut arg0.bin_manager, v8)
        } else {
            &mut v10
        };
        let v13 = v12;
        let v14 = v5;
        while (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v14, v6)) {
            let (v15, v16) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::resolve_bin_position(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(v14));
            if (v15 != v8) {
                let v17 = if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::contains_group(&arg0.bin_manager, v15)) {
                    v11 = true;
                    0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_mut_group_ref(&mut arg0.bin_manager, v15)
                } else {
                    v11 = false;
                    &mut v10
                };
                v13 = v17;
            };
            let v18 = v11 && 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::contain_in_group(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group(v13), v16);
            if (!v18) {
                let v19 = BinLiquidityDelta{
                    bin_id          : v14,
                    liquidity_share : 0,
                    amount_a        : 0,
                    amount_b        : 0,
                };
                0x1::vector::push_back<BinLiquidityDelta>(&mut v3, v19);
                v14 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v14, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
                continue
            };
            let v20 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_mut_bin_from_group(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group_mut(v13), v16);
            let v21 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::liquidity_share(0x1::vector::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::BinStat>(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::info_stats(v4), (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v14, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::lower_bin_id(arg1))) as u64))), arg4, arg5);
            let (v22, v23) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::decrease_liquidity(v20, v21);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::decrease_liquidity(v4, arg1, v20, v21);
            if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::liquidity_share(v20) == 0) {
                0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::remove_bin_from_group(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group_mut(v13), v16);
                if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::is_empty_group(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group(v13))) {
                    let v24 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::group_idx(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group(v13));
                    v13 = &mut v10;
                    0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::remove_group(&mut arg0.bin_manager, (v24 as u64));
                };
            };
            v1 = v1 + v22;
            v2 = v2 + v23;
            let v25 = BinLiquidityDelta{
                bin_id          : v14,
                liquidity_share : v21,
                amount_a        : v22,
                amount_b        : v23,
            };
            0x1::vector::push_back<BinLiquidityDelta>(&mut v3, v25);
            v14 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v14, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        };
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::destroy_zero_bin_group_ref(v10);
        let v26 = RemoveLiquidityEvent{
            pool             : 0x2::object::id<Pool<T0, T1>>(arg0),
            position_id      : v0,
            active_id        : arg0.active_id,
            total_amount_a   : v1,
            total_amount_b   : v2,
            liquidity_deltas : v3,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v26);
        (0x2::balance::split<T0>(&mut arg0.balance_a, v1), 0x2::balance::split<T1>(&mut arg0.balance_b, v2))
    }

    public fun repay_add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg2: AddLiquidityCert<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg5);
        let AddLiquidityCert {
            pool_id            : v0,
            position_id        : v1,
            position_info      : v2,
            total_amount_a     : v3,
            total_amount_b     : v4,
            active_id          : _,
            fee_rate           : _,
            protocol_fee_rate  : _,
            protocol_fee_a     : v8,
            protocol_fee_b     : v9,
            fee_a              : v10,
            fee_b              : v11,
            active_id_included : v12,
            active_id_filled   : v13,
            liquidity_deltas   : v14,
        } = arg2;
        assert!(v12 == v13, 13906841054884790331);
        arg0.protocol_fee_a = arg0.protocol_fee_a + v8;
        arg0.protocol_fee_b = arg0.protocol_fee_b + v9;
        let v15 = AddLiquidityEvent{
            pool             : 0x2::object::id<Pool<T0, T1>>(arg0),
            position_id      : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(arg1),
            active_id        : arg0.active_id,
            total_amount_a   : v3,
            total_amount_b   : v4,
            fee_a            : v10,
            fee_b            : v11,
            liquidity_deltas : v14,
        };
        0x2::event::emit<AddLiquidityEvent>(v15);
        assert!(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(arg1) == v1, 13906841115010793477);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::pool_id(arg1) && 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::pool_id(arg1) == v0, 13906841127895564291);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::clear_pending_add(arg1);
        arg0.active_open_positions = arg0.active_open_positions - 1;
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::restore_position_info(&mut arg0.position_manager, v1, v2);
        assert!(0x2::balance::value<T0>(&arg3) == v3, 13906841157960728585);
        assert!(0x2::balance::value<T1>(&arg4) == v4, 13906841162255695881);
        0x2::balance::join<T0>(&mut arg0.balance_a, arg3);
        0x2::balance::join<T1>(&mut arg0.balance_b, arg4);
    }

    public fun repay_flash_swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: FlashSwapReceipt<T0, T1>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg4);
        let FlashSwapReceipt {
            pool_id        : v0,
            a2b            : v1,
            partner_id     : _,
            pay_amount     : v3,
            ref_fee_amount : v4,
        } = arg3;
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == v0, 13906844778618421261);
        assert!(v4 == 0, 13906844782913388557);
        if (v1) {
            assert!(0x2::balance::value<T0>(&arg1) == v3, 13906844791503454223);
            0x2::balance::join<T0>(&mut arg0.balance_a, arg1);
            0x2::balance::destroy_zero<T1>(arg2);
        } else {
            assert!(0x2::balance::value<T1>(&arg2) == v3, 13906844808683323407);
            0x2::balance::join<T1>(&mut arg0.balance_b, arg2);
            0x2::balance::destroy_zero<T0>(arg1);
        };
    }

    public fun repay_flash_swap_with_partner<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: FlashSwapReceipt<T0, T1>, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg5);
        let FlashSwapReceipt {
            pool_id        : v0,
            a2b            : v1,
            partner_id     : v2,
            pay_amount     : v3,
            ref_fee_amount : v4,
        } = arg4;
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == v0, 13906845199525216269);
        assert!(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner>(arg1) == v2, 13906845203820183565);
        if (v1) {
            assert!(0x2::balance::value<T0>(&arg2) == v3, 13906845212410249231);
            if (v4 > 0) {
                0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::receive_ref_fee<T0>(arg1, 0x2::balance::split<T0>(&mut arg2, v4));
            };
            0x2::balance::join<T0>(&mut arg0.balance_a, arg2);
            0x2::balance::destroy_zero<T1>(arg3);
        } else {
            assert!(0x2::balance::value<T1>(&arg3) == v3, 13906845251064954895);
            if (v4 > 0) {
                0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::receive_ref_fee<T1>(arg1, 0x2::balance::split<T1>(&mut arg3, v4));
            };
            0x2::balance::join<T1>(&mut arg0.balance_b, arg3);
            0x2::balance::destroy_zero<T0>(arg2);
        };
    }

    public fun repay_open_position<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg2: OpenPositionCert<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg5);
        let OpenPositionCert {
            pool_id            : v0,
            position_id        : v1,
            width              : v2,
            next_bin_id        : _,
            position_info      : v4,
            total_amount_a     : v5,
            total_amount_b     : v6,
            active_id          : _,
            fee_rate           : _,
            protocol_fee_rate  : _,
            protocol_fee_a     : v10,
            protocol_fee_b     : v11,
            fee_a              : v12,
            fee_b              : v13,
            active_id_included : v14,
            active_id_filled   : v15,
            liquidity_deltas   : v16,
        } = arg2;
        assert!(v14 == v15, 13906840737057210427);
        arg0.protocol_fee_a = arg0.protocol_fee_a + v10;
        arg0.protocol_fee_b = arg0.protocol_fee_b + v11;
        let v17 = AddLiquidityEvent{
            pool             : 0x2::object::id<Pool<T0, T1>>(arg0),
            position_id      : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(arg1),
            active_id        : arg0.active_id,
            total_amount_a   : v5,
            total_amount_b   : v6,
            fee_a            : v12,
            fee_b            : v13,
            liquidity_deltas : v16,
        };
        0x2::event::emit<AddLiquidityEvent>(v17);
        assert!(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(arg1) == v1, 13906840797183213573);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::pool_id(arg1) && 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::pool_id(arg1) == v0, 13906840810067984387);
        assert!(v5 > 0 || v6 > 0, 13906840818661326903);
        assert!(v2 == 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::width(arg1) && v2 <= 1000, 13906840835840540717);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::clear_pending_add(arg1);
        arg0.active_open_positions = arg0.active_open_positions - 1;
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::restore_position_info(&mut arg0.position_manager, v1, v4);
        assert!(0x2::balance::value<T0>(&arg3) == v5, 13906840865902952457);
        assert!(0x2::balance::value<T1>(&arg4) == v6, 13906840870197919753);
        0x2::balance::join<T0>(&mut arg0.balance_a, arg3);
        0x2::balance::join<T1>(&mut arg0.balance_b, arg4);
    }

    public fun reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance_a), 0x2::balance::value<T1>(&arg0.balance_b))
    }

    public fun reward_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward::RewardManager {
        &arg0.reward_manager
    }

    fun reward_settle<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward::settle_rewards(&mut arg0.reward_manager, arg1);
        if (0x1::vector::is_empty<u128>(&v0)) {
            return
        };
        if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward::emergency_reward_pause(&arg0.reward_manager)) {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward::refund_rewards(&mut arg0.reward_manager, v0);
            return
        };
        if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::is_active_bin_empty(&arg0.bin_manager, arg0.active_id)) {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward::rollover_refunds_into_remaining_time(&mut arg0.reward_manager, v0, arg1);
            return
        };
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_mut_bin(&mut arg0.bin_manager, arg0.active_id);
        let v2 = &v0;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<u128>(v2)) {
            if (*0x1::vector::borrow<u128>(v2, v3) > 0) {
                v4 = true;
                /* label 13 */
                if (v4) {
                    let v5 = RewardSettleEvent{
                        pool                : 0x2::object::id<Pool<T0, T1>>(arg0),
                        bin_id              : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(v1),
                        accumulated_rewards : v0,
                        duration            : 0x2::clock::timestamp_ms(arg1) / 1000 - 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward::last_update_time(reward_manager<T0, T1>(arg0)),
                    };
                    0x2::event::emit<RewardSettleEvent>(v5);
                };
                0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::accumulate_rewards(v1, v0);
                return
            };
            v3 = v3 + 1;
        };
        v4 = false;
        /* goto 13 */
    }

    fun swap_in_pool<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: bool, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock) : SwapResult {
        assert!(arg4 <= 1000000000, 13906847677722001431);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::update_references(&mut arg0.v_parameters, arg0.active_id, 0x2::clock::timestamp_ms(arg5) / 1000);
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::first_score_for_swap(&arg0.bin_manager, arg0.active_id, arg2);
        let v1 = default_swap_result();
        let v2 = 0;
        while (arg1 > 0) {
            assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v0), 13906847720671281169);
            let v3 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_by_score(&arg0.bin_manager, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v0));
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::update_volatility_accumulator(&mut arg0.v_parameters, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(v3));
            arg0.active_id = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(v3);
            let v4 = get_total_fee_rate<T0, T1>(arg0);
            let (v5, v6) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::next_bin_for_swap(&mut arg0.bin_manager, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v0), arg2);
            let (v7, v8, v9, v10) = if (arg3) {
                0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::swap_exact_amount_in(v5, arg1, arg2, v4.total_fee_rate, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::protocol_fee_rate(&arg0.v_parameters))
            } else {
                0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::swap_exact_amount_out(v5, arg1, arg2, v4.total_fee_rate, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::protocol_fee_rate(&arg0.v_parameters))
            };
            let v11 = BinSwap{
                bin_id       : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(v5),
                amount_in    : v7,
                amount_out   : v8,
                fee          : v9,
                var_fee_rate : v4.var_fee_rate,
            };
            if (arg3) {
                arg1 = arg1 - v7;
            } else {
                arg1 = arg1 - v8;
            };
            v2 = v2 + v10;
            let v12 = &mut v1;
            update_swap_result(v12, v11);
            v0 = v6;
        };
        let v13 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_inclusive(v2, arg4);
        v1.ref_fee = v13;
        v1.protocol_fee = v2;
        if (arg2) {
            arg0.protocol_fee_a = arg0.protocol_fee_a + v2 - v13;
        } else {
            arg0.protocol_fee_b = arg0.protocol_fee_b + v2 - v13;
        };
        v1
    }

    public fun take_reward_from_close_position_cert<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::ClosePositionCert, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) : 0x2::balance::Balance<T2> {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg2);
        assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::cert_pool_id(arg1) == 0x2::object::id<Pool<T0, T1>>(arg0), 13906844331943526439);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward::withdraw<T2>(&mut arg0.reward_manager, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::take_reward_from_close_cert(arg1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward::get_index<T2>(&arg0.reward_manager)))
    }

    public fun update_base_fee_rate<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::tx_context::TxContext) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg3);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::check_pool_manager_role(arg2, 0x2::tx_context::sender(arg4));
        assert!(arg1 < 100000000, 13906838014047813689);
        let v0 = UpdateBaseFeeRateEvent{
            pool              : 0x2::object::id<Pool<T0, T1>>(arg0),
            old_base_fee_rate : arg0.base_fee_rate,
            new_base_fee_rate : arg1,
        };
        0x2::event::emit<UpdateBaseFeeRateEvent>(v0);
        arg0.base_fee_rate = arg1;
    }

    public fun update_permissions<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool, arg2: bool, arg3: bool, arg4: bool, arg5: bool, arg6: bool, arg7: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg8: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg9: &0x2::tx_context::TxContext) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg8);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::check_pool_manager_role(arg7, 0x2::tx_context::sender(arg9));
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

    public fun update_position_fee_and_rewards<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::object::ID, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &0x2::clock::Clock) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg2);
        reward_settle<T0, T1>(arg0, arg3);
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::borrow_mut_position_info(&mut arg0.position_manager, arg1);
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::lower_bin_id_on_position_info(v0);
        let v2 = 0;
        let (v3, _) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::resolve_bin_position(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(v1));
        let v5 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::zero_bin_group_ref();
        let v6 = false;
        let v7 = if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::contains_group(&arg0.bin_manager, v3)) {
            v6 = true;
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_group_ref(&arg0.bin_manager, v3)
        } else {
            &v5
        };
        let v8 = v7;
        while (v2 < 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::width_on_position_info(v0)) {
            let (v9, v10) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::resolve_bin_position(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(v1));
            if (v9 != v3) {
                let v11 = if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::contains_group(&arg0.bin_manager, v9)) {
                    v6 = true;
                    0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_group_ref(&arg0.bin_manager, v9)
                } else {
                    v6 = false;
                    &v5
                };
                v8 = v11;
            };
            if (v6 && 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::contain_in_group(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group(v8), v10)) {
                let v12 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_from_group(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group(v8), v10);
                0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::update_fee(v0, v12);
                0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::update_rewards(v0, v12);
            };
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
            v2 = v2 + 1;
        };
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::destroy_zero_bin_group_ref(v5);
    }

    fun update_swap_result(arg0: &mut SwapResult, arg1: BinSwap) {
        arg0.amount_in = arg0.amount_in + arg1.amount_in;
        arg0.amount_out = arg0.amount_out + arg1.amount_out;
        arg0.fee = arg0.fee + arg1.fee;
        0x1::vector::push_back<BinSwap>(&mut arg0.steps, arg1);
    }

    public fun v_parameters<T0, T1>(arg0: &Pool<T0, T1>) : &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::VariableParameters {
        &arg0.v_parameters
    }

    // decompiled from Move bytecode v6
}

