module 0x918f1f88ab599f970be40fc3b707516ca149618a1a269d3c38d2286baafa42a5::atomic_arbitrage {
    struct WUSDC has drop {
        dummy_field: bool,
    }

    public fun calculate_min_profitable_output_with_gas(arg0: u64) : u64 {
        arg0 + arg0 * 1000 / 1000000 + 2500000
    }

    public entry fun execute_real_atomic_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: address, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 >= 100000000, 0);
        let v1 = calculate_min_profitable_output_with_gas(v0);
        assert!(arg4 >= v1, 1);
        let v2 = swap_sui_to_wusdc_cetus(arg0, arg1, arg2, arg3, arg5);
        let v3 = swap_wusdc_to_sui_aftermath(v2, arg5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v3) >= v1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, 0x2::tx_context::sender(arg5));
    }

    public fun swap_sui_to_wusdc_cetus(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<WUSDC> {
        0x2::coin::value<0x2::sui::SUI>(&arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x0);
        0x2::coin::zero<WUSDC>(arg4)
    }

    public fun swap_wusdc_to_sui_aftermath(arg0: 0x2::coin::Coin<WUSDC>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::value<WUSDC>(&arg0);
        0x2::coin::destroy_zero<WUSDC>(arg0);
        0x2::coin::zero<0x2::sui::SUI>(arg1)
    }

    public fun validate_arbitrage_profit(arg0: u64, arg1: u64) : bool {
        if (arg0 < 100000000) {
            return false
        };
        arg1 >= calculate_min_profitable_output_with_gas(arg0)
    }

    // decompiled from Move bytecode v6
}

