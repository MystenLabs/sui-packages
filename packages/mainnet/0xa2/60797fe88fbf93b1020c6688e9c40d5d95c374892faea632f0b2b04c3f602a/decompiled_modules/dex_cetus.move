module 0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_cetus {
    struct CetusPool has key {
        id: 0x2::object::UID,
        token_a: vector<u8>,
        token_b: vector<u8>,
        fee_rate: u64,
        liquidity: u128,
        sqrt_price: u128,
        tick_current: u64,
        protocol_fee_a: u64,
        protocol_fee_b: u64,
    }

    struct Position has key {
        id: 0x2::object::UID,
        pool_id: vector<u8>,
        tick_lower: u64,
        tick_upper: u64,
        liquidity: u128,
        fee_growth_inside_a: u128,
        fee_growth_inside_b: u128,
        tokens_owed_a: u64,
        tokens_owed_b: u64,
    }

    public fun calculate_min_output_with_slippage(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 5000, 103);
        arg0 * (10000 - arg1) / 10000
    }

    fun calculate_swap_output(arg0: u64, arg1: u128, arg2: bool) : u64 {
        assert!(arg0 <= 18446744073709551615, 104);
        assert!(arg1 >= 4295128739, 103);
        assert!(arg1 <= 79228162514264337593543950336, 103);
        let v0 = if (arg2) {
            arg1 * arg1 / 18446744073709551616
        } else {
            18446744073709551616 / arg1 * arg1
        };
        let v1 = (arg0 as u128) * v0 / 18446744073709551616;
        assert!(v1 <= 18446744073709551615, 104);
        (v1 as u64)
    }

    fun get_pool_sqrt_price(arg0: vector<u8>) : u128 {
        let v0 = 79228162514264337593543950336;
        assert!(v0 >= 4295128739, 103);
        assert!(v0 <= 79228162514264337593543950336, 103);
        v0
    }

    public fun swap_exact_sui_for_token<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 103);
        assert!(0x1::vector::length<u8>(&arg1) > 0, 100);
        assert!(v0 <= 18446744073709551615, 104);
        let v1 = get_pool_sqrt_price(arg1);
        assert!(v1 >= 4295128739, 103);
        assert!(v1 <= 79228162514264337593543950336, 103);
        assert!(calculate_swap_output(v0 - v0 * 3000 / 1000000, v1, true) >= arg2, 102);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
        0x2::coin::zero<T0>(arg3)
    }

    public fun swap_exact_token_for_sui<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 103);
        assert!(0x1::vector::length<u8>(&arg1) > 0, 100);
        assert!(v0 <= 18446744073709551615, 104);
        let v1 = get_pool_sqrt_price(arg1);
        assert!(v1 >= 4295128739, 103);
        assert!(v1 <= 79228162514264337593543950336, 103);
        assert!(calculate_swap_output(v0 - v0 * 3000 / 1000000, v1, false) >= arg2, 102);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
        0x2::coin::zero<0x2::sui::SUI>(arg3)
    }

    public fun validate_pool(arg0: vector<u8>) : bool {
        0x1::vector::length<u8>(&arg0) > 0
    }

    // decompiled from Move bytecode v6
}

