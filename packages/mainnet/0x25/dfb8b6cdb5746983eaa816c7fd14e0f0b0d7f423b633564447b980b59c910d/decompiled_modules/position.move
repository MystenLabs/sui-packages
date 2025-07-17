module 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::position {
    struct POSITION has drop {
        dummy_field: bool,
    }

    struct Position has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        lower_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        upper_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        fee_rate: u64,
        liquidity: u128,
        fee_growth_coin_a: u128,
        fee_growth_coin_b: u128,
        token_a_fee: u64,
        token_b_fee: u64,
        name: 0x1::string::String,
        coin_type_a: 0x1::string::String,
        coin_type_b: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        position_index: u128,
        reward_infos: vector<PositionRewardInfo>,
    }

    struct PositionRewardInfo has copy, drop, store {
        reward_growth_inside_last: u128,
        coins_owed_reward: u64,
    }

    public(friend) fun add_reward_info(arg0: &mut Position) {
        abort 0
    }

    public fun coins_owed_reward(arg0: &Position, arg1: u64) : u64 {
        abort 0
    }

    fun create_position_description(arg0: 0x1::string::String) : 0x1::string::String {
        abort 0
    }

    fun create_position_name(arg0: 0x1::string::String) : 0x1::string::String {
        abort 0
    }

    public(friend) fun decrease_reward_amount(arg0: &mut Position, arg1: u64, arg2: u64) {
        abort 0
    }

    public(friend) fun del(arg0: Position) : (0x2::object::ID, 0x2::object::ID, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        abort 0
    }

    public fun get_accrued_fee(arg0: &Position) : (u64, u64) {
        abort 0
    }

    fun get_mutable_reward_info(arg0: &mut Position, arg1: u64) : &mut PositionRewardInfo {
        abort 0
    }

    public fun is_empty(arg0: &Position) : bool {
        abort 0
    }

    public fun liquidity(arg0: &Position) : u128 {
        abort 0
    }

    public fun lower_tick(arg0: &Position) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        abort 0
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u128, arg6: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg7: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : Position {
        abort 0
    }

    public fun pool_id(arg0: &Position) : 0x2::object::ID {
        abort 0
    }

    public fun reward_infos_length(arg0: &Position) : u64 {
        abort 0
    }

    public(friend) fun set_fee_amounts(arg0: &mut Position, arg1: u64, arg2: u64) {
        abort 0
    }

    public(friend) fun update(arg0: &mut Position, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128, arg2: u128, arg3: u128, arg4: vector<u128>) {
        abort 0
    }

    fun update_reward_infos(arg0: &mut Position, arg1: vector<u128>) {
        abort 0
    }

    public fun upper_tick(arg0: &Position) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        abort 0
    }

    // decompiled from Move bytecode v6
}

