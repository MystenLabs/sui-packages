module 0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::dex_aftermath {
    public(friend) fun call_aftermath_swap_sui_to_usdc_external(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC> {
        abort 7002
    }

    public(friend) fun call_aftermath_swap_usdc_to_sui_external(arg0: address, arg1: 0x2::coin::Coin<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        abort 7002
    }

    public fun swap_sui_to_usdc_aftermath(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 7001);
        let v0 = call_aftermath_swap_sui_to_usdc_external(arg0, arg1, arg2, arg3, arg5);
        assert!(0x2::coin::value<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC>(&v0) >= arg2, 7002);
        v0
    }

    public fun swap_usdc_to_sui_aftermath(arg0: address, arg1: 0x2::coin::Coin<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC>(&arg1) > 0, 7001);
        let v0 = call_aftermath_swap_usdc_to_sui_external(arg0, arg1, arg2, arg3, arg5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v0) >= arg2, 7002);
        v0
    }

    // decompiled from Move bytecode v6
}

