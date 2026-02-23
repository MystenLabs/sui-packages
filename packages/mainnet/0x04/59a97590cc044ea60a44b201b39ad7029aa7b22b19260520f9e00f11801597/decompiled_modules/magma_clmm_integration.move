module 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::magma_clmm_integration {
    struct MagmaClmmSwapResult has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        protocol_fee: u64,
        sqrt_price_before: u128,
        sqrt_price_after: u128,
        pool_id: 0x2::object::ID,
    }

    struct MagmaClmmSwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        trader: address,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        protocol_fee: u64,
    }

    public fun get_magma_clmm_amount_in(arg0: &MagmaClmmSwapResult) : u64 {
        arg0.amount_in
    }

    public fun get_magma_clmm_amount_out(arg0: &MagmaClmmSwapResult) : u64 {
        arg0.amount_out
    }

    public fun get_magma_clmm_fee(arg0: &MagmaClmmSwapResult) : u64 {
        arg0.fee_amount
    }

    public fun get_magma_clmm_pool_id(arg0: &MagmaClmmSwapResult) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun get_magma_clmm_price_after(arg0: &MagmaClmmSwapResult) : u128 {
        arg0.sqrt_price_after
    }

    public fun get_magma_clmm_price_before(arg0: &MagmaClmmSwapResult) : u128 {
        arg0.sqrt_price_before
    }

    public fun get_magma_clmm_protocol_fee(arg0: &MagmaClmmSwapResult) : u64 {
        arg0.protocol_fee
    }

    public fun get_magma_info() : (address, u64) {
        (@0x0, 1)
    }

    public fun magma_clmm_swap_a_to_b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, MagmaClmmSwapResult) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = v0 * 995 / 1000;
        let v2 = v0 * 5 / 1000;
        assert!(v1 >= arg1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg4));
        let v3 = 0x2::object::id_from_address(arg2);
        let v4 = MagmaClmmSwapResult{
            amount_in         : v0,
            amount_out        : 0,
            fee_amount        : 0,
            protocol_fee      : 0,
            sqrt_price_before : 1000000000000000000,
            sqrt_price_after  : 999000000000000000,
            pool_id           : v3,
        };
        let v5 = MagmaClmmSwapEvent{
            pool_id      : v3,
            trader       : 0x2::tx_context::sender(arg4),
            a2b          : true,
            amount_in    : v0,
            amount_out   : v1,
            fee_amount   : v2,
            protocol_fee : v2 / 10,
        };
        0x2::event::emit<MagmaClmmSwapEvent>(v5);
        (0x2::coin::zero<T1>(arg4), v4)
    }

    public fun magma_clmm_swap_b_to_a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, MagmaClmmSwapResult) {
        let v0 = 0x2::coin::value<T1>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = v0 * 995 / 1000;
        let v2 = v0 * 5 / 1000;
        assert!(v1 >= arg1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg0, 0x2::tx_context::sender(arg4));
        let v3 = 0x2::object::id_from_address(arg2);
        let v4 = MagmaClmmSwapResult{
            amount_in         : v0,
            amount_out        : 0,
            fee_amount        : 0,
            protocol_fee      : 0,
            sqrt_price_before : 1000000000000000000,
            sqrt_price_after  : 1001000000000000000,
            pool_id           : v3,
        };
        let v5 = MagmaClmmSwapEvent{
            pool_id      : v3,
            trader       : 0x2::tx_context::sender(arg4),
            a2b          : false,
            amount_in    : v0,
            amount_out   : v1,
            fee_amount   : v2,
            protocol_fee : v2 / 10,
        };
        0x2::event::emit<MagmaClmmSwapEvent>(v5);
        (0x2::coin::zero<T0>(arg4), v4)
    }

    // decompiled from Move bytecode v6
}

