module 0x4766f79374e215fff066613afb0e53fa575ffecbb0efb4a2fab9f8f3212c1463::magma_clmm_integration {
    struct MagmaClmmSwapResult has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
    }

    public fun get_amount_in(arg0: &MagmaClmmSwapResult) : u64 {
        arg0.amount_in
    }

    public fun get_amount_out(arg0: &MagmaClmmSwapResult) : u64 {
        arg0.amount_out
    }

    public fun get_fee_amount(arg0: &MagmaClmmSwapResult) : u64 {
        arg0.fee_amount
    }

    public fun get_magma_pool_id(arg0: address) : 0x2::object::ID {
        0x2::object::id_from_address(@0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d)
    }

    public fun swap_a_to_b<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, MagmaClmmSwapResult) {
        assert!(arg2 > 0, 1);
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 2);
        let v0 = arg2 * 500 / 1000000;
        let v1 = arg2 - v0;
        let v2 = if (v1 > 1000000000) {
            v1 * 314 / 100
        } else {
            v1 * 315 / 100
        };
        if (0x2::coin::value<T0>(&arg1) == arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, arg2, arg5), @0x0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg5));
        };
        let v3 = MagmaClmmSwapResult{
            amount_in  : arg2,
            amount_out : v2,
            fee_amount : v0,
        };
        (0x2::coin::zero<T1>(arg5), v3)
    }

    public fun swap_b_to_a<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, MagmaClmmSwapResult) {
        assert!(arg2 > 0, 1);
        assert!(0x2::coin::value<T1>(&arg1) >= arg2, 2);
        let v0 = arg2 * 500 / 1000000;
        let v1 = arg2 - v0;
        let v2 = if (v1 > 3150000000) {
            v1 * 3175 / 10000
        } else {
            v1 * 3175 / 10000
        };
        if (0x2::coin::value<T1>(&arg1) == arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg1, arg2, arg5), @0x0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, 0x2::tx_context::sender(arg5));
        };
        let v3 = MagmaClmmSwapResult{
            amount_in  : arg2,
            amount_out : v2,
            fee_amount : v0,
        };
        (0x2::coin::zero<T0>(arg5), v3)
    }

    // decompiled from Move bytecode v6
}

