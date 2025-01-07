module 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_events {
    struct New2Pool<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop {
        pool_id: address,
    }

    struct New3Pool<phantom T0, phantom T1, phantom T2, phantom T3, phantom T4> has copy, drop {
        pool_id: address,
    }

    struct New4Pool<phantom T0, phantom T1, phantom T2, phantom T3, phantom T4, phantom T5> has copy, drop {
        pool_id: address,
    }

    struct New5Pool<phantom T0, phantom T1, phantom T2, phantom T3, phantom T4, phantom T5, phantom T6> has copy, drop {
        pool_id: address,
    }

    struct AddLiquidity2Pool<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop {
        pool_id: address,
        amount_a: u64,
        amount_b: u64,
        shares: u64,
    }

    struct AddLiquidity3Pool<phantom T0, phantom T1, phantom T2, phantom T3, phantom T4> has copy, drop {
        pool_id: address,
        amount_a: u64,
        amount_b: u64,
        amount_c: u64,
        shares: u64,
    }

    struct AddLiquidity4Pool<phantom T0, phantom T1, phantom T2, phantom T3, phantom T4, phantom T5> has copy, drop {
        pool_id: address,
        amount_a: u64,
        amount_b: u64,
        amount_c: u64,
        amount_d: u64,
        shares: u64,
    }

    struct AddLiquidity5Pool<phantom T0, phantom T1, phantom T2, phantom T3, phantom T4, phantom T5, phantom T6> has copy, drop {
        pool_id: address,
        amount_a: u64,
        amount_b: u64,
        amount_c: u64,
        amount_d: u64,
        amount_e: u64,
        shares: u64,
    }

    struct Swap<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop {
        pool_id: address,
        amount_in: u64,
        amount_out: u64,
    }

    struct RemoveLiquidity<phantom T0, phantom T1, phantom T2> has copy, drop {
        pool_id: address,
        amount: u64,
        shares: u64,
    }

    struct RemoveLiquidity2Pool<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop {
        pool_id: address,
        amount_a: u64,
        amount_b: u64,
        shares: u64,
    }

    struct RemoveLiquidity3Pool<phantom T0, phantom T1, phantom T2, phantom T3, phantom T4> has copy, drop {
        pool_id: address,
        amount_a: u64,
        amount_b: u64,
        amount_c: u64,
        shares: u64,
    }

    struct RemoveLiquidity4Pool<phantom T0, phantom T1, phantom T2, phantom T3, phantom T4, phantom T5> has copy, drop {
        pool_id: address,
        amount_a: u64,
        amount_b: u64,
        amount_c: u64,
        amount_d: u64,
        shares: u64,
    }

    struct RemoveLiquidity5Pool<phantom T0, phantom T1, phantom T2, phantom T3, phantom T4, phantom T5, phantom T6> has copy, drop {
        pool_id: address,
        amount_a: u64,
        amount_b: u64,
        amount_c: u64,
        amount_d: u64,
        amount_e: u64,
        shares: u64,
    }

    struct UpdateFee<phantom T0, phantom T1> has copy, drop {
        pool_id: address,
        fee_in_percent: u256,
        fee_out_percent: u256,
        admin_fee_percent: u256,
    }

    struct TakeFee<phantom T0, phantom T1, phantom T2> has copy, drop {
        pool_id: address,
        amount: u64,
    }

    struct RampA<phantom T0> has copy, drop {
        pool_id: address,
        initial_a: u256,
        future_a: u256,
        future_a_time: u256,
        timestamp: u64,
    }

    struct StopRampA<phantom T0> has copy, drop {
        pool_id: address,
        a: u256,
        timestamp: u64,
    }

    struct RampAGamma<phantom T0> has copy, drop {
        pool_id: address,
        a: u256,
        gamma: u256,
        initial_time: u64,
        future_a: u256,
        future_gamma: u256,
        future_time: u64,
    }

    struct StopRampAGamma<phantom T0> has copy, drop {
        pool_id: address,
        a: u256,
        gamma: u256,
        timestamp: u64,
    }

    struct UpdateParameters<phantom T0> has copy, drop {
        pool_id: address,
        admin_fee: u256,
        out_fee: u256,
        mid_fee: u256,
        gamma_fee: u256,
        allowed_extra_profit: u256,
        adjustment_step: u256,
        ma_half_time: u256,
    }

    struct ClaimAdminFees<phantom T0, phantom T1> has copy, drop {
        amount: u64,
    }

    public(friend) fun emit_add_liquidity_2_pool<T0, T1, T2, T3>(arg0: address, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = AddLiquidity2Pool<T0, T1, T2, T3>{
            pool_id  : arg0,
            amount_a : arg1,
            amount_b : arg2,
            shares   : arg3,
        };
        0x2::event::emit<AddLiquidity2Pool<T0, T1, T2, T3>>(v0);
    }

    public(friend) fun emit_add_liquidity_3_pool<T0, T1, T2, T3, T4>(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = AddLiquidity3Pool<T0, T1, T2, T3, T4>{
            pool_id  : arg0,
            amount_a : arg1,
            amount_b : arg2,
            amount_c : arg3,
            shares   : arg4,
        };
        0x2::event::emit<AddLiquidity3Pool<T0, T1, T2, T3, T4>>(v0);
    }

    public(friend) fun emit_add_liquidity_4_pool<T0, T1, T2, T3, T4, T5>(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = AddLiquidity4Pool<T0, T1, T2, T3, T4, T5>{
            pool_id  : arg0,
            amount_a : arg1,
            amount_b : arg2,
            amount_c : arg3,
            amount_d : arg4,
            shares   : arg5,
        };
        0x2::event::emit<AddLiquidity4Pool<T0, T1, T2, T3, T4, T5>>(v0);
    }

    public(friend) fun emit_add_liquidity_5_pool<T0, T1, T2, T3, T4, T5, T6>(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = AddLiquidity5Pool<T0, T1, T2, T3, T4, T5, T6>{
            pool_id  : arg0,
            amount_a : arg1,
            amount_b : arg2,
            amount_c : arg3,
            amount_d : arg4,
            amount_e : arg5,
            shares   : arg6,
        };
        0x2::event::emit<AddLiquidity5Pool<T0, T1, T2, T3, T4, T5, T6>>(v0);
    }

    public(friend) fun emit_claim_admin_fees<T0>(arg0: u64) {
        let v0 = ClaimAdminFees<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Volatile, T0>{amount: arg0};
        0x2::event::emit<ClaimAdminFees<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Volatile, T0>>(v0);
    }

    public(friend) fun emit_new_2_pool<T0, T1, T2, T3>(arg0: address) {
        let v0 = New2Pool<T0, T1, T2, T3>{pool_id: arg0};
        0x2::event::emit<New2Pool<T0, T1, T2, T3>>(v0);
    }

    public(friend) fun emit_new_3_pool<T0, T1, T2, T3, T4>(arg0: address) {
        let v0 = New3Pool<T0, T1, T2, T3, T4>{pool_id: arg0};
        0x2::event::emit<New3Pool<T0, T1, T2, T3, T4>>(v0);
    }

    public(friend) fun emit_new_4_pool<T0, T1, T2, T3, T4, T5>(arg0: address) {
        let v0 = New4Pool<T0, T1, T2, T3, T4, T5>{pool_id: arg0};
        0x2::event::emit<New4Pool<T0, T1, T2, T3, T4, T5>>(v0);
    }

    public(friend) fun emit_new_5_pool<T0, T1, T2, T3, T4, T5, T6>(arg0: address) {
        let v0 = New5Pool<T0, T1, T2, T3, T4, T5, T6>{pool_id: arg0};
        0x2::event::emit<New5Pool<T0, T1, T2, T3, T4, T5, T6>>(v0);
    }

    public(friend) fun emit_ramp_a<T0>(arg0: address, arg1: u256, arg2: u256, arg3: u256, arg4: u64) {
        let v0 = RampA<T0>{
            pool_id       : arg0,
            initial_a     : arg1,
            future_a      : arg2,
            future_a_time : arg3,
            timestamp     : arg4,
        };
        0x2::event::emit<RampA<T0>>(v0);
    }

    public(friend) fun emit_ramp_a_gamma<T0>(arg0: address, arg1: u256, arg2: u256, arg3: u64, arg4: u256, arg5: u256, arg6: u64) {
        let v0 = RampAGamma<T0>{
            pool_id      : arg0,
            a            : arg1,
            gamma        : arg2,
            initial_time : arg3,
            future_a     : arg4,
            future_gamma : arg5,
            future_time  : arg6,
        };
        0x2::event::emit<RampAGamma<T0>>(v0);
    }

    public(friend) fun emit_remove_liquidity<T0, T1, T2>(arg0: address, arg1: u64, arg2: u64) {
        let v0 = RemoveLiquidity<T0, T1, T2>{
            pool_id : arg0,
            amount  : arg1,
            shares  : arg2,
        };
        0x2::event::emit<RemoveLiquidity<T0, T1, T2>>(v0);
    }

    public(friend) fun emit_remove_liquidity_2_pool<T0, T1, T2, T3>(arg0: address, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = RemoveLiquidity2Pool<T0, T1, T2, T3>{
            pool_id  : arg0,
            amount_a : arg1,
            amount_b : arg2,
            shares   : arg3,
        };
        0x2::event::emit<RemoveLiquidity2Pool<T0, T1, T2, T3>>(v0);
    }

    public(friend) fun emit_remove_liquidity_3_pool<T0, T1, T2, T3, T4>(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = RemoveLiquidity3Pool<T0, T1, T2, T3, T4>{
            pool_id  : arg0,
            amount_a : arg1,
            amount_b : arg2,
            amount_c : arg3,
            shares   : arg4,
        };
        0x2::event::emit<RemoveLiquidity3Pool<T0, T1, T2, T3, T4>>(v0);
    }

    public(friend) fun emit_remove_liquidity_4_pool<T0, T1, T2, T3, T4, T5>(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = RemoveLiquidity4Pool<T0, T1, T2, T3, T4, T5>{
            pool_id  : arg0,
            amount_a : arg1,
            amount_b : arg2,
            amount_c : arg3,
            amount_d : arg4,
            shares   : arg5,
        };
        0x2::event::emit<RemoveLiquidity4Pool<T0, T1, T2, T3, T4, T5>>(v0);
    }

    public(friend) fun emit_remove_liquidity_5_pool<T0, T1, T2, T3, T4, T5, T6>(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = RemoveLiquidity5Pool<T0, T1, T2, T3, T4, T5, T6>{
            pool_id  : arg0,
            amount_a : arg1,
            amount_b : arg2,
            amount_c : arg3,
            amount_d : arg4,
            amount_e : arg5,
            shares   : arg6,
        };
        0x2::event::emit<RemoveLiquidity5Pool<T0, T1, T2, T3, T4, T5, T6>>(v0);
    }

    public(friend) fun emit_stop_ramp_a<T0>(arg0: address, arg1: u256, arg2: u64) {
        let v0 = StopRampA<T0>{
            pool_id   : arg0,
            a         : arg1,
            timestamp : arg2,
        };
        0x2::event::emit<StopRampA<T0>>(v0);
    }

    public(friend) fun emit_stop_ramp_a_gamma<T0>(arg0: address, arg1: u256, arg2: u256, arg3: u64) {
        let v0 = StopRampAGamma<T0>{
            pool_id   : arg0,
            a         : arg1,
            gamma     : arg2,
            timestamp : arg3,
        };
        0x2::event::emit<StopRampAGamma<T0>>(v0);
    }

    public(friend) fun emit_swap<T0, T1, T2, T3>(arg0: address, arg1: u64, arg2: u64) {
        let v0 = Swap<T0, T1, T2, T3>{
            pool_id    : arg0,
            amount_in  : arg1,
            amount_out : arg2,
        };
        0x2::event::emit<Swap<T0, T1, T2, T3>>(v0);
    }

    public(friend) fun emit_take_fees<T0, T1, T2>(arg0: address, arg1: u64) {
        let v0 = TakeFee<T0, T1, T2>{
            pool_id : arg0,
            amount  : arg1,
        };
        0x2::event::emit<TakeFee<T0, T1, T2>>(v0);
    }

    public(friend) fun emit_update_parameters<T0>(arg0: address, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256, arg7: u256) {
        let v0 = UpdateParameters<T0>{
            pool_id              : arg0,
            admin_fee            : arg1,
            out_fee              : arg2,
            mid_fee              : arg3,
            gamma_fee            : arg4,
            allowed_extra_profit : arg5,
            adjustment_step      : arg6,
            ma_half_time         : arg7,
        };
        0x2::event::emit<UpdateParameters<T0>>(v0);
    }

    public(friend) fun emit_update_stable_fee<T0, T1>(arg0: address, arg1: u256, arg2: u256, arg3: u256) {
        let v0 = UpdateFee<T0, T1>{
            pool_id           : arg0,
            fee_in_percent    : arg1,
            fee_out_percent   : arg2,
            admin_fee_percent : arg3,
        };
        0x2::event::emit<UpdateFee<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

