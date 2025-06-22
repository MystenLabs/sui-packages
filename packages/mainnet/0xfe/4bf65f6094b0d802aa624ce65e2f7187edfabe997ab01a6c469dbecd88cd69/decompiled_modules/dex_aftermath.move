module 0xfe4bf65f6094b0d802aa624ce65e2f7187edfabe997ab01a6c469dbecd88cd69::dex_aftermath {
    struct USDC has drop {
        dummy_field: bool,
    }

    public(friend) fun call_aftermath_swap_sui_to_usdc_external(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<USDC> {
        abort 7002
    }

    public(friend) fun call_aftermath_swap_usdc_to_sui_external(arg0: address, arg1: 0x2::coin::Coin<USDC>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        abort 7002
    }

    public fun swap_sui_to_usdc_aftermath(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<USDC> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 7001);
        let v0 = call_aftermath_swap_sui_to_usdc_external(arg0, arg1, arg2, arg3, arg5);
        assert!(0x2::coin::value<USDC>(&v0) >= arg2, 7002);
        v0
    }

    public fun swap_usdc_to_sui_aftermath(arg0: address, arg1: 0x2::coin::Coin<USDC>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<USDC>(&arg1) > 0, 7001);
        let v0 = call_aftermath_swap_usdc_to_sui_external(arg0, arg1, arg2, arg3, arg5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v0) >= arg2, 7002);
        v0
    }

    // decompiled from Move bytecode v6
}

