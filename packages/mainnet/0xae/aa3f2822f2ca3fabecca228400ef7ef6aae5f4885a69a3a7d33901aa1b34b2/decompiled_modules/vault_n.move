module 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::vault_n {
    public fun split<T0>(arg0: &mut 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market_n::MarketN<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : vector<0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position> {
        0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market_n::assert_open<T0>(arg0);
        0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market_n::deposit_collateral<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
        let v0 = 0x1::vector::empty<0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position>();
        let v1 = 0;
        while (v1 < 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market_n::num_outcomes<T0>(arg0)) {
            0x1::vector::push_back<0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position>(&mut v0, 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::mint(0x2::object::id<0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market_n::MarketN<T0>>(arg0), v1, 0x2::coin::value<T0>(&arg1), arg2));
            v1 = v1 + 1;
        };
        v0
    }

    public fun merge_set<T0>(arg0: &mut 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market_n::MarketN<T0>, arg1: vector<0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market_n::num_outcomes<T0>(arg0);
        assert!(0x1::vector::length<0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position>(&arg1) == (v0 as u64), 3);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<bool>(&mut v1, false);
            v2 = v2 + 1;
        };
        let v3 = 0;
        let v4 = v3;
        let v5 = true;
        while (!0x1::vector::is_empty<0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position>(&arg1)) {
            let v6 = 0x1::vector::pop_back<0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position>(&mut arg1);
            assert!(0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::market_id(&v6) == 0x2::object::id<0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market_n::MarketN<T0>>(arg0), 0);
            let v7 = 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::outcome(&v6);
            assert!((v7 as u64) < (v0 as u64), 3);
            assert!(!*0x1::vector::borrow<bool>(&v1, (v7 as u64)), 3);
            *0x1::vector::borrow_mut<bool>(&mut v1, (v7 as u64)) = true;
            let v8 = 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::burn(v6);
            if (v5) {
                v4 = v8;
                v5 = false;
                continue
            };
            assert!(v8 == v3, 4);
        };
        0x1::vector::destroy_empty<0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position>(arg1);
        0x2::coin::from_balance<T0>(0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market_n::withdraw_collateral<T0>(arg0, v4), arg2)
    }

    public fun redeem<T0>(arg0: &mut 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market_n::MarketN<T0>, arg1: 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position, arg2: &0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::fee::FeeConfig, arg3: &mut 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::treasury::Treasury<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market_n::state<T0>(arg0);
        assert!(v0 == 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market_n::state_resolved() || v0 == 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market_n::state_invalid(), 2);
        let v1 = 0x2::object::id<0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market_n::MarketN<T0>>(arg0);
        assert!(0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::market_id(&arg1) == v1, 0);
        let v2 = if (v0 == 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market_n::state_resolved()) {
            assert!(0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::outcome(&arg1) == 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market_n::winning_outcome<T0>(arg0), 1);
            0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::shares(&arg1)
        } else {
            0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::shares(&arg1) / (0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market_n::num_outcomes<T0>(arg0) as u64)
        };
        0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::burn(arg1);
        let v3 = 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market_n::withdraw_collateral<T0>(arg0, v2);
        let v4 = 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::fee::calc_settlement_fee(arg2, v2);
        if (v4 > 0) {
            0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::treasury::deposit<T0>(arg3, 0x2::balance::split<T0>(&mut v3, v4), 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::treasury::kind_settlement(), 0x1::option::some<0x2::object::ID>(v1), 0x2::tx_context::sender(arg4));
        };
        0x2::coin::from_balance<T0>(v3, arg4)
    }

    // decompiled from Move bytecode v7
}

