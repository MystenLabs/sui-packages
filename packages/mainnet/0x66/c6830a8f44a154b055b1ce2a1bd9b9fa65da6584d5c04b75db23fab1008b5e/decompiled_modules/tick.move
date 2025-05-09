module 0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::tick {
    struct TickManager has store {
        tick_spacing: u32,
        ticks: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::SkipList<Tick>,
    }

    struct Tick has copy, drop, store {
        index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        sqrt_price: u128,
        liquidity_net: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128,
        liquidity_gross: u128,
        fee_growth_outside_a: u128,
        fee_growth_outside_b: u128,
        points_growth_outside: u128,
        rewards_growth_outside: vector<u128>,
    }

    public fun borrow_tick(arg0: &TickManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : &Tick {
        abort 0
    }

    public fun borrow_tick_for_swap(arg0: &TickManager, arg1: u64, arg2: bool) : (&Tick, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64) {
        abort 0
    }

    public fun fee_growth_outside(arg0: &Tick) : (u128, u128) {
        abort 0
    }

    public fun fetch_ticks(arg0: &TickManager, arg1: vector<u32>, arg2: u64) : vector<Tick> {
        abort 0
    }

    public fun first_score_for_swap(arg0: &TickManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: bool) : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64 {
        abort 0
    }

    public fun get_fee_in_range(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u128, arg2: u128, arg3: 0x1::option::Option<Tick>, arg4: 0x1::option::Option<Tick>) : (u128, u128) {
        abort 0
    }

    public fun get_points_in_range(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u128, arg2: 0x1::option::Option<Tick>, arg3: 0x1::option::Option<Tick>) : u128 {
        abort 0
    }

    public fun get_reward_growth_outside(arg0: &Tick, arg1: u64) : u128 {
        abort 0
    }

    public fun get_rewards_in_range(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: vector<u128>, arg2: 0x1::option::Option<Tick>, arg3: 0x1::option::Option<Tick>) : vector<u128> {
        abort 0
    }

    public fun index(arg0: &Tick) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        abort 0
    }

    public fun liquidity_gross(arg0: &Tick) : u128 {
        abort 0
    }

    public fun liquidity_net(arg0: &Tick) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128 {
        abort 0
    }

    public(friend) fun new(arg0: u32, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : TickManager {
        abort 0
    }

    public fun points_growth_outside(arg0: &Tick) : u128 {
        abort 0
    }

    public fun rewards_growth_outside(arg0: &Tick) : &vector<u128> {
        abort 0
    }

    public fun sqrt_price(arg0: &Tick) : u128 {
        abort 0
    }

    fun tick_score(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u64 {
        abort 0
    }

    public fun tick_spacing(arg0: &TickManager) : u32 {
        abort 0
    }

    // decompiled from Move bytecode v6
}

