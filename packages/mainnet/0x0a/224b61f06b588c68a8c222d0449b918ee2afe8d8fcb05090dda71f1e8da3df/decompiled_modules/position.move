module 0xa224b61f06b588c68a8c222d0449b918ee2afe8d8fcb05090dda71f1e8da3df::position {
    struct PositionManager has store {
        tick_spacing: u32,
        position_index: u64,
        positions: 0xa224b61f06b588c68a8c222d0449b918ee2afe8d8fcb05090dda71f1e8da3df::linked_table::LinkedTable<0x2::object::ID, PositionInfo>,
    }

    struct PositionInfo has copy, drop, store {
        position_id: 0x2::object::ID,
        liquidity: u128,
        tick_lower_index: 0xa224b61f06b588c68a8c222d0449b918ee2afe8d8fcb05090dda71f1e8da3df::i32::I32,
        tick_upper_index: 0xa224b61f06b588c68a8c222d0449b918ee2afe8d8fcb05090dda71f1e8da3df::i32::I32,
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

    // decompiled from Move bytecode v6
}

