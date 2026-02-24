module 0x3f3ec7daae9b78a6faaadeeeb337647f9cc669a64da226aac93dadb231e18aac::momentum_v3_integration {
    struct MomentumV3SwapResult has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
    }

    public fun get_amount_in(arg0: &MomentumV3SwapResult) : u64 {
        arg0.amount_in
    }

    public fun get_amount_out(arg0: &MomentumV3SwapResult) : u64 {
        arg0.amount_out
    }

    public fun get_fee_amount(arg0: &MomentumV3SwapResult) : u64 {
        arg0.fee_amount
    }

    public fun get_momentum_pool_id(arg0: address) : 0x2::object::ID {
        0x2::object::id_from_address(@0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860)
    }

    public fun swap_a_to_b<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, MomentumV3SwapResult) {
        assert!(arg2 > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg5));
        let v0 = MomentumV3SwapResult{
            amount_in  : arg2,
            amount_out : 0,
            fee_amount : arg2 / 100,
        };
        (0x2::coin::zero<T1>(arg5), v0)
    }

    public fun swap_b_to_a<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, MomentumV3SwapResult) {
        assert!(arg2 > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, 0x2::tx_context::sender(arg5));
        let v0 = MomentumV3SwapResult{
            amount_in  : arg2,
            amount_out : 0,
            fee_amount : arg2 / 100,
        };
        (0x2::coin::zero<T0>(arg5), v0)
    }

    // decompiled from Move bytecode v6
}

