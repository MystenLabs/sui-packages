module 0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_bluefin {
    public fun calculate_min_output_with_slippage(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 5000, 300);
        arg0 * (10000 - arg1) / 10000
    }

    fun get_pool_sqrt_price(arg0: vector<u8>) : u128 {
        if (0x1::vector::length<u8>(&arg0) > 0) {
            79228162514264337593543950336
        } else {
            4295128739
        }
    }

    public fun swap_exact_sui_for_token<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 300);
        assert!(0x1::vector::length<u8>(&arg1) > 0, 303);
        assert!(v0 <= 9223372036854775807, 300);
        assert!(v0 - v0 * 3000 / 1000000 >= arg2, 302);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
        0x2::coin::zero<T0>(arg3)
    }

    public fun swap_exact_token_for_sui<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 300);
        assert!(0x1::vector::length<u8>(&arg1) > 0, 303);
        assert!(v0 <= 9223372036854775807, 300);
        assert!(v0 - v0 * 3000 / 1000000 >= arg2, 302);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
        0x2::coin::zero<0x2::sui::SUI>(arg3)
    }

    // decompiled from Move bytecode v6
}

