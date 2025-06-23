module 0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::dex_flowx {
    public(friend) fun call_flowx_swap_sui_to_usdc_external(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC> {
        abort 2002
    }

    public fun swap_sui_to_usdc_flowx(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 2001);
        let v0 = call_flowx_swap_sui_to_usdc_external(arg0, arg1, arg2, arg4);
        assert!(0x2::coin::value<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC>(&v0) >= arg2, 2002);
        v0
    }

    // decompiled from Move bytecode v6
}

