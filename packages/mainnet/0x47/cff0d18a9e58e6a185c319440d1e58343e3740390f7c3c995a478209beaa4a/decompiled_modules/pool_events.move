module 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::pool_events {
    struct NewPool has copy, drop {
        pool: address,
        coins: vector<0x1::type_name::TypeName>,
        lpCoin: 0x1::type_name::TypeName,
        isStable: bool,
    }

    struct Swap has copy, drop {
        pool: address,
        coinIn: 0x1::type_name::TypeName,
        coinOut: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
    }

    struct AddLiquidity has copy, drop {
        pool: address,
        coins: vector<0x1::type_name::TypeName>,
        amounts: vector<u64>,
        shares: u64,
    }

    struct RemoveLiquidity has copy, drop {
        pool: address,
        coins: vector<0x1::type_name::TypeName>,
        amounts: vector<u64>,
        shares: u64,
    }

    struct UpdateFee has copy, drop {
        pool: address,
        fee_in_percent: u256,
        fee_out_percent: u256,
        admin_fee_percent: u256,
    }

    struct TakeFee has copy, drop {
        pool: address,
        coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct RampA has copy, drop {
        pool: address,
        initial_a: u256,
        future_a: u256,
        future_a_time: u256,
        timestamp: u64,
    }

    struct StopRampA has copy, drop {
        pool: address,
        a: u256,
        timestamp: u64,
    }

    struct RampAGamma has copy, drop {
        pool: address,
        a: u256,
        gamma: u256,
        initial_time: u64,
        future_a: u256,
        future_gamma: u256,
        future_time: u64,
    }

    struct StopRampAGamma has copy, drop {
        pool: address,
        a: u256,
        gamma: u256,
        timestamp: u64,
    }

    struct UpdateParameters has copy, drop {
        pool: address,
        admin_fee: u256,
        out_fee: u256,
        mid_fee: u256,
        gamma_fee: u256,
        allowed_extra_profit: u256,
        adjustment_step: u256,
        ma_half_time: u256,
    }

    struct ClaimAdminFees has copy, drop {
        pool: address,
        coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Donate has copy, drop {
        pool: address,
        coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    public(friend) fun swap(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64) {
        let v0 = Swap{
            pool       : arg0,
            coinIn     : arg1,
            coinOut    : arg2,
            amount_in  : arg3,
            amount_out : arg4,
        };
        0x2::event::emit<Swap>(v0);
    }

    public(friend) fun add_liquidity(arg0: address, arg1: vector<0x1::type_name::TypeName>, arg2: vector<u64>, arg3: u64) {
        let v0 = AddLiquidity{
            pool    : arg0,
            coins   : arg1,
            amounts : arg2,
            shares  : arg3,
        };
        0x2::event::emit<AddLiquidity>(v0);
    }

    public(friend) fun claim_admin_fees(arg0: address, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = ClaimAdminFees{
            pool   : arg0,
            coin   : arg1,
            amount : arg2,
        };
        0x2::event::emit<ClaimAdminFees>(v0);
    }

    public(friend) fun donate(arg0: address, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = Donate{
            pool   : arg0,
            coin   : arg1,
            amount : arg2,
        };
        0x2::event::emit<Donate>(v0);
    }

    public(friend) fun new_pool(arg0: address, arg1: vector<0x1::type_name::TypeName>, arg2: 0x1::type_name::TypeName, arg3: bool) {
        let v0 = NewPool{
            pool     : arg0,
            coins    : arg1,
            lpCoin   : arg2,
            isStable : arg3,
        };
        0x2::event::emit<NewPool>(v0);
    }

    public(friend) fun ramp_a(arg0: address, arg1: u256, arg2: u256, arg3: u256, arg4: u64) {
        let v0 = RampA{
            pool          : arg0,
            initial_a     : arg1,
            future_a      : arg2,
            future_a_time : arg3,
            timestamp     : arg4,
        };
        0x2::event::emit<RampA>(v0);
    }

    public(friend) fun ramp_a_gamma(arg0: address, arg1: u256, arg2: u256, arg3: u64, arg4: u256, arg5: u256, arg6: u64) {
        let v0 = RampAGamma{
            pool         : arg0,
            a            : arg1,
            gamma        : arg2,
            initial_time : arg3,
            future_a     : arg4,
            future_gamma : arg5,
            future_time  : arg6,
        };
        0x2::event::emit<RampAGamma>(v0);
    }

    public(friend) fun remove_liquidity(arg0: address, arg1: vector<0x1::type_name::TypeName>, arg2: vector<u64>, arg3: u64) {
        let v0 = RemoveLiquidity{
            pool    : arg0,
            coins   : arg1,
            amounts : arg2,
            shares  : arg3,
        };
        0x2::event::emit<RemoveLiquidity>(v0);
    }

    public(friend) fun stop_ramp_a(arg0: address, arg1: u256, arg2: u64) {
        let v0 = StopRampA{
            pool      : arg0,
            a         : arg1,
            timestamp : arg2,
        };
        0x2::event::emit<StopRampA>(v0);
    }

    public(friend) fun stop_ramp_a_gamma(arg0: address, arg1: u256, arg2: u256, arg3: u64) {
        let v0 = StopRampAGamma{
            pool      : arg0,
            a         : arg1,
            gamma     : arg2,
            timestamp : arg3,
        };
        0x2::event::emit<StopRampAGamma>(v0);
    }

    public(friend) fun take_fees(arg0: address, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = TakeFee{
            pool   : arg0,
            coin   : arg1,
            amount : arg2,
        };
        0x2::event::emit<TakeFee>(v0);
    }

    public(friend) fun update_parameters(arg0: address, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256, arg7: u256) {
        let v0 = UpdateParameters{
            pool                 : arg0,
            admin_fee            : arg1,
            out_fee              : arg2,
            mid_fee              : arg3,
            gamma_fee            : arg4,
            allowed_extra_profit : arg5,
            adjustment_step      : arg6,
            ma_half_time         : arg7,
        };
        0x2::event::emit<UpdateParameters>(v0);
    }

    public(friend) fun update_stable_fee(arg0: address, arg1: u256, arg2: u256, arg3: u256) {
        let v0 = UpdateFee{
            pool              : arg0,
            fee_in_percent    : arg1,
            fee_out_percent   : arg2,
            admin_fee_percent : arg3,
        };
        0x2::event::emit<UpdateFee>(v0);
    }

    // decompiled from Move bytecode v6
}

