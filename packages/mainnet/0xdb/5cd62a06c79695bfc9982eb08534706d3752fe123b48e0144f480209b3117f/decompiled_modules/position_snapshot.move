module 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position_snapshot {
    struct PositionLiquiditySnapshot has store, key {
        id: 0x2::object::UID,
        current_sqrt_price: u128,
        remove_percent: u64,
        total_value_cut: u64,
        snapshots: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, PositionSnapshot>,
    }

    struct PositionSnapshot has copy, drop, store {
        position_id: 0x2::object::ID,
        liquidity: u128,
        tick_lower_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        tick_upper_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        fee_owned_a: u64,
        fee_owned_b: u64,
        rewards: vector<u64>,
        value_cut: u64,
    }

    public(friend) fun new(arg0: u128, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : PositionLiquiditySnapshot {
        PositionLiquiditySnapshot{
            id                 : 0x2::object::new(arg2),
            current_sqrt_price : arg0,
            remove_percent     : arg1,
            total_value_cut    : 0,
            snapshots          : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<0x2::object::ID, PositionSnapshot>(arg2),
        }
    }

    public(friend) fun add(arg0: &mut PositionLiquiditySnapshot, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::PositionInfo) {
        assert!(!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, PositionSnapshot>(&arg0.snapshots, arg1), 1);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::info_rewards(&arg3);
        while (v1 < 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::PositionReward>(v2)) {
            0x1::vector::push_back<u64>(&mut v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::reward_amount_owned(0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::PositionReward>(v2, v1)));
            v1 = v1 + 1;
        };
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::info_tick_range(&arg3);
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::info_fee_owned(&arg3);
        let v7 = PositionSnapshot{
            position_id      : arg1,
            liquidity        : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::info_liquidity(&arg3),
            tick_lower_index : v3,
            tick_upper_index : v4,
            fee_owned_a      : v5,
            fee_owned_b      : v6,
            rewards          : v0,
            value_cut        : arg2,
        };
        arg0.total_value_cut = arg0.total_value_cut + arg2;
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, PositionSnapshot>(&mut arg0.snapshots, arg1, v7);
    }

    public fun calculate_remove_liquidity(arg0: &PositionLiquiditySnapshot, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::PositionInfo) : u128 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_ceil((arg0.remove_percent as u128), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::info_liquidity(arg1), (1000000 as u128))
    }

    public fun contains(arg0: &PositionLiquiditySnapshot, arg1: 0x2::object::ID) : bool {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, PositionSnapshot>(&arg0.snapshots, arg1)
    }

    public fun current_sqrt_price(arg0: &PositionLiquiditySnapshot) : u128 {
        arg0.current_sqrt_price
    }

    public fun fee_owned(arg0: &PositionSnapshot) : (u64, u64) {
        (arg0.fee_owned_a, arg0.fee_owned_b)
    }

    public fun get(arg0: &PositionLiquiditySnapshot, arg1: 0x2::object::ID) : PositionSnapshot {
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, PositionSnapshot>(&arg0.snapshots, arg1), 2);
        *0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<0x2::object::ID, PositionSnapshot>(&arg0.snapshots, arg1)
    }

    public fun liquidity(arg0: &PositionSnapshot) : u128 {
        arg0.liquidity
    }

    public fun position_id(arg0: &PositionSnapshot) : 0x2::object::ID {
        arg0.position_id
    }

    public(friend) fun remove(arg0: &mut PositionLiquiditySnapshot, arg1: 0x2::object::ID) {
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, PositionSnapshot>(&arg0.snapshots, arg1), 2);
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::remove<0x2::object::ID, PositionSnapshot>(&mut arg0.snapshots, arg1);
        arg0.total_value_cut = arg0.total_value_cut - v0.value_cut;
    }

    public fun remove_percent(arg0: &PositionLiquiditySnapshot) : u64 {
        arg0.remove_percent
    }

    public fun rewards(arg0: &PositionSnapshot) : vector<u64> {
        arg0.rewards
    }

    public fun tick_range(arg0: &PositionSnapshot) : (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        (arg0.tick_lower_index, arg0.tick_upper_index)
    }

    public fun total_value_cut(arg0: &PositionLiquiditySnapshot) : u64 {
        arg0.total_value_cut
    }

    public fun value_cut(arg0: &PositionSnapshot) : u64 {
        arg0.value_cut
    }

    // decompiled from Move bytecode v6
}

