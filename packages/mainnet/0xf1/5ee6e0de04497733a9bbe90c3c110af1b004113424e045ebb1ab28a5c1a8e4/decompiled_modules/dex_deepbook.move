module 0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::dex_deepbook {
    public(friend) fun call_deepbook_swap_sui_to_usdc_external(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC> {
        abort 6002
    }

    public(friend) fun call_deepbook_swap_usdc_to_sui_external(arg0: address, arg1: 0x2::coin::Coin<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC>, arg2: u64, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        abort 6002
    }

    public fun swap_sui_to_usdc_deepbook(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 6001);
        let v0 = call_deepbook_swap_sui_to_usdc_external(arg0, arg1, arg2, arg3, arg4, arg6);
        assert!(0x2::coin::value<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC>(&v0) >= arg2, 6002);
        v0
    }

    public fun swap_usdc_to_sui_deepbook(arg0: address, arg1: 0x2::coin::Coin<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC>, arg2: u64, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC>(&arg1) > 0, 6001);
        let v0 = call_deepbook_swap_usdc_to_sui_external(arg0, arg1, arg2, arg3, arg4, arg6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v0) >= arg2, 6002);
        v0
    }

    // decompiled from Move bytecode v6
}

