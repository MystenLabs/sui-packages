module 0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_turbos {
    fun calculate_output_amount(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 * arg1 / 1000000
    }

    public fun get_pool_info<T0>(arg0: vector<u8>) : (u64, u64, u64) {
        (1000000, 1000000, 3000)
    }

    public fun swap_exact_sui_for_token<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        assert!(calculate_output_amount(v0, 3000) >= arg2, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1);
        0x2::coin::zero<T0>(arg3)
    }

    public fun swap_exact_token_for_sui<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 1);
        assert!(calculate_output_amount(v0, 3000) >= arg2, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1);
        0x2::coin::zero<0x2::sui::SUI>(arg3)
    }

    // decompiled from Move bytecode v6
}

