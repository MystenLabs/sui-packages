module 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::vault {
    public fun split<T0>(arg0: &mut 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::Market<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position, 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position) {
        split_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg1), arg2)
    }

    public fun merge<T0>(arg0: &mut 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::Market<T0>, arg1: 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position, arg2: 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(merge_to_balance<T0>(arg0, arg1, arg2), arg3)
    }

    public fun merge_to_balance<T0>(arg0: &mut 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::Market<T0>, arg1: 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position, arg2: 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::object::id<0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::Market<T0>>(arg0);
        assert!(0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::market_id(&arg1) == v0, 1);
        assert!(0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::market_id(&arg2) == v0, 1);
        let v1 = 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::burn(arg1);
        assert!(v1 == 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::burn(arg2), 0);
        0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::withdraw_collateral<T0>(arg0, v1)
    }

    public fun outcome_no() : u8 {
        0
    }

    public fun outcome_yes() : u8 {
        1
    }

    public fun redeem<T0>(arg0: &mut 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::Market<T0>, arg1: 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position, arg2: &0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::fee::FeeConfig, arg3: &mut 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::treasury::Treasury<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::state<T0>(arg0);
        assert!(v0 == 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::state_resolved() || v0 == 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::state_invalid(), 3);
        let v1 = 0x2::object::id<0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::Market<T0>>(arg0);
        assert!(0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::market_id(&arg1) == v1, 1);
        let v2 = if (v0 == 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::state_resolved()) {
            assert!(0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::outcome(&arg1) == 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::winning_outcome<T0>(arg0), 2);
            0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::shares(&arg1)
        } else {
            0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::shares(&arg1) / 2
        };
        0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::burn(arg1);
        let v3 = 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::withdraw_collateral<T0>(arg0, v2);
        let v4 = 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::fee::calc_settlement_fee(arg2, v2);
        if (v4 > 0) {
            0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::treasury::deposit<T0>(arg3, 0x2::balance::split<T0>(&mut v3, v4), 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::treasury::kind_settlement(), 0x1::option::some<0x2::object::ID>(v1), 0x2::tx_context::sender(arg4));
        };
        0x2::coin::from_balance<T0>(v3, arg4)
    }

    public fun split_balance<T0>(arg0: &mut 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::Market<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position, 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position) {
        0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::assert_open<T0>(arg0);
        let v0 = 0x2::balance::value<T0>(&arg1);
        0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::deposit_collateral<T0>(arg0, arg1);
        let v1 = 0x2::object::id<0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::Market<T0>>(arg0);
        (0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::mint(v1, 1, v0, arg2), 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::mint(v1, 0, v0, arg2))
    }

    // decompiled from Move bytecode v7
}

