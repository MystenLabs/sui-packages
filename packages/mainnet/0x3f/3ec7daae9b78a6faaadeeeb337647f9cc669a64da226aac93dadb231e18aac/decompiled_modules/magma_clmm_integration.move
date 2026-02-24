module 0x3f3ec7daae9b78a6faaadeeeb337647f9cc669a64da226aac93dadb231e18aac::magma_clmm_integration {
    struct MagmaClmmSwapResult has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        price_impact: u64,
    }

    public fun calculate_swap_with_partner(arg0: address, arg1: bool, arg2: bool, arg3: u64, arg4: address) : u64 {
        arg3 * 995 / 1000
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

    public fun get_price_impact(arg0: &MagmaClmmSwapResult) : u64 {
        arg0.price_impact
    }

    public fun swap_a_to_b<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, MagmaClmmSwapResult) {
        assert!(arg2 > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
        let v0 = MagmaClmmSwapResult{
            amount_in    : arg2,
            amount_out   : 0,
            fee_amount   : arg2 * 5 / 1000,
            price_impact : 10,
        };
        (0x2::coin::zero<T1>(arg4), v0)
    }

    public fun swap_b_to_a<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, MagmaClmmSwapResult) {
        assert!(arg2 > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, 0x2::tx_context::sender(arg4));
        let v0 = MagmaClmmSwapResult{
            amount_in    : arg2,
            amount_out   : 0,
            fee_amount   : arg2 * 5 / 1000,
            price_impact : 10,
        };
        (0x2::coin::zero<T0>(arg4), v0)
    }

    // decompiled from Move bytecode v6
}

