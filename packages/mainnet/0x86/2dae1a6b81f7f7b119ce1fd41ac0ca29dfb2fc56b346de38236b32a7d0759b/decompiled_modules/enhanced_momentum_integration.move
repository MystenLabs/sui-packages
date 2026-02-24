module 0x862dae1a6b81f7f7b119ce1fd41ac0ca29dfb2fc56b346de38236b32a7d0759b::enhanced_momentum_integration {
    struct EnhancedMomentumSwapResult has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        from_treasury: bool,
    }

    public fun enhanced_swap_a_to_b<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x862dae1a6b81f7f7b119ce1fd41ac0ca29dfb2fc56b346de38236b32a7d0759b::treasury_system::TokenTreasury<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, EnhancedMomentumSwapResult) {
        assert!(arg2 > 0, 1);
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 2);
        let v0 = arg2 * 1750 / 1000000;
        let v1 = arg2 - v0;
        let v2 = if (v1 > 1000000000) {
            v1 * 48 / 100
        } else {
            v1 * 51 / 100
        };
        assert!(0x862dae1a6b81f7f7b119ce1fd41ac0ca29dfb2fc56b346de38236b32a7d0759b::treasury_system::get_token_balance<T1>(arg4) >= v2, 3);
        if (0x2::coin::value<T0>(&arg1) == arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, arg2, arg6), @0x0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg6));
        };
        let v3 = EnhancedMomentumSwapResult{
            amount_in     : arg2,
            amount_out    : v2,
            fee_amount    : v0,
            from_treasury : true,
        };
        (0x862dae1a6b81f7f7b119ce1fd41ac0ca29dfb2fc56b346de38236b32a7d0759b::treasury_system::withdraw_for_swap<T1>(arg4, v2, arg6), v3)
    }

    public fun enhanced_swap_b_to_a<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: &mut 0x862dae1a6b81f7f7b119ce1fd41ac0ca29dfb2fc56b346de38236b32a7d0759b::treasury_system::TokenTreasury<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, EnhancedMomentumSwapResult) {
        assert!(arg2 > 0, 1);
        assert!(0x2::coin::value<T1>(&arg1) >= arg2, 2);
        let v0 = arg2 * 1750 / 1000000;
        let v1 = (arg2 - v0) * 196 / 100;
        assert!(0x862dae1a6b81f7f7b119ce1fd41ac0ca29dfb2fc56b346de38236b32a7d0759b::treasury_system::get_token_balance<T0>(arg4) >= v1, 3);
        if (0x2::coin::value<T1>(&arg1) == arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg1, arg2, arg6), @0x0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, 0x2::tx_context::sender(arg6));
        };
        let v2 = EnhancedMomentumSwapResult{
            amount_in     : arg2,
            amount_out    : v1,
            fee_amount    : v0,
            from_treasury : true,
        };
        (0x862dae1a6b81f7f7b119ce1fd41ac0ca29dfb2fc56b346de38236b32a7d0759b::treasury_system::withdraw_for_swap<T0>(arg4, v1, arg6), v2)
    }

    public fun get_amount_in(arg0: &EnhancedMomentumSwapResult) : u64 {
        arg0.amount_in
    }

    public fun get_amount_out(arg0: &EnhancedMomentumSwapResult) : u64 {
        arg0.amount_out
    }

    public fun get_fee_amount(arg0: &EnhancedMomentumSwapResult) : u64 {
        arg0.fee_amount
    }

    public fun is_from_treasury(arg0: &EnhancedMomentumSwapResult) : bool {
        arg0.from_treasury
    }

    // decompiled from Move bytecode v6
}

