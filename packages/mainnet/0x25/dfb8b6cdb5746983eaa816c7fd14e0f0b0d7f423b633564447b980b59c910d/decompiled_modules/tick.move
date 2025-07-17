module 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::tick {
    struct TickManager has store {
        tick_spacing: u32,
        ticks: 0x2::table::Table<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, TickInfo>,
        bitmap: 0x2::table::Table<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>,
    }

    struct TickInfo has copy, drop, store {
        index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        sqrt_price: u128,
        liquidity_gross: u128,
        liquidity_net: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128,
        fee_growth_outside_a: u128,
        fee_growth_outside_b: u128,
        tick_cumulative_out_side: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64,
        seconds_per_liquidity_out_side: u256,
        seconds_out_side: u64,
        reward_growths_outside: vector<u128>,
    }

    public fun bitmap(arg0: &TickManager) : &0x2::table::Table<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256> {
        abort 0
    }

    fun compute_reward_growths(arg0: vector<u128>, arg1: vector<u128>) : vector<u128> {
        abort 0
    }

    public fun create_tick(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : TickInfo {
        abort 0
    }

    public(friend) fun cross(arg0: &mut TickManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u128, arg3: u128, arg4: vector<u128>, arg5: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64, arg6: u256, arg7: u64) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128 {
        abort 0
    }

    public fun fetch_provided_ticks(arg0: &TickManager, arg1: vector<u32>) : vector<TickInfo> {
        abort 0
    }

    public fun get_fee_and_reward_growths_inside(arg0: &TickManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: u128, arg5: u128, arg6: vector<u128>) : (u128, u128, vector<u128>) {
        abort 0
    }

    public fun get_fee_and_reward_growths_outside(arg0: &TickManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : (u128, u128, vector<u128>) {
        abort 0
    }

    public(friend) fun get_mutable_tick_from_manager(arg0: &mut TickManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : &mut TickInfo {
        abort 0
    }

    public(friend) fun get_mutable_tick_from_table(arg0: &mut 0x2::table::Table<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, TickInfo>, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : &mut TickInfo {
        abort 0
    }

    public fun get_tick_from_manager(arg0: &TickManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : &TickInfo {
        abort 0
    }

    public fun get_tick_from_table(arg0: &0x2::table::Table<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, TickInfo>, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : &TickInfo {
        abort 0
    }

    public(friend) fun initialize_manager(arg0: u32, arg1: &mut 0x2::tx_context::TxContext) : TickManager {
        abort 0
    }

    public fun is_tick_initialized(arg0: &TickManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : bool {
        abort 0
    }

    public fun liquidity_gross(arg0: &TickInfo) : u128 {
        abort 0
    }

    public fun liquidity_net(arg0: &TickInfo) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128 {
        abort 0
    }

    public(friend) fun mutable_bitmap(arg0: &mut TickManager) : &mut 0x2::table::Table<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256> {
        abort 0
    }

    public(friend) fun remove(arg0: &mut TickManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        abort 0
    }

    public fun sqrt_price(arg0: &TickInfo) : u128 {
        abort 0
    }

    public fun tick_spacing(arg0: &TickManager) : u32 {
        abort 0
    }

    public(friend) fun update(arg0: &mut TickManager, arg1: 0x2::object::ID, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128, arg5: u128, arg6: u128, arg7: vector<u128>, arg8: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64, arg9: u256, arg10: u64, arg11: bool) : bool {
        abort 0
    }

    // decompiled from Move bytecode v6
}

