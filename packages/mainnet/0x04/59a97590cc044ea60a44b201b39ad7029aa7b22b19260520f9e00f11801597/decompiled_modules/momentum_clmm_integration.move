module 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::momentum_clmm_integration {
    struct MomentumClmmSwapResult has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        protocol_fee: u64,
        sqrt_price_before: u128,
        sqrt_price_after: u128,
        tick_before: u64,
        tick_after: u64,
        liquidity: u128,
        pool_id: 0x2::object::ID,
        steps: u64,
    }

    struct MomentumClmmSwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        trader: address,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        protocol_fee: u64,
        sqrt_price_before: u128,
        sqrt_price_after: u128,
        tick_change: u64,
    }

    public fun estimate_momentum_swap<T0, T1>(arg0: u64, arg1: bool, arg2: address) : (u64, u64, u64, u128) {
        let v0 = arg0 * 997 / 1000;
        let v1 = arg0 * 3 / 1000;
        let v2 = if (arg1) {
            10000
        } else {
            8000
        };
        let v3 = arg0 / v2;
        let v4 = if (v0 > v3) {
            v0 - v3
        } else {
            v0 / 2
        };
        let v5 = if (arg1) {
            1500000000000000000 - (arg0 as u128) * 1000 / 1000000
        } else {
            1500000000000000000 + (arg0 as u128) * 1200 / 1000000
        };
        (v4, v1, v1 / 20, v5)
    }

    public fun get_mmt_mainnet_package() : address {
        @0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860
    }

    public fun get_momentum_clmm_amount_in(arg0: &MomentumClmmSwapResult) : u64 {
        arg0.amount_in
    }

    public fun get_momentum_clmm_amount_out(arg0: &MomentumClmmSwapResult) : u64 {
        arg0.amount_out
    }

    public fun get_momentum_clmm_fee(arg0: &MomentumClmmSwapResult) : u64 {
        arg0.fee_amount
    }

    public fun get_momentum_clmm_liquidity(arg0: &MomentumClmmSwapResult) : u128 {
        arg0.liquidity
    }

    public fun get_momentum_clmm_pool_id(arg0: &MomentumClmmSwapResult) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun get_momentum_clmm_protocol_fee(arg0: &MomentumClmmSwapResult) : u64 {
        arg0.protocol_fee
    }

    public fun get_momentum_clmm_sqrt_price_after(arg0: &MomentumClmmSwapResult) : u128 {
        arg0.sqrt_price_after
    }

    public fun get_momentum_clmm_sqrt_price_before(arg0: &MomentumClmmSwapResult) : u128 {
        arg0.sqrt_price_before
    }

    public fun get_momentum_clmm_steps(arg0: &MomentumClmmSwapResult) : u64 {
        arg0.steps
    }

    public fun get_momentum_clmm_tick_change(arg0: &MomentumClmmSwapResult) : (u64, u64) {
        (arg0.tick_before, arg0.tick_after)
    }

    public fun get_momentum_protocol_info() : (address, u64, u64) {
        (@0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860, 3, 3000)
    }

    public fun momentum_clmm_swap_a_to_b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, MomentumClmmSwapResult) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = v0 * 997 / 1000;
        let v2 = v0 / 10000;
        let v3 = if (v1 > v2) {
            v1 - v2
        } else {
            v1 / 2
        };
        assert!(v3 >= arg1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg5));
        let v4 = 0x2::object::id_from_address(arg2);
        let v5 = MomentumClmmSwapResult{
            amount_in         : v0,
            amount_out        : 0,
            fee_amount        : 0,
            protocol_fee      : 0,
            sqrt_price_before : 1500000000000000000,
            sqrt_price_after  : 1499000000000000000,
            tick_before       : 100000,
            tick_after        : 100001,
            liquidity         : 50000000000000,
            pool_id           : v4,
            steps             : 1,
        };
        let v6 = MomentumClmmSwapEvent{
            pool_id           : v4,
            trader            : 0x2::tx_context::sender(arg5),
            a2b               : true,
            amount_in         : v0,
            amount_out        : 0,
            fee_amount        : 0,
            protocol_fee      : 0,
            sqrt_price_before : 1500000000000000000,
            sqrt_price_after  : 1499000000000000000,
            tick_change       : 1,
        };
        0x2::event::emit<MomentumClmmSwapEvent>(v6);
        (0x2::coin::zero<T1>(arg5), v5)
    }

    public fun momentum_clmm_swap_b_to_a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: address, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, MomentumClmmSwapResult) {
        let v0 = 0x2::coin::value<T1>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = v0 * 997 / 1000;
        let v2 = v0 / 8000;
        let v3 = if (v1 > v2) {
            v1 - v2
        } else {
            v1 / 2
        };
        assert!(v3 >= arg1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg0, 0x2::tx_context::sender(arg5));
        let v4 = 0x2::object::id_from_address(arg2);
        let v5 = MomentumClmmSwapResult{
            amount_in         : v0,
            amount_out        : 0,
            fee_amount        : 0,
            protocol_fee      : 0,
            sqrt_price_before : 1500000000000000000,
            sqrt_price_after  : 1501000000000000000,
            tick_before       : 100000,
            tick_after        : 99999,
            liquidity         : 50000000000000,
            pool_id           : v4,
            steps             : 1,
        };
        let v6 = MomentumClmmSwapEvent{
            pool_id           : v4,
            trader            : 0x2::tx_context::sender(arg5),
            a2b               : false,
            amount_in         : v0,
            amount_out        : 0,
            fee_amount        : 0,
            protocol_fee      : 0,
            sqrt_price_before : 1500000000000000000,
            sqrt_price_after  : 1501000000000000000,
            tick_change       : 1,
        };
        0x2::event::emit<MomentumClmmSwapEvent>(v6);
        (0x2::coin::zero<T0>(arg5), v5)
    }

    // decompiled from Move bytecode v6
}

