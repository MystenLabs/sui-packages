module 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::pool {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
        fee_rate: u64,
        protocol_fee_share: u64,
        fee_growth_global_coin_a: u128,
        fee_growth_global_coin_b: u128,
        protocol_fee_coin_a: u64,
        protocol_fee_coin_b: u64,
        ticks_manager: 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::tick::TickManager,
        observations_manager: 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::oracle::ObservationManager,
        current_sqrt_price: u128,
        current_tick_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        liquidity: u128,
        reward_infos: vector<PoolRewardInfo>,
        is_paused: bool,
        icon_url: 0x1::string::String,
        position_index: u128,
        sequence_number: u128,
    }

    struct PoolRewardInfo has copy, drop, store {
        reward_coin_symbol: 0x1::string::String,
        reward_coin_decimals: u8,
        reward_coin_type: 0x1::string::String,
        last_update_time: u64,
        ended_at_seconds: u64,
        total_reward: u64,
        total_reward_allocated: u64,
        reward_per_seconds: u128,
        reward_growth_global: u128,
    }

    struct SwapResult has copy, drop {
        a2b: bool,
        by_amount_in: bool,
        amount_specified: u64,
        amount_specified_remaining: u64,
        amount_calculated: u64,
        fee_growth_global: u128,
        fee_amount: u64,
        protocol_fee: u64,
        start_sqrt_price: u128,
        end_sqrt_price: u128,
        current_tick_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        is_exceed: bool,
        starting_liquidity: u128,
        liquidity: u128,
        steps: u64,
        step_results: vector<SwapStepResult>,
    }

    struct SwapStepResult has copy, drop, store {
        tick_index_next: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        initialized: bool,
        sqrt_price_start: u128,
        sqrt_price_next: u128,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        remaining_amount: u64,
    }

    struct FlashSwapReceipt<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        a2b: bool,
        pay_amount: u64,
    }

    public fun swap<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: &mut Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u128) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        abort 0
    }

    public fun add_liquidity<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: &mut Pool<T0, T1>, arg3: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::position::Position, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: u128) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        abort 0
    }

    public fun add_liquidity_with_fixed_amount<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: &mut Pool<T0, T1>, arg3: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::position::Position, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: u64, arg7: bool) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        abort 0
    }

    public(friend) fun add_reward_info<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: PoolRewardInfo) {
        abort 0
    }

    public fun calculate_swap_results<T0, T1>(arg0: &Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u128) : SwapResult {
        abort 0
    }

    fun charge_pool_creation_fee<T0>(arg0: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::tx_context::TxContext) {
        abort 0
    }

    public fun close_position<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: &mut Pool<T0, T1>, arg3: 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::position::Position) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        abort 0
    }

    public fun close_position_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: &mut Pool<T0, T1>, arg3: 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::position::Position) {
        abort 0
    }

    public fun coin_reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        abort 0
    }

    public fun collect_fee<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: &mut Pool<T0, T1>, arg3: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::position::Position) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        abort 0
    }

    public fun collect_reward<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: &mut Pool<T0, T1>, arg3: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::position::Position) : 0x2::balance::Balance<T2> {
        abort 0
    }

    public fun create_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: vector<u8>, arg7: vector<u8>, arg8: u8, arg9: vector<u8>, arg10: u32, arg11: u64, arg12: u128, arg13: 0x2::balance::Balance<T2>, arg14: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        abort 0
    }

    fun create_pool_internal<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: vector<u8>, arg7: vector<u8>, arg8: u8, arg9: vector<u8>, arg10: u32, arg11: u64, arg12: u128, arg13: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        abort 0
    }

    public fun create_pool_with_liquidity<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: vector<u8>, arg7: vector<u8>, arg8: u8, arg9: vector<u8>, arg10: u32, arg11: u64, arg12: u128, arg13: 0x2::balance::Balance<T2>, arg14: u32, arg15: u32, arg16: 0x2::balance::Balance<T0>, arg17: 0x2::balance::Balance<T1>, arg18: u64, arg19: bool, arg20: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::position::Position, u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        abort 0
    }

    public fun current_sqrt_price<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        abort 0
    }

    public fun current_tick_index<T0, T1>(arg0: &Pool<T0, T1>) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        abort 0
    }

    public fun default_reward_info(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u8, arg3: u64) : PoolRewardInfo {
        abort 0
    }

    public fun fetch_provided_ticks<T0, T1>(arg0: &Pool<T0, T1>, arg1: vector<u32>) : vector<0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::tick::TickInfo> {
        abort 0
    }

    fun find_reward_info_index<T0, T1, T2>(arg0: &Pool<T0, T1>) : u64 {
        abort 0
    }

    public fun flash_swap<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: &mut Pool<T0, T1>, arg3: bool, arg4: bool, arg5: u64, arg6: u128) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        abort 0
    }

    fun get_accrued_fee<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Pool<T0, T1>, arg2: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::position::Position) : (u64, u64) {
        abort 0
    }

    fun get_accrued_rewards<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut Pool<T0, T1>, arg2: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::position::Position) : (u64, PoolRewardInfo) {
        abort 0
    }

    public fun get_amount_by_liquidity(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u128, arg4: u128, arg5: bool) : (u64, u64) {
        abort 0
    }

    public fun get_fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        abort 0
    }

    public fun get_liquidity_by_amount(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u128, arg4: u64, arg5: bool) : (u128, u64, u64) {
        abort 0
    }

    public fun get_pool_manager<T0, T1>(arg0: &Pool<T0, T1>) : address {
        abort 0
    }

    public fun get_protocol_fee_for_coin_a<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        abort 0
    }

    public fun get_protocol_fee_for_coin_b<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        abort 0
    }

    public fun get_swap_result_a2b(arg0: &SwapResult) : bool {
        abort 0
    }

    public fun get_swap_result_amount_calculated(arg0: &SwapResult) : u64 {
        abort 0
    }

    public fun get_swap_result_amount_specified(arg0: &SwapResult) : u64 {
        abort 0
    }

    public fun get_swap_result_amount_specified_remaining(arg0: &SwapResult) : u64 {
        abort 0
    }

    public fun get_swap_result_by_amount_in(arg0: &SwapResult) : bool {
        abort 0
    }

    public fun get_swap_result_current_tick_index(arg0: &SwapResult) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        abort 0
    }

    public fun get_swap_result_end_sqrt_price(arg0: &SwapResult) : u128 {
        abort 0
    }

    public fun get_swap_result_fee_amount(arg0: &SwapResult) : u64 {
        abort 0
    }

    public fun get_swap_result_fee_growth_global(arg0: &SwapResult) : u128 {
        abort 0
    }

    public fun get_swap_result_is_exceed(arg0: &SwapResult) : bool {
        abort 0
    }

    public fun get_swap_result_liquidity(arg0: &SwapResult) : u128 {
        abort 0
    }

    public fun get_swap_result_protocol_fee(arg0: &SwapResult) : u64 {
        abort 0
    }

    public fun get_swap_result_start_sqrt_price(arg0: &SwapResult) : u128 {
        abort 0
    }

    public fun get_swap_result_starting_liquidity(arg0: &SwapResult) : u128 {
        abort 0
    }

    public fun get_swap_result_steps(arg0: &SwapResult) : u64 {
        abort 0
    }

    public fun get_tick_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::tick::TickManager {
        abort 0
    }

    public fun get_tick_spacing<T0, T1>(arg0: &Pool<T0, T1>) : u32 {
        abort 0
    }

    public(friend) fun increase_observation_cardinality_next<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        abort 0
    }

    public(friend) fun increase_reward_coin_reserves<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T2>) {
        abort 0
    }

    public(friend) fun increase_sequence_number<T0, T1>(arg0: &mut Pool<T0, T1>) : u128 {
        abort 0
    }

    fun is_flash_swap_in_progress(arg0: &0x2::object::UID) : bool {
        abort 0
    }

    public fun is_reward_present<T0, T1, T2>(arg0: &Pool<T0, T1>) : bool {
        abort 0
    }

    public fun liquidity<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        abort 0
    }

    public fun new<T0, T1>(arg0: &0x2::clock::Clock, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: vector<u8>, arg6: vector<u8>, arg7: u8, arg8: vector<u8>, arg9: u32, arg10: u64, arg11: u128, arg12: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun open_position<T0, T1>(arg0: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: u32, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) : 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::position::Position {
        abort 0
    }

    public fun protocol_fee_share<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        abort 0
    }

    public fun remove_liquidity<T0, T1>(arg0: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::position::Position, arg3: u128, arg4: &0x2::clock::Clock) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        abort 0
    }

    public fun repay_flash_swap<T0, T1>(arg0: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: FlashSwapReceipt<T0, T1>) {
        abort 0
    }

    public fun reward_infos_length<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        abort 0
    }

    public fun sequence_number<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        abort 0
    }

    public fun set_manager<T0, T1>(arg0: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public(friend) fun set_protocol_fee_amount<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64) {
        abort 0
    }

    public(friend) fun set_protocol_fee_share<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        abort 0
    }

    fun swap_in_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Pool<T0, T1>, arg2: bool, arg3: bool, arg4: u64, arg5: u128) : SwapResult {
        abort 0
    }

    public fun swap_pay_amount<T0, T1>(arg0: &FlashSwapReceipt<T0, T1>) : u64 {
        abort 0
    }

    fun update_data_for_delta_l<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Pool<T0, T1>, arg2: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::position::Position, arg3: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::I128) : (u64, u64) {
        abort 0
    }

    public(friend) fun update_pause_status<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool) {
        abort 0
    }

    public(friend) fun update_pool_reward_emission<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T2>, arg2: u64) {
        abort 0
    }

    fun update_pool_state<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: SwapResult, arg2: u64) {
        abort 0
    }

    public(friend) fun update_reward_infos<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) : vector<u128> {
        abort 0
    }

    public fun verify_pool_manager<T0, T1>(arg0: &Pool<T0, T1>, arg1: address) : bool {
        abort 0
    }

    public(friend) fun withdraw_balances<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

