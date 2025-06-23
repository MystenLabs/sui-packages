module 0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::dex_kriya {
    public fun calculate_min_output_kriya(arg0: u64, arg1: bool, arg2: u64) : u64 {
        let v0 = if (arg1) {
            arg0 * 2500000 / 1000000000
        } else {
            arg0 * 385000000 / 1000000
        };
        v0 * (10000 - arg2) / 10000
    }

    public(friend) fun call_kriya_swap_sui_to_usdc_external(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC> {
        abort 8002
    }

    public(friend) fun call_kriya_swap_usdc_to_sui_external(arg0: address, arg1: 0x2::coin::Coin<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        abort 8002
    }

    public fun swap_sui_to_usdc_kriya(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 8001);
        let v0 = call_kriya_swap_sui_to_usdc_external(arg0, arg1, arg2, arg4);
        assert!(0x2::coin::value<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC>(&v0) >= arg2, 8002);
        v0
    }

    public fun swap_usdc_to_sui_kriya(arg0: address, arg1: 0x2::coin::Coin<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC>(&arg1) > 0, 8001);
        let v0 = call_kriya_swap_usdc_to_sui_external(arg0, arg1, arg2, arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v0) >= arg2, 8002);
        v0
    }

    // decompiled from Move bytecode v6
}

