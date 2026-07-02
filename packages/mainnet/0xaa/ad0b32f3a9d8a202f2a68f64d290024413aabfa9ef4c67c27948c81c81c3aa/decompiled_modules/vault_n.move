module 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::vault_n {
    public fun split<T0>(arg0: &mut 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market_n::MarketN<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : vector<0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::Position> {
        0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market_n::assert_open<T0>(arg0);
        0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market_n::deposit_collateral<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
        let v0 = 0x1::vector::empty<0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::Position>();
        let v1 = 0;
        while (v1 < 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market_n::num_outcomes<T0>(arg0)) {
            0x1::vector::push_back<0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::Position>(&mut v0, 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::mint(0x2::object::id<0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market_n::MarketN<T0>>(arg0), v1, 0x2::coin::value<T0>(&arg1), arg2));
            v1 = v1 + 1;
        };
        v0
    }

    public fun merge_set<T0>(arg0: &mut 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market_n::MarketN<T0>, arg1: vector<0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::Position>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market_n::num_outcomes<T0>(arg0);
        assert!(0x1::vector::length<0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::Position>(&arg1) == (v0 as u64), 3);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<bool>(&mut v1, false);
            v2 = v2 + 1;
        };
        let v3 = 0;
        let v4 = v3;
        let v5 = true;
        while (!0x1::vector::is_empty<0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::Position>(&arg1)) {
            let v6 = 0x1::vector::pop_back<0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::Position>(&mut arg1);
            assert!(0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::market_id(&v6) == 0x2::object::id<0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market_n::MarketN<T0>>(arg0), 0);
            let v7 = 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::outcome(&v6);
            assert!((v7 as u64) < (v0 as u64), 3);
            assert!(!*0x1::vector::borrow<bool>(&v1, (v7 as u64)), 3);
            *0x1::vector::borrow_mut<bool>(&mut v1, (v7 as u64)) = true;
            let v8 = 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::burn(v6);
            if (v5) {
                v4 = v8;
                v5 = false;
                continue
            };
            assert!(v8 == v3, 4);
        };
        0x1::vector::destroy_empty<0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::Position>(arg1);
        0x2::coin::from_balance<T0>(0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market_n::withdraw_collateral<T0>(arg0, v4), arg2)
    }

    public fun redeem<T0>(arg0: &mut 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market_n::MarketN<T0>, arg1: 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::Position, arg2: &0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::fee::FeeConfig, arg3: &mut 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::treasury::Treasury<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market_n::state<T0>(arg0);
        assert!(v0 == 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market_n::state_resolved() || v0 == 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market_n::state_invalid(), 2);
        let v1 = 0x2::object::id<0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market_n::MarketN<T0>>(arg0);
        assert!(0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::market_id(&arg1) == v1, 0);
        let v2 = if (v0 == 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market_n::state_resolved()) {
            assert!(0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::outcome(&arg1) == 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market_n::winning_outcome<T0>(arg0), 1);
            0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::shares(&arg1)
        } else {
            0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::shares(&arg1) / (0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market_n::num_outcomes<T0>(arg0) as u64)
        };
        0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::burn(arg1);
        let v3 = 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market_n::withdraw_collateral<T0>(arg0, v2);
        let v4 = 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::fee::calc_settlement_fee(arg2, v2);
        if (v4 > 0) {
            0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::treasury::deposit<T0>(arg3, 0x2::balance::split<T0>(&mut v3, v4), 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::treasury::kind_settlement(), 0x1::option::some<0x2::object::ID>(v1), 0x2::tx_context::sender(arg4));
        };
        0x2::coin::from_balance<T0>(v3, arg4)
    }

    // decompiled from Move bytecode v7
}

