module 0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::position {
    struct PositionManager has store {
        tick_spacing: u32,
        position_index: u64,
        positions: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, PositionInfo>,
    }

    struct POSITION has drop {
        dummy_field: bool,
    }

    struct Position has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        index: u64,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        tick_lower_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        tick_upper_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        liquidity: u128,
    }

    struct PositionInfo has copy, drop, store {
        position_id: 0x2::object::ID,
        liquidity: u128,
        tick_lower_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        tick_upper_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        fee_growth_inside_a: u128,
        fee_growth_inside_b: u128,
        fee_owned_a: u64,
        fee_owned_b: u64,
        points_owned: u128,
        points_growth_inside: u128,
        rewards: vector<PositionReward>,
    }

    struct PositionReward has copy, drop, store {
        growth_inside: u128,
        amount_owned: u64,
    }

    public fun borrow_position_info(arg0: &PositionManager, arg1: 0x2::object::ID) : &PositionInfo {
        abort 0
    }

    public fun check_position_tick_range(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u32) {
        abort 0
    }

    public fun description(arg0: &Position) : 0x1::string::String {
        abort 0
    }

    public fun fetch_positions(arg0: &PositionManager, arg1: vector<0x2::object::ID>, arg2: u64) : vector<PositionInfo> {
        abort 0
    }

    public fun index(arg0: &Position) : u64 {
        abort 0
    }

    public fun info_fee_growth_inside(arg0: &PositionInfo) : (u128, u128) {
        abort 0
    }

    public fun info_fee_owned(arg0: &PositionInfo) : (u64, u64) {
        abort 0
    }

    public fun info_liquidity(arg0: &PositionInfo) : u128 {
        abort 0
    }

    public fun info_points_growth_inside(arg0: &PositionInfo) : u128 {
        abort 0
    }

    public fun info_points_owned(arg0: &PositionInfo) : u128 {
        abort 0
    }

    public fun info_position_id(arg0: &PositionInfo) : 0x2::object::ID {
        abort 0
    }

    public fun info_rewards(arg0: &PositionInfo) : &vector<PositionReward> {
        abort 0
    }

    public fun info_tick_range(arg0: &PositionInfo) : (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        abort 0
    }

    public fun init_noop(arg0: POSITION, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun inited_rewards_count(arg0: &PositionManager, arg1: 0x2::object::ID) : u64 {
        abort 0
    }

    public fun is_empty(arg0: &PositionInfo) : bool {
        abort 0
    }

    public fun is_position_exist(arg0: &PositionManager, arg1: 0x2::object::ID) : bool {
        abort 0
    }

    public fun liquidity(arg0: &Position) : u128 {
        abort 0
    }

    public fun name(arg0: &Position) : 0x1::string::String {
        abort 0
    }

    public(friend) fun new(arg0: u32, arg1: &mut 0x2::tx_context::TxContext) : PositionManager {
        abort 0
    }

    public fun pool_id(arg0: &Position) : 0x2::object::ID {
        abort 0
    }

    public fun reward_amount_owned(arg0: &PositionReward) : u64 {
        abort 0
    }

    public fun reward_growth_inside(arg0: &PositionReward) : u128 {
        abort 0
    }

    public(friend) fun rewards_amount_owned(arg0: &PositionManager, arg1: 0x2::object::ID) : vector<u64> {
        abort 0
    }

    public fun set_display(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun tick_range(arg0: &Position) : (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        abort 0
    }

    public fun url(arg0: &Position) : 0x1::string::String {
        abort 0
    }

    // decompiled from Move bytecode v6
}

