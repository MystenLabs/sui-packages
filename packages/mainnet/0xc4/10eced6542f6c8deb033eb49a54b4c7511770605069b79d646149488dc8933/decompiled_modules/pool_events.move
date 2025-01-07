module 0xc410eced6542f6c8deb033eb49a54b4c7511770605069b79d646149488dc8933::pool_events {
    struct NewPool<phantom T0, phantom T1> has copy, drop {
        pool: address,
        coins: vector<0x1::type_name::TypeName>,
    }

    struct AddLiquidity<phantom T0, phantom T1> has copy, drop {
        pool: address,
        coins: vector<0x1::type_name::TypeName>,
        amounts: vector<u64>,
        shares: u64,
    }

    struct Swap<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop {
        pool: address,
        amount_in: u64,
        amount_out: u64,
    }

    struct RemoveLiquidity<phantom T0, phantom T1> has copy, drop {
        pool: address,
        coins: vector<0x1::type_name::TypeName>,
        amounts: vector<u64>,
        shares: u64,
    }

    struct UpdateFee<phantom T0, phantom T1> has copy, drop {
        pool: address,
        fee_in_percent: u256,
        fee_out_percent: u256,
        admin_fee_percent: u256,
    }

    struct TakeFee<phantom T0, phantom T1, phantom T2> has copy, drop {
        pool: address,
        amount: u64,
    }

    struct RampA<phantom T0> has copy, drop {
        pool: address,
        initial_a: u256,
        future_a: u256,
        future_a_time: u256,
        timestamp: u64,
    }

    struct StopRampA<phantom T0> has copy, drop {
        pool: address,
        a: u256,
        timestamp: u64,
    }

    struct RampAGamma<phantom T0> has copy, drop {
        pool: address,
        a: u256,
        gamma: u256,
        initial_time: u64,
        future_a: u256,
        future_gamma: u256,
        future_time: u64,
    }

    struct StopRampAGamma<phantom T0> has copy, drop {
        pool: address,
        a: u256,
        gamma: u256,
        timestamp: u64,
    }

    struct UpdateParameters<phantom T0> has copy, drop {
        pool: address,
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

    struct Donate<phantom T0, phantom T1, phantom T2> has copy, drop {
        pool: address,
        amount: u64,
    }

    public(friend) fun swap<T0, T1, T2, T3>(arg0: address, arg1: u64, arg2: u64) {
        let v0 = Swap<T0, T1, T2, T3>{
            pool       : arg0,
            amount_in  : arg1,
            amount_out : arg2,
        };
        0x2::event::emit<Swap<T0, T1, T2, T3>>(v0);
    }

    public(friend) fun add_liquidity<T0, T1>(arg0: address, arg1: vector<0x1::type_name::TypeName>, arg2: vector<u64>, arg3: u64) {
        let v0 = AddLiquidity<T0, T1>{
            pool    : arg0,
            coins   : arg1,
            amounts : arg2,
            shares  : arg3,
        };
        0x2::event::emit<AddLiquidity<T0, T1>>(v0);
    }

    public(friend) fun claim_admin_fees<T0>(arg0: u64) {
        let v0 = ClaimAdminFees<0xc410eced6542f6c8deb033eb49a54b4c7511770605069b79d646149488dc8933::curves::Volatile, T0>{amount: arg0};
        0x2::event::emit<ClaimAdminFees<0xc410eced6542f6c8deb033eb49a54b4c7511770605069b79d646149488dc8933::curves::Volatile, T0>>(v0);
    }

    public(friend) fun donate<T0, T1, T2>(arg0: address, arg1: u64) {
        let v0 = Donate<T0, T1, T2>{
            pool   : arg0,
            amount : arg1,
        };
        0x2::event::emit<Donate<T0, T1, T2>>(v0);
    }

    public(friend) fun new_pool<T0, T1>(arg0: address, arg1: vector<0x1::type_name::TypeName>) {
        let v0 = NewPool<T0, T1>{
            pool  : arg0,
            coins : arg1,
        };
        0x2::event::emit<NewPool<T0, T1>>(v0);
    }

    public(friend) fun ramp_a<T0>(arg0: address, arg1: u256, arg2: u256, arg3: u256, arg4: u64) {
        let v0 = RampA<T0>{
            pool          : arg0,
            initial_a     : arg1,
            future_a      : arg2,
            future_a_time : arg3,
            timestamp     : arg4,
        };
        0x2::event::emit<RampA<T0>>(v0);
    }

    public(friend) fun ramp_a_gamma<T0>(arg0: address, arg1: u256, arg2: u256, arg3: u64, arg4: u256, arg5: u256, arg6: u64) {
        let v0 = RampAGamma<T0>{
            pool         : arg0,
            a            : arg1,
            gamma        : arg2,
            initial_time : arg3,
            future_a     : arg4,
            future_gamma : arg5,
            future_time  : arg6,
        };
        0x2::event::emit<RampAGamma<T0>>(v0);
    }

    public(friend) fun remove_liquidity<T0, T1>(arg0: address, arg1: vector<0x1::type_name::TypeName>, arg2: vector<u64>, arg3: u64) {
        let v0 = RemoveLiquidity<T0, T1>{
            pool    : arg0,
            coins   : arg1,
            amounts : arg2,
            shares  : arg3,
        };
        0x2::event::emit<RemoveLiquidity<T0, T1>>(v0);
    }

    public(friend) fun stop_ramp_a<T0>(arg0: address, arg1: u256, arg2: u64) {
        let v0 = StopRampA<T0>{
            pool      : arg0,
            a         : arg1,
            timestamp : arg2,
        };
        0x2::event::emit<StopRampA<T0>>(v0);
    }

    public(friend) fun stop_ramp_a_gamma<T0>(arg0: address, arg1: u256, arg2: u256, arg3: u64) {
        let v0 = StopRampAGamma<T0>{
            pool      : arg0,
            a         : arg1,
            gamma     : arg2,
            timestamp : arg3,
        };
        0x2::event::emit<StopRampAGamma<T0>>(v0);
    }

    public(friend) fun take_fees<T0, T1, T2>(arg0: address, arg1: u64) {
        let v0 = TakeFee<T0, T1, T2>{
            pool   : arg0,
            amount : arg1,
        };
        0x2::event::emit<TakeFee<T0, T1, T2>>(v0);
    }

    public(friend) fun update_parameters<T0>(arg0: address, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256, arg7: u256) {
        let v0 = UpdateParameters<T0>{
            pool                 : arg0,
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

    public(friend) fun update_stable_fee<T0, T1>(arg0: address, arg1: u256, arg2: u256, arg3: u256) {
        let v0 = UpdateFee<T0, T1>{
            pool              : arg0,
            fee_in_percent    : arg1,
            fee_out_percent   : arg2,
            admin_fee_percent : arg3,
        };
        0x2::event::emit<UpdateFee<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

