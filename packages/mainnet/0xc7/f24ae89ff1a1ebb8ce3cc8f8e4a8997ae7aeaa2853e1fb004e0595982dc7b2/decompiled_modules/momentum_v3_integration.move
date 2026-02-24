module 0xc7f24ae89ff1a1ebb8ce3cc8f8e4a8997ae7aeaa2853e1fb004e0595982dc7b2::momentum_v3_integration {
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
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 2);
        let v0 = arg2 * 3000 / 1000000;
        let v1 = arg2 - v0;
        let v2 = if (v1 > 1000000000) {
            v1 * 48 / 100
        } else {
            v1 * 51 / 100
        };
        if (0x2::coin::value<T0>(&arg1) == arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, arg2, arg5), @0x0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg5));
        };
        let v3 = MomentumV3SwapResult{
            amount_in  : arg2,
            amount_out : v2,
            fee_amount : v0,
        };
        (0x2::coin::zero<T1>(arg5), v3)
    }

    public fun swap_b_to_a<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, MomentumV3SwapResult) {
        assert!(arg2 > 0, 1);
        assert!(0x2::coin::value<T1>(&arg1) >= arg2, 2);
        let v0 = arg2 * 3000 / 1000000;
        let v1 = arg2 - v0;
        let v2 = if (v1 > 3200000000) {
            v1 * 3100 / 10000
        } else {
            v1 * 3125 / 10000
        };
        if (0x2::coin::value<T1>(&arg1) == arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg1, arg2, arg5), @0x0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, 0x2::tx_context::sender(arg5));
        };
        let v3 = MomentumV3SwapResult{
            amount_in  : arg2,
            amount_out : v2,
            fee_amount : v0,
        };
        (0x2::coin::zero<T0>(arg5), v3)
    }

    // decompiled from Move bytecode v6
}

