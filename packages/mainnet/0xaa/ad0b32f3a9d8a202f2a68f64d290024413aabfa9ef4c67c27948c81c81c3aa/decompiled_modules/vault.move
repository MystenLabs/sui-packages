module 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::vault {
    public fun split<T0>(arg0: &mut 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::Market<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::Position, 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::Position) {
        split_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg1), arg2)
    }

    public fun merge<T0>(arg0: &mut 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::Market<T0>, arg1: 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::Position, arg2: 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::Position, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(merge_to_balance<T0>(arg0, arg1, arg2), arg3)
    }

    public fun merge_to_balance<T0>(arg0: &mut 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::Market<T0>, arg1: 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::Position, arg2: 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::Position) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::object::id<0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::Market<T0>>(arg0);
        assert!(0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::market_id(&arg1) == v0, 1);
        assert!(0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::market_id(&arg2) == v0, 1);
        let v1 = 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::burn(arg1);
        assert!(v1 == 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::burn(arg2), 0);
        0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::withdraw_collateral<T0>(arg0, v1)
    }

    public fun outcome_no() : u8 {
        0
    }

    public fun outcome_yes() : u8 {
        1
    }

    public fun redeem<T0>(arg0: &mut 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::Market<T0>, arg1: 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::Position, arg2: &0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::fee::FeeConfig, arg3: &mut 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::treasury::Treasury<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::state<T0>(arg0);
        assert!(v0 == 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::state_resolved() || v0 == 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::state_invalid(), 3);
        let v1 = 0x2::object::id<0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::Market<T0>>(arg0);
        assert!(0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::market_id(&arg1) == v1, 1);
        let v2 = if (v0 == 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::state_resolved()) {
            assert!(0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::outcome(&arg1) == 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::winning_outcome<T0>(arg0), 2);
            0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::shares(&arg1)
        } else {
            0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::shares(&arg1) / 2
        };
        0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::burn(arg1);
        let v3 = 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::withdraw_collateral<T0>(arg0, v2);
        let v4 = 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::fee::calc_settlement_fee(arg2, v2);
        if (v4 > 0) {
            0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::treasury::deposit<T0>(arg3, 0x2::balance::split<T0>(&mut v3, v4), 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::treasury::kind_settlement(), 0x1::option::some<0x2::object::ID>(v1), 0x2::tx_context::sender(arg4));
        };
        0x2::coin::from_balance<T0>(v3, arg4)
    }

    public fun split_balance<T0>(arg0: &mut 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::Market<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::Position, 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::Position) {
        0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::assert_open<T0>(arg0);
        let v0 = 0x2::balance::value<T0>(&arg1);
        0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::deposit_collateral<T0>(arg0, arg1);
        let v1 = 0x2::object::id<0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::Market<T0>>(arg0);
        (0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::mint(v1, 1, v0, arg2), 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position::mint(v1, 0, v0, arg2))
    }

    // decompiled from Move bytecode v7
}

