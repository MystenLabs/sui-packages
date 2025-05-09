module 0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::pool {
    struct POOL has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
        tick_spacing: u32,
        fee_rate: u64,
        liquidity: u128,
        current_sqrt_price: u128,
        current_tick_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        fee_growth_global_a: u128,
        fee_growth_global_b: u128,
        fee_protocol_coin_a: u64,
        fee_protocol_coin_b: u64,
        tick_manager: 0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::tick::TickManager,
        rewarder_manager: 0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::rewarder::RewarderManager,
        position_manager: 0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::position::PositionManager,
        is_pause: bool,
        index: u64,
        url: 0x1::string::String,
    }

    struct SwapResult has copy, drop {
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        ref_fee_amount: u64,
        steps: u64,
    }

    struct FlashSwapReceipt<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        a2b: bool,
        partner_id: 0x2::object::ID,
        pay_amount: u64,
        ref_fee_amount: u64,
    }

    struct FlashLoanReceipt {
        pool_id: 0x2::object::ID,
        loan_a: bool,
        partner_id: 0x2::object::ID,
        amount: u64,
        fee_amount: u64,
        ref_fee_amount: u64,
    }

    struct AddLiquidityReceipt<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct CalculatedSwapResult has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        fee_rate: u64,
        after_sqrt_price: u128,
        is_exceed: bool,
        step_results: vector<SwapStepResult>,
    }

    struct SwapStepResult has copy, drop, store {
        current_sqrt_price: u128,
        target_sqrt_price: u128,
        current_liquidity: u128,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        remainder_amount: u64,
    }

    struct OpenPositionEvent has copy, drop, store {
        pool: 0x2::object::ID,
        tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        position: 0x2::object::ID,
    }

    struct ClosePositionEvent has copy, drop, store {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
    }

    struct AddLiquidityEvent has copy, drop, store {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        liquidity: u128,
        after_liquidity: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct RemoveLiquidityEvent has copy, drop, store {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        liquidity: u128,
        after_liquidity: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct SwapEvent has copy, drop, store {
        atob: bool,
        pool: 0x2::object::ID,
        partner: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        ref_amount: u64,
        fee_amount: u64,
        vault_a_amount: u64,
        vault_b_amount: u64,
        before_sqrt_price: u128,
        after_sqrt_price: u128,
        steps: u64,
    }

    struct CollectProtocolFeeEvent has copy, drop, store {
        pool: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct CollectFeeEvent has copy, drop, store {
        position: 0x2::object::ID,
        pool: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct UpdateFeeRateEvent has copy, drop, store {
        pool: 0x2::object::ID,
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    struct UpdateEmissionEvent has copy, drop, store {
        pool: 0x2::object::ID,
        rewarder_type: 0x1::type_name::TypeName,
        emissions_per_second: u128,
    }

    struct AddRewarderEvent has copy, drop, store {
        pool: 0x2::object::ID,
        rewarder_type: 0x1::type_name::TypeName,
    }

    struct CollectRewardEvent has copy, drop, store {
        position: 0x2::object::ID,
        pool: 0x2::object::ID,
        amount: u64,
    }

    struct CollectRewardV2Event has copy, drop, store {
        position: 0x2::object::ID,
        pool: 0x2::object::ID,
        rewarder_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct FlashLoanEvent has copy, drop, store {
        pool: 0x2::object::ID,
        loan_a: bool,
        partner: 0x2::object::ID,
        amount: u64,
        fee_amount: u64,
        ref_amount: u64,
        vault_a_amount: u64,
        vault_b_amount: u64,
    }

    public fun add_liquidity<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::position::Position, arg3: u128, arg4: &0x2::clock::Clock) : AddLiquidityReceipt<T0, T1> {
        abort 0
    }

    public fun add_liquidity_fix_coin<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::position::Position, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : AddLiquidityReceipt<T0, T1> {
        abort 0
    }

    public fun add_liquidity_pay_amount<T0, T1>(arg0: &AddLiquidityReceipt<T0, T1>) : (u64, u64) {
        abort 0
    }

    public fun balances<T0, T1>(arg0: &Pool<T0, T1>) : (&0x2::balance::Balance<T0>, &0x2::balance::Balance<T1>) {
        abort 0
    }

    public fun borrow_position_info<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::position::PositionInfo {
        abort 0
    }

    public fun borrow_tick<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::tick::Tick {
        abort 0
    }

    public fun calculate_and_update_fee<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::object::ID) : (u64, u64) {
        abort 0
    }

    public fun calculate_and_update_points<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u128 {
        abort 0
    }

    public fun calculate_and_update_reward<T0, T1, T2>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u64 {
        abort 0
    }

    public fun calculate_and_update_rewards<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : vector<u64> {
        abort 0
    }

    public fun calculate_swap_result<T0, T1>(arg0: &Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64) : CalculatedSwapResult {
        abort 0
    }

    public fun calculate_swap_result_step_results(arg0: &CalculatedSwapResult) : &vector<SwapStepResult> {
        abort 0
    }

    public fun calculated_swap_result_after_sqrt_price(arg0: &CalculatedSwapResult) : u128 {
        abort 0
    }

    public fun calculated_swap_result_amount_in(arg0: &CalculatedSwapResult) : u64 {
        abort 0
    }

    public fun calculated_swap_result_amount_out(arg0: &CalculatedSwapResult) : u64 {
        abort 0
    }

    public fun calculated_swap_result_fee_amount(arg0: &CalculatedSwapResult) : u64 {
        abort 0
    }

    public fun calculated_swap_result_is_exceed(arg0: &CalculatedSwapResult) : bool {
        abort 0
    }

    public fun calculated_swap_result_step_swap_result(arg0: &CalculatedSwapResult, arg1: u64) : &SwapStepResult {
        abort 0
    }

    public fun calculated_swap_result_steps_length(arg0: &CalculatedSwapResult) : u64 {
        abort 0
    }

    public fun close_position<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::position::Position) {
        abort 0
    }

    public fun collect_fee<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::position::Position, arg3: bool) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        abort 0
    }

    public fun collect_protocol_fee<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        abort 0
    }

    public fun collect_reward<T0, T1, T2>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::position::Position, arg3: &mut 0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::rewarder::RewarderGlobalVault, arg4: bool, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        abort 0
    }

    public fun current_sqrt_price<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        abort 0
    }

    public fun current_tick_index<T0, T1>(arg0: &Pool<T0, T1>) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        abort 0
    }

    public fun fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        abort 0
    }

    public fun fees_growth_global<T0, T1>(arg0: &Pool<T0, T1>) : (u128, u128) {
        abort 0
    }

    public fun fetch_positions<T0, T1>(arg0: &Pool<T0, T1>, arg1: vector<0x2::object::ID>, arg2: u64) : vector<0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::position::PositionInfo> {
        abort 0
    }

    public fun fetch_ticks<T0, T1>(arg0: &Pool<T0, T1>, arg1: vector<u32>, arg2: u64) : vector<0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::tick::Tick> {
        abort 0
    }

    public fun flash_loan<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: bool, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashLoanReceipt) {
        abort 0
    }

    public fun flash_loan_with_partner<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::partner::Partner, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashLoanReceipt) {
        abort 0
    }

    public fun flash_swap<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: bool, arg3: bool, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        abort 0
    }

    public fun flash_swap_with_partner<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::partner::Partner, arg3: bool, arg4: bool, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        abort 0
    }

    public fun get_amount_by_liquidity(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u128, arg4: u128, arg5: bool) : (u64, u64) {
        abort 0
    }

    public fun get_fee_in_tick_range<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : (u128, u128) {
        abort 0
    }

    public fun get_fee_rewards_points_in_tick_range<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : (u128, u128, vector<u128>, u128) {
        abort 0
    }

    public fun get_liquidity_from_amount(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u128, arg4: u64, arg5: bool) : (u128, u64, u64) {
        abort 0
    }

    public fun get_points_in_tick_range<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u128 {
        abort 0
    }

    public fun get_position_amounts<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::object::ID) : (u64, u64) {
        abort 0
    }

    public fun get_position_fee<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : (u64, u64) {
        abort 0
    }

    public fun get_position_points<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : u128 {
        abort 0
    }

    public fun get_position_reward<T0, T1, T2>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : u64 {
        abort 0
    }

    public fun get_position_rewards<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : vector<u64> {
        abort 0
    }

    public fun get_rewards_in_tick_range<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : vector<u128> {
        abort 0
    }

    public fun index<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        abort 0
    }

    public fun initialize_rewarder<T0, T1, T2>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        abort 0
    }

    public fun is_pause<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        abort 0
    }

    public fun is_position_exist<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : bool {
        abort 0
    }

    public fun liquidity<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        abort 0
    }

    public(friend) fun new<T0, T1>(arg0: u32, arg1: u128, arg2: u64, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        abort 0
    }

    public fun open_position<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: u32, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) : 0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::position::Position {
        abort 0
    }

    public fun pause<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        abort 0
    }

    public fun position_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::position::PositionManager {
        abort 0
    }

    public fun protocol_fee<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        abort 0
    }

    public fun ref_fee_amount<T0, T1>(arg0: &FlashSwapReceipt<T0, T1>) : u64 {
        abort 0
    }

    public fun remove_liquidity<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::position::Position, arg3: u128, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        abort 0
    }

    public fun repay_add_liquidity<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: AddLiquidityReceipt<T0, T1>) {
        abort 0
    }

    public fun repay_flash_loan<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: FlashLoanReceipt) {
        abort 0
    }

    public fun repay_flash_loan_with_partner<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::partner::Partner, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: FlashLoanReceipt) {
        abort 0
    }

    public fun repay_flash_swap<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: FlashSwapReceipt<T0, T1>) {
        abort 0
    }

    public fun repay_flash_swap_with_partner<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::partner::Partner, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: FlashSwapReceipt<T0, T1>) {
        abort 0
    }

    public fun rewarder_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::rewarder::RewarderManager {
        abort 0
    }

    public fun set_display<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun step_swap_result_amount_in(arg0: &SwapStepResult) : u64 {
        abort 0
    }

    public fun step_swap_result_amount_out(arg0: &SwapStepResult) : u64 {
        abort 0
    }

    public fun step_swap_result_current_liquidity(arg0: &SwapStepResult) : u128 {
        abort 0
    }

    public fun step_swap_result_current_sqrt_price(arg0: &SwapStepResult) : u128 {
        abort 0
    }

    public fun step_swap_result_fee_amount(arg0: &SwapStepResult) : u64 {
        abort 0
    }

    public fun step_swap_result_remainder_amount(arg0: &SwapStepResult) : u64 {
        abort 0
    }

    public fun step_swap_result_target_sqrt_price(arg0: &SwapStepResult) : u128 {
        abort 0
    }

    public fun swap_pay_amount<T0, T1>(arg0: &FlashSwapReceipt<T0, T1>) : u64 {
        abort 0
    }

    public fun tick_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::tick::TickManager {
        abort 0
    }

    public fun tick_spacing<T0, T1>(arg0: &Pool<T0, T1>) : u32 {
        abort 0
    }

    public fun unpause<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        abort 0
    }

    public fun update_emission<T0, T1, T2>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::rewarder::RewarderGlobalVault, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        abort 0
    }

    public fun update_fee_rate<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        abort 0
    }

    public fun update_position_url<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        abort 0
    }

    public fun url<T0, T1>(arg0: &Pool<T0, T1>) : 0x1::string::String {
        abort 0
    }

    // decompiled from Move bytecode v6
}

