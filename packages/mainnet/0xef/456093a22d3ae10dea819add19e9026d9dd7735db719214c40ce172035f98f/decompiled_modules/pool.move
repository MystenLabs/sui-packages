module 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::pool {
    struct POOL has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        index: u64,
        v_parameters: 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::parameters::VariableParameters,
        active_id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        base_fee_rate: u64,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        protocol_fee_a: u64,
        protocol_fee_b: u64,
        reward_manager: 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::reward::RewardManager,
        bin_manager: 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::BinManager,
        position_manager: 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::PositionManager,
        url: 0x1::string::String,
        permissions: Permissions,
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

    struct AddLiquidityReceipt<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct ProtocolFeeCollectCap has store, key {
        id: 0x2::object::UID,
    }

    struct OpenPositionEvent has copy, drop {
        pool: 0x2::object::ID,
        position_id: 0x2::object::ID,
        active_id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        total_amount_a: u64,
        total_amount_b: u64,
        fee_a: u64,
        fee_b: u64,
        liquidity_deltas: vector<BinLiquidityDelta>,
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

    struct UpdateBaseFeeRateEvent has copy, drop {
        pool: 0x2::object::ID,
        old_base_fee_rate: u64,
        new_base_fee_rate: u64,
    }

    public fun fetch_bins<T0, T1>(arg0: &Pool<T0, T1>, arg1: vector<u32>, arg2: u64) : vector<0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::BinInfo> {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::fetch_bins(&arg0.bin_manager, arg1, arg2)
    }

    public fun bin_step<T0, T1>(arg0: &Pool<T0, T1>) : u16 {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::parameters::bin_step(&arg0.v_parameters)
    }

    public fun get_variable_fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::parameters::get_variable_fee_rate(&arg0.v_parameters)
    }

    public fun active_id<T0, T1>(arg0: &Pool<T0, T1>) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.active_id
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::Position, arg2: vector<u32>, arg3: vector<u64>, arg4: vector<u64>, arg5: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg6: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : AddLiquidityReceipt<T0, T1> {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg6);
        operation_check<T0, T1>(arg0, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::restriction::add_kind(), 0x2::tx_context::sender(arg8), 0x1::option::some<0x2::object::ID>(0x2::object::id<0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::Position>(arg1)), arg5);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::pool_id(arg1), 13906837777821073411);
        reward_settle<T0, T1>(arg0, arg7);
        assert!(0x1::vector::length<u32>(&arg2) == 0x1::vector::length<u64>(&arg3) && 0x1::vector::length<u32>(&arg2) == 0x1::vector::length<u64>(&arg4), 13906837799296040965);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x1::vector::empty<BinLiquidityDelta>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<u32>(&arg2)) {
            let v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(&arg2, v5));
            let v7 = *0x1::vector::borrow<u64>(&arg3, v5);
            let v8 = *0x1::vector::borrow<u64>(&arg4, v5);
            let v9 = v8;
            let v10 = v7;
            v1 = v1 + v7;
            v0 = v0 + v8;
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v6, arg0.active_id)) {
                let (v11, v12) = apply_active_bin_composition_fees<T0, T1>(arg0, v7, v8, arg7);
                v2 = v12;
                v3 = v11;
                v10 = v7 - v11;
                v9 = v8 - v12;
            };
            0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::add_bin_if_absent(&mut arg0.bin_manager, v6);
            let v13 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::borrow_bin_mut(&mut arg0.bin_manager, v6);
            let v14 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::increase_liquidity(v13, v10, v9, arg0.active_id);
            0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::increase_liquidity(&mut arg0.position_manager, arg1, v13, v14);
            let v15 = BinLiquidityDelta{
                bin_id          : v6,
                liquidity_share : v14,
                amount_a        : v10,
                amount_b        : v9,
            };
            0x1::vector::push_back<BinLiquidityDelta>(&mut v4, v15);
            v5 = v5 + 1;
        };
        let v16 = AddLiquidityEvent{
            pool             : 0x2::object::id<Pool<T0, T1>>(arg0),
            position_id      : 0x2::object::id<0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::Position>(arg1),
            active_id        : arg0.active_id,
            total_amount_a   : v1,
            total_amount_b   : v0,
            fee_a            : v3,
            fee_b            : v2,
            liquidity_deltas : v4,
        };
        0x2::event::emit<AddLiquidityEvent>(v16);
        AddLiquidityReceipt<T0, T1>{
            pool_id  : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount_a : v1,
            amount_b : v0,
        }
    }

    public fun add_reward<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T2>, arg2: u64, arg3: vector<u64>, arg4: u64, arg5: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg6: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg6);
        operation_check<T0, T1>(arg0, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::restriction::add_reward_kind(), 0x2::tx_context::sender(arg8), 0x1::option::none<0x2::object::ID>(), arg5);
        if (!0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::reward::is_public(&arg0.reward_manager)) {
            0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::check_reward_manager_role(arg5, 0x2::tx_context::sender(arg8));
        };
        reward_settle<T0, T1>(arg0, arg7);
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::reward::add_reward<T2>(&mut arg0.reward_manager, arg3, arg4, 0x2::coin::into_balance<T2>(arg1), arg7);
        let v0 = if (0x1::vector::is_empty<u64>(&arg3)) {
            0x2::clock::timestamp_ms(arg7) / 1000
        } else {
            *0x1::vector::borrow<u64>(&arg3, 0)
        };
        let v1 = AddRewardEvent{
            pool       : 0x2::object::id<Pool<T0, T1>>(arg0),
            reward     : 0x1::type_name::get<T2>(),
            amount     : arg2,
            start_time : v0,
            end_time   : arg4,
        };
        0x2::event::emit<AddRewardEvent>(v1);
    }

    public fun amounts<T0, T1>(arg0: &AddLiquidityReceipt<T0, T1>) : (u64, u64) {
        (arg0.amount_a, arg0.amount_b)
    }

    public fun amounts_in_active_bin<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        if (0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::contains(&arg0.bin_manager, arg0.active_id)) {
            let v2 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::borrow_bin(&arg0.bin_manager, arg0.active_id);
            (0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::amount_a(v2), 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::amount_b(v2))
        } else {
            (0, 0)
        }
    }

    fun apply_active_bin_composition_fees<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64) {
        if (!0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::contains(&arg0.bin_manager, arg0.active_id)) {
            return (0, 0)
        };
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::parameters::update_volatility_parameter(&mut arg0.v_parameters, arg0.active_id, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v0 = get_total_fee_rate<T0, T1>(arg0);
        let v1 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::parameters::protocol_fee_rate(&arg0.v_parameters);
        let v2 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::borrow_bin_mut(&mut arg0.bin_manager, arg0.active_id);
        let (v3, v4) = get_composition_fees(v2, arg1, arg2, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::dlmm_math::calculate_liquidity_by_amounts(arg1, arg2, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::price(v2)), v0.total_fee_rate);
        let v5 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::dlmm_math::calculate_fee_inclusive(v3, v1);
        let v6 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::dlmm_math::calculate_fee_inclusive(v4, v1);
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::accumulate_fee(v2, v3 - v5, v4 - v6);
        arg0.protocol_fee_a = arg0.protocol_fee_a + v5;
        arg0.protocol_fee_b = arg0.protocol_fee_b + v6;
        (v3, v4)
    }

    public fun base_fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.base_fee_rate
    }

    public fun bin_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::BinManager {
        &arg0.bin_manager
    }

    public fun close_position<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::Position, arg2: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg3: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::ClosePositionCert, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg3);
        operation_check<T0, T1>(arg0, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::restriction::remove_kind(), 0x2::tx_context::sender(arg5), 0x1::option::some<0x2::object::ID>(0x2::object::id<0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::Position>(&arg1)), arg2);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::pool_id(&arg1), 13906839564527468547);
        reward_settle<T0, T1>(arg0, arg4);
        let v0 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::close_position(&mut arg0.position_manager, arg1);
        let v1 = 0x1::vector::empty<BinLiquidityDelta>();
        while (!0x1::vector::is_empty<0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::BinStat>(0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::cert_stats(&v0))) {
            let v2 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::pop_position_bin(&mut v0);
            let v3 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::liquidity_share(&v2);
            let v4 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::bin_id(&v2);
            let (v5, v6) = if (!0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::contains(&arg0.bin_manager, v4)) {
                assert!(v3 == 0, 13906839620363485209);
                0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::destroy_bin_stat(v2);
                (0, 0)
            } else {
                let v7 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::borrow_bin_mut(&mut arg0.bin_manager, v4);
                let (v8, v9) = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::close_position_bin(&mut v0, v7, v2);
                if (0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::liquidity_supply(v7) == 0) {
                    0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::remove_bin(&mut arg0.bin_manager, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::id(v7));
                };
                (v8, v9)
            };
            let v10 = BinLiquidityDelta{
                bin_id          : v4,
                liquidity_share : v3,
                amount_a        : v5,
                amount_b        : v6,
            };
            0x1::vector::push_back<BinLiquidityDelta>(&mut v1, v10);
        };
        let (v11, v12) = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::take_amounts_from_close_cert(&mut v0);
        let (v13, v14) = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::take_fee_from_close_cert(&mut v0);
        let v15 = ClosePositionEvent{
            pool             : 0x2::object::id<Pool<T0, T1>>(arg0),
            position_id      : 0x2::object::id<0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::Position>(&arg1),
            active_id        : arg0.active_id,
            total_amount_a   : v11,
            total_amount_b   : v12,
            fee_a            : v13,
            fee_b            : v14,
            rewards          : *0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::cert_rewards_owned(&v0),
            liquidity_deltas : v1,
        };
        0x2::event::emit<ClosePositionEvent>(v15);
        (v0, 0x2::balance::split<T0>(&mut arg0.balance_a, v11 + v13), 0x2::balance::split<T1>(&mut arg0.balance_b, v12 + v14))
    }

    public fun collect_position_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::Position, arg2: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg3: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg3);
        operation_check<T0, T1>(arg0, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::restriction::collect_fee_kind(), 0x2::tx_context::sender(arg4), 0x1::option::some<0x2::object::ID>(0x2::object::id<0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::Position>(arg1)), arg2);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::pool_id(arg1), 13906839087786098691);
        let (v0, v1) = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::take_fee_from_position(&mut arg0.position_manager, arg1);
        let v2 = CollectFeeEvent{
            pool     : 0x2::object::id<Pool<T0, T1>>(arg0),
            position : 0x2::object::id<0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::Position>(arg1),
            fee_a    : v0,
            fee_b    : v1,
        };
        0x2::event::emit<CollectFeeEvent>(v2);
        (0x2::balance::split<T0>(&mut arg0.balance_a, v0), 0x2::balance::split<T1>(&mut arg0.balance_b, v1))
    }

    public fun collect_position_reward<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &mut 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::Position, arg2: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg3: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg3);
        operation_check<T0, T1>(arg0, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::restriction::collect_reward_kind(), 0x2::tx_context::sender(arg4), 0x1::option::some<0x2::object::ID>(0x2::object::id<0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::Position>(arg1)), arg2);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::pool_id(arg1), 13906839324009299971);
        let v0 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::take_reward_from_position(&mut arg0.position_manager, arg1, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::reward::get_index<T2>(&arg0.reward_manager));
        let v1 = CollectRewardEvent{
            pool     : 0x2::object::id<Pool<T0, T1>>(arg0),
            position : 0x2::object::id<0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::Position>(arg1),
            reward   : 0x1::type_name::get<T2>(),
            amount   : v0,
        };
        0x2::event::emit<CollectRewardEvent>(v1);
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::reward::withdraw<T2>(&mut arg0.reward_manager, v0)
    }

    public fun collect_protocol_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg2: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg2);
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::check_protocol_fee_manager_role(arg1, 0x2::tx_context::sender(arg3));
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

    public fun collect_protocol_fee_with_cap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg2: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg3: &ProtocolFeeCollectCap) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg2);
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::check_protocol_fee_manager_role(arg1, 0x2::object::id_address<ProtocolFeeCollectCap>(arg3));
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

    public fun destroy_close_position_cert(arg0: 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::ClosePositionCert, arg1: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned) {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg1);
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::destroy_cert(arg0);
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

    public fun emergency_pause_reward<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg2: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg2);
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::reward::emergency_pause(&mut arg0.reward_manager);
        let v0 = EmergencyPauseRewardEvent{pool: 0x2::object::id<Pool<T0, T1>>(arg0)};
        0x2::event::emit<EmergencyPauseRewardEvent>(v0);
    }

    public fun emergency_unpause_reward<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg2: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg2);
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::reward::emergency_unpause(&mut arg0.reward_manager);
        let v0 = EmergencyUnpauseRewardEvent{pool: 0x2::object::id<Pool<T0, T1>>(arg0)};
        0x2::event::emit<EmergencyUnpauseRewardEvent>(v0);
    }

    public fun flash_swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg5: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg5);
        operation_check<T0, T1>(arg0, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::restriction::swap_kind(), 0x2::tx_context::sender(arg7), 0x1::option::none<0x2::object::ID>(), arg4);
        flash_swap_internal<T0, T1>(arg0, 0x2::object::id_from_address(@0x0), 0, arg1, arg2, arg3, arg6)
    }

    fun flash_swap_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::object::ID, arg2: u64, arg3: bool, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        assert!(arg5 > 0, 13906842257472880657);
        reward_settle<T0, T1>(arg0, arg6);
        let v0 = swap_in_pool<T0, T1>(arg0, arg5, arg3, arg4, arg2, arg6);
        let (v1, v2) = if (arg3) {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg0.balance_b, v0.amount_out))
        } else {
            (0x2::balance::split<T0>(&mut arg0.balance_a, v0.amount_out), 0x2::balance::zero<T1>())
        };
        assert!(v0.amount_out > 0, 13906842309012619283);
        let (v3, v4) = if (arg3) {
            (0x1::type_name::get<T0>(), 0x1::type_name::get<T1>())
        } else {
            (0x1::type_name::get<T1>(), 0x1::type_name::get<T0>())
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

    public fun flash_swap_with_partner<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::partner::Partner, arg2: bool, arg3: bool, arg4: u64, arg5: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg6: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg6);
        operation_check<T0, T1>(arg0, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::restriction::swap_kind(), 0x2::tx_context::sender(arg8), 0x1::option::none<0x2::object::ID>(), arg5);
        flash_swap_internal<T0, T1>(arg0, 0x2::object::id<0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::partner::Partner>(arg1), 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::partner::current_ref_fee_rate(arg1, 0x2::clock::timestamp_ms(arg7) / 1000), arg2, arg3, arg4, arg7)
    }

    public fun get_composition_fees(arg0: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::Bin, arg1: u64, arg2: u64, arg3: u128, arg4: u64) : (u64, u64) {
        if (0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::liquidity_supply(arg0) == 0) {
            return (0, 0)
        };
        let (v0, v1) = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::dlmm_math::calculate_amounts_by_liquidity(0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::amount_a(arg0) + arg1, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::amount_b(arg0) + arg2, arg3, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::liquidity_supply(arg0) + arg3);
        let v2 = 0;
        let v3 = 0;
        if (v0 > arg1 && arg2 > v1) {
            v3 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::dlmm_math::calculate_composition_fee(arg2 - v1, arg4);
        } else if (v1 > arg2 && arg1 > v0) {
            v2 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::dlmm_math::calculate_composition_fee(arg1 - v0, arg4);
        };
        (v2, v3)
    }

    public fun get_total_fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : FeeRate {
        let v0 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::parameters::get_variable_fee_rate(&arg0.v_parameters);
        FeeRate{
            base_fee_rate  : arg0.base_fee_rate,
            var_fee_rate   : (v0 as u64),
            total_fee_rate : (0x1::u128::min((arg0.base_fee_rate as u128) + (v0 as u128), (0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::constants::max_fee_rate() as u128)) as u64),
        }
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<POOL>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun initialize_reward<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg2: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg2);
        operation_check<T0, T1>(arg0, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::restriction::add_reward_kind(), 0x2::tx_context::sender(arg4), 0x1::option::none<0x2::object::ID>(), arg1);
        if (!0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::reward::is_public(&arg0.reward_manager)) {
            0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::check_reward_manager_role(arg1, 0x2::tx_context::sender(arg4));
        };
        let v0 = if (0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::is_whitelist<T2>(arg1)) {
            true
        } else if (0x1::type_name::get<T0>() == 0x1::type_name::get<T2>()) {
            true
        } else {
            0x1::type_name::get<T1>() == 0x1::type_name::get<T2>()
        };
        assert!(v0, 13906841763551117321);
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::reward::initialize_reward<T2>(&mut arg0.reward_manager, arg3, arg4);
        let v1 = InitializeRewardEvent{
            pool   : 0x2::object::id<Pool<T0, T1>>(arg0),
            reward : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<InitializeRewardEvent>(v1);
    }

    public fun make_reward_private<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg2: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg3: &0x2::tx_context::TxContext) {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg2);
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::check_reward_manager_role(arg1, 0x2::tx_context::sender(arg3));
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::reward::make_private(&mut arg0.reward_manager);
        let v0 = MakeRewardPrivateEvent{pool: 0x2::object::id<Pool<T0, T1>>(arg0)};
        0x2::event::emit<MakeRewardPrivateEvent>(v0);
    }

    public fun make_reward_public<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg2: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg3: &0x2::tx_context::TxContext) {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg2);
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::check_reward_manager_role(arg1, 0x2::tx_context::sender(arg3));
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::reward::make_public(&mut arg0.reward_manager);
        let v0 = MakeRewardPublicEvent{pool: 0x2::object::id<Pool<T0, T1>>(arg0)};
        0x2::event::emit<MakeRewardPublicEvent>(v0);
    }

    public fun mint_protocol_fee_collect_cap(arg0: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::admin_cap::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolFeeCollectCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<ProtocolFeeCollectCap>(v0, arg1);
    }

    public(friend) fun new_pool<T0, T1>(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u64, arg2: 0x1::string::String, arg3: 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::BinStepConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        let v0 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::bin_step(&arg3);
        let v1 = Permissions{
            disable_add            : false,
            disable_remove         : false,
            disable_swap           : false,
            disable_collect_fee    : false,
            disable_collect_reward : false,
            disable_add_reward     : false,
        };
        Pool<T0, T1>{
            id               : 0x2::object::new(arg5),
            index            : arg1,
            v_parameters     : 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::parameters::new_variable_parameters(arg3, arg0),
            active_id        : arg0,
            base_fee_rate    : (0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::base_factor(&arg3) as u64) * (v0 as u64) * 10,
            balance_a        : 0x2::balance::zero<T0>(),
            balance_b        : 0x2::balance::zero<T1>(),
            protocol_fee_a   : 0,
            protocol_fee_b   : 0,
            reward_manager   : 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::reward::new(arg5),
            bin_manager      : 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::new(v0, 0x2::clock::timestamp_ms(arg4), arg5),
            position_manager : 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::new(v0, arg5),
            url              : arg2,
            permissions      : v1,
        }
    }

    public fun open_position<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<u32>, arg2: vector<u64>, arg3: vector<u64>, arg4: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg5: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::Position, AddLiquidityReceipt<T0, T1>) {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg5);
        operation_check<T0, T1>(arg0, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::restriction::add_kind(), 0x2::tx_context::sender(arg7), 0x1::option::none<0x2::object::ID>(), arg4);
        reward_settle<T0, T1>(arg0, arg6);
        assert!(0x1::vector::length<u32>(&arg1) > 0, 13906837283899965445);
        let v0 = 0x1::vector::length<u32>(&arg1);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(&arg1, 0));
        let v2 = 0;
        assert!(v0 == 0x1::vector::length<u64>(&arg2) && v0 == 0x1::vector::length<u64>(&arg3), 13906837301079834629);
        assert!(v0 <= (0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::constants::max_bin_per_position() as u64), 13906837313965916183);
        let v3 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::new_open_position_arg();
        let v4 = 0;
        let v5 = 0;
        let v6 = 0x1::vector::empty<BinLiquidityDelta>();
        let v7 = 0;
        let v8 = 0;
        while (v2 < v0) {
            let v9 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(&arg1, v2));
            assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v9, v1), 13906837348325654551);
            let v10 = *0x1::vector::borrow<u64>(&arg2, v2);
            let v11 = v10;
            let v12 = *0x1::vector::borrow<u64>(&arg3, v2);
            let v13 = v12;
            v5 = v5 + v10;
            v4 = v4 + v12;
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v9, arg0.active_id)) {
                let (v14, v15) = apply_active_bin_composition_fees<T0, T1>(arg0, v10, v12, arg6);
                v7 = v15;
                v8 = v14;
                v11 = v10 - v14;
                v13 = v12 - v15;
            };
            0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::add_bin_if_absent(&mut arg0.bin_manager, v9);
            let v16 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::borrow_bin_mut(&mut arg0.bin_manager, v9);
            let v17 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::increase_liquidity(v16, v11, v13, arg0.active_id);
            0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::push_back(&mut v3, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::new_bin_stat(v16, v17));
            let v18 = BinLiquidityDelta{
                bin_id          : v9,
                liquidity_share : v17,
                amount_a        : v11,
                amount_b        : v13,
            };
            0x1::vector::push_back<BinLiquidityDelta>(&mut v6, v18);
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
            v2 = v2 + 1;
        };
        let v19 = 0x2::object::id<Pool<T0, T1>>(arg0);
        let v20 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::open_position<T0, T1>(&mut arg0.position_manager, v19, arg0.index, arg0.url, v3, arg7);
        let v21 = OpenPositionEvent{
            pool             : v19,
            position_id      : 0x2::object::id<0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::Position>(&v20),
            active_id        : arg0.active_id,
            total_amount_a   : v5,
            total_amount_b   : v4,
            fee_a            : v8,
            fee_b            : v7,
            liquidity_deltas : v6,
        };
        0x2::event::emit<OpenPositionEvent>(v21);
        let v22 = AddLiquidityReceipt<T0, T1>{
            pool_id  : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount_a : v5,
            amount_b : v4,
        };
        (v20, v22)
    }

    fun operation_check<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::restriction::OperationKind, arg2: address, arg3: 0x1::option::Option<0x2::object::ID>, arg4: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig) {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::check_user_operation(arg4, arg2, arg1);
        if (0x1::option::is_some<0x2::object::ID>(&arg3)) {
            0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::check_position_operation(arg4, *0x1::option::borrow<0x2::object::ID>(&arg3), arg1);
        };
        if (arg1 == 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::restriction::add_kind()) {
            assert!(!arg0.permissions.disable_add, 13906844885991817217);
        } else if (arg1 == 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::restriction::remove_kind()) {
            assert!(!arg0.permissions.disable_remove, 13906844894581751809);
        } else if (arg1 == 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::restriction::swap_kind()) {
            assert!(!arg0.permissions.disable_swap, 13906844903171686401);
        } else if (arg1 == 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::restriction::collect_fee_kind()) {
            assert!(!arg0.permissions.disable_collect_fee, 13906844911761620993);
        } else if (arg1 == 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::restriction::collect_reward_kind()) {
            assert!(!arg0.permissions.disable_collect_reward, 13906844920351555585);
        } else if (arg1 == 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::restriction::add_reward_kind()) {
            assert!(!arg0.permissions.disable_add_reward, 13906844928941490177);
        };
    }

    public fun pay_amount<T0, T1>(arg0: &FlashSwapReceipt<T0, T1>) : u64 {
        arg0.pay_amount
    }

    public fun permissions<T0, T1>(arg0: &Pool<T0, T1>) : &Permissions {
        &arg0.permissions
    }

    public fun position_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::PositionManager {
        &arg0.position_manager
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::Position, arg2: vector<u32>, arg3: vector<u128>, arg4: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg5: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg5);
        operation_check<T0, T1>(arg0, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::restriction::remove_kind(), 0x2::tx_context::sender(arg7), 0x1::option::some<0x2::object::ID>(0x2::object::id<0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::Position>(arg1)), arg4);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::pool_id(arg1), 13906838392001396739);
        assert!(0x1::vector::length<u32>(&arg2) == 0x1::vector::length<u128>(&arg3), 13906838396297936923);
        reward_settle<T0, T1>(arg0, arg6);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::empty<BinLiquidityDelta>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<u32>(&arg2)) {
            let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(&arg2, v3));
            let v5 = *0x1::vector::borrow<u128>(&arg3, v3);
            if (!0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::contains(&arg0.bin_manager, v4)) {
                assert!(v5 == 0, 13906838456427347993);
                v3 = v3 + 1;
                let v6 = BinLiquidityDelta{
                    bin_id          : v4,
                    liquidity_share : 0,
                    amount_a        : 0,
                    amount_b        : 0,
                };
                0x1::vector::push_back<BinLiquidityDelta>(&mut v2, v6);
                continue
            };
            let v7 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::borrow_bin_mut(&mut arg0.bin_manager, v4);
            let (v8, v9) = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::decrease_liquidity(v7, v5);
            0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::decrease_liquidity(&mut arg0.position_manager, arg1, v7, v5);
            if (0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::liquidity_supply(v7) == 0) {
                0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::remove_bin(&mut arg0.bin_manager, v4);
            };
            v0 = v0 + v8;
            v1 = v1 + v9;
            let v10 = BinLiquidityDelta{
                bin_id          : v4,
                liquidity_share : v5,
                amount_a        : v8,
                amount_b        : v9,
            };
            0x1::vector::push_back<BinLiquidityDelta>(&mut v2, v10);
            v3 = v3 + 1;
        };
        let v11 = RemoveLiquidityEvent{
            pool             : 0x2::object::id<Pool<T0, T1>>(arg0),
            position_id      : 0x2::object::id<0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::Position>(arg1),
            active_id        : arg0.active_id,
            total_amount_a   : v0,
            total_amount_b   : v1,
            liquidity_deltas : v2,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v11);
        (0x2::balance::split<T0>(&mut arg0.balance_a, v0), 0x2::balance::split<T1>(&mut arg0.balance_b, v1))
    }

    public fun repay_add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: AddLiquidityReceipt<T0, T1>, arg4: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned) {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg4);
        let AddLiquidityReceipt {
            pool_id  : v0,
            amount_a : v1,
            amount_b : v2,
        } = arg3;
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == v0, 13906838181547999235);
        assert!(0x2::balance::value<T0>(&arg1) == v1, 13906838185843228679);
        assert!(0x2::balance::value<T1>(&arg2) == v2, 13906838190138195975);
        0x2::balance::join<T0>(&mut arg0.balance_a, arg1);
        0x2::balance::join<T1>(&mut arg0.balance_b, arg2);
    }

    public fun repay_flash_swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: FlashSwapReceipt<T0, T1>, arg4: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned) {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg4);
        let FlashSwapReceipt {
            pool_id        : v0,
            a2b            : v1,
            partner_id     : _,
            pay_amount     : v3,
            ref_fee_amount : v4,
        } = arg3;
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == v0, 13906840346212040715);
        assert!(v4 == 0, 13906840350507008011);
        if (v1) {
            assert!(0x2::balance::value<T0>(&arg1) == v3, 13906840359097073677);
            0x2::balance::join<T0>(&mut arg0.balance_a, arg1);
            0x2::balance::destroy_zero<T1>(arg2);
        } else {
            assert!(0x2::balance::value<T1>(&arg2) == v3, 13906840376276942861);
            0x2::balance::join<T1>(&mut arg0.balance_b, arg2);
            0x2::balance::destroy_zero<T0>(arg1);
        };
    }

    public fun repay_flash_swap_with_partner<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::partner::Partner, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: FlashSwapReceipt<T0, T1>, arg5: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned) {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg5);
        let FlashSwapReceipt {
            pool_id        : v0,
            a2b            : v1,
            partner_id     : v2,
            pay_amount     : v3,
            ref_fee_amount : v4,
        } = arg4;
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == v0, 13906840767118835723);
        assert!(0x2::object::id<0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::partner::Partner>(arg1) == v2, 13906840771413803019);
        if (v1) {
            assert!(0x2::balance::value<T0>(&arg2) == v3, 13906840780003868685);
            if (v4 > 0) {
                0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::partner::receive_ref_fee<T0>(arg1, 0x2::balance::split<T0>(&mut arg2, v4));
            };
            0x2::balance::join<T0>(&mut arg0.balance_a, arg2);
            0x2::balance::destroy_zero<T1>(arg3);
        } else {
            assert!(0x2::balance::value<T1>(&arg3) == v3, 13906840818658574349);
            if (v4 > 0) {
                0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::partner::receive_ref_fee<T1>(arg1, 0x2::balance::split<T1>(&mut arg3, v4));
            };
            0x2::balance::join<T1>(&mut arg0.balance_b, arg3);
            0x2::balance::destroy_zero<T0>(arg2);
        };
    }

    public fun reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance_a), 0x2::balance::value<T1>(&arg0.balance_b))
    }

    public fun reward_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::reward::RewardManager {
        &arg0.reward_manager
    }

    fun reward_settle<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::reward::settle_rewards(&mut arg0.reward_manager, arg1);
        if (0x1::vector::is_empty<u128>(&v0)) {
            return
        };
        if (0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::is_active_bin_empty(&arg0.bin_manager, arg0.active_id)) {
            0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::reward::rollover_refunds_into_remaining_time(&mut arg0.reward_manager, v0, arg1);
            return
        };
        if (0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::reward::emergency_reward_pause(&arg0.reward_manager)) {
            0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::reward::refund_rewards(&mut arg0.reward_manager, v0);
            return
        };
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::accumulate_rewards(0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::borrow_bin_mut(&mut arg0.bin_manager, arg0.active_id), v0);
    }

    fun swap_in_pool<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: bool, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock) : SwapResult {
        assert!(arg4 <= 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::constants::fee_precision(), 13906842579595690005);
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::parameters::update_references(&mut arg0.v_parameters, 0x2::clock::timestamp_ms(arg5) / 1000);
        let v0 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::first_score_for_swap(&arg0.bin_manager, arg0.active_id, arg2);
        let v1 = arg1;
        let v2 = default_swap_result();
        let v3 = 0;
        while (v1 > 0) {
            assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v0), 13906842622544969743);
            0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::parameters::update_volatility_accumulator(&mut arg0.v_parameters, arg0.active_id);
            let v4 = get_total_fee_rate<T0, T1>(arg0);
            let (v5, v6) = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::next_bin_for_swap(&mut arg0.bin_manager, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v0), arg2);
            let (v7, v8, v9, v10) = if (arg3) {
                0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::swap_exact_amount_in(v5, v1, arg2, v4.total_fee_rate, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::parameters::protocol_fee_rate(&arg0.v_parameters))
            } else {
                0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::swap_exact_amount_out(v5, v1, arg2, v4.total_fee_rate, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::parameters::protocol_fee_rate(&arg0.v_parameters))
            };
            let v11 = BinSwap{
                bin_id       : 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::id(v5),
                amount_in    : v7,
                amount_out   : v8,
                fee          : v9,
                var_fee_rate : v4.var_fee_rate,
            };
            if (arg3) {
                v1 = v1 - v7;
            } else {
                v1 = v1 - v8;
            };
            v3 = v3 + v10;
            let v12 = &mut v2;
            update_swap_result(v12, v11);
            v0 = v6;
            if (v1 > 0 && 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v0)) {
                arg0.active_id = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::id(0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::borrow_bin_from_score(&arg0.bin_manager, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v0)));
            };
        };
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::parameters::update_index_reference(&mut arg0.v_parameters, arg0.active_id);
        let v13 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::dlmm_math::calculate_fee_inclusive(v3, arg4);
        v2.ref_fee = v13;
        v2.protocol_fee = v3;
        if (arg2) {
            arg0.protocol_fee_a = arg0.protocol_fee_a + v3 - v13;
        } else {
            arg0.protocol_fee_b = arg0.protocol_fee_b + v3 - v13;
        };
        v2
    }

    public fun take_reward_from_close_position_cert<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &mut 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::ClosePositionCert, arg2: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned) : 0x2::balance::Balance<T2> {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg2);
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::reward::withdraw<T2>(&mut arg0.reward_manager, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::take_reward_from_close_cert(arg1, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::reward::get_index<T2>(&arg0.reward_manager)))
    }

    public fun update_base_fee_rate<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg2: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext, arg4: u64) {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg2);
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        let v0 = UpdateBaseFeeRateEvent{
            pool              : 0x2::object::id<Pool<T0, T1>>(arg0),
            old_base_fee_rate : arg0.base_fee_rate,
            new_base_fee_rate : arg4,
        };
        0x2::event::emit<UpdateBaseFeeRateEvent>(v0);
        arg0.base_fee_rate = arg4;
    }

    public fun update_permissions<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool, arg2: bool, arg3: bool, arg4: bool, arg5: bool, arg6: bool, arg7: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg8: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg9: &0x2::tx_context::TxContext) {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg8);
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::check_pool_manager_role(arg7, 0x2::tx_context::sender(arg9));
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

    public fun update_position_fee_and_rewards<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::object::ID, arg2: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg3: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::check_version(arg3);
        operation_check<T0, T1>(arg0, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::restriction::collect_fee_kind(), 0x2::tx_context::sender(arg5), 0x1::option::some<0x2::object::ID>(arg1), arg2);
        operation_check<T0, T1>(arg0, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::restriction::collect_reward_kind(), 0x2::tx_context::sender(arg5), 0x1::option::some<0x2::object::ID>(arg1), arg2);
        reward_settle<T0, T1>(arg0, arg4);
        let v0 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::borrow_position_info(&arg0.position_manager, arg1);
        let v1 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::lower_bin_id_on_position_info(v0);
        let v2 = 0;
        while (v2 < 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::width_on_position_info(v0)) {
            if (!0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::contains(&arg0.bin_manager, v1)) {
                assert!(0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::liquidity_share(0x1::vector::borrow<0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::BinStat>(0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::info_stats(0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::borrow_position_info(&arg0.position_manager, arg1)), v2)) == 0, 13906838873039175705);
            } else {
                let v3 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::borrow_bin(&arg0.bin_manager, v1);
                0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::update_fee(&mut arg0.position_manager, arg1, v3);
                0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::update_rewards(&mut arg0.position_manager, arg1, v3);
            };
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
            v2 = v2 + 1;
        };
    }

    fun update_swap_result(arg0: &mut SwapResult, arg1: BinSwap) {
        arg0.amount_in = arg0.amount_in + arg1.amount_in;
        arg0.amount_out = arg0.amount_out + arg1.amount_out;
        arg0.fee = arg0.fee + arg1.fee;
        0x1::vector::push_back<BinSwap>(&mut arg0.steps, arg1);
    }

    public fun v_parameters<T0, T1>(arg0: &Pool<T0, T1>) : &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::parameters::VariableParameters {
        &arg0.v_parameters
    }

    // decompiled from Move bytecode v6
}

