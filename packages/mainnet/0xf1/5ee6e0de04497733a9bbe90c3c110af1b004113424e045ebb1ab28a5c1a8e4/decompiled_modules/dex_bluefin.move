module 0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::dex_bluefin {
    public fun calculate_sqrt_price_limit(arg0: bool, arg1: u64) : u128 {
        if (arg0) {
            79226673515401279992447579055
        } else {
            79428396330099149780
        }
    }

    public(friend) fun call_bluefin_swap_sui_to_usdc_external(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC> {
        abort 5002
    }

    public(friend) fun call_bluefin_swap_usdc_to_sui_external(arg0: address, arg1: 0x2::coin::Coin<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC>, arg2: u64, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        abort 5002
    }

    public fun swap_sui_to_usdc_bluefin(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 5001);
        let v0 = call_bluefin_swap_sui_to_usdc_external(arg0, arg1, arg2, arg3, arg5);
        assert!(0x2::coin::value<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC>(&v0) >= arg2, 5002);
        v0
    }

    public fun swap_usdc_to_sui_bluefin(arg0: address, arg1: 0x2::coin::Coin<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC>(&arg1) > 0, 5001);
        let v0 = call_bluefin_swap_usdc_to_sui_external(arg0, arg1, arg2, arg3, arg5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v0) >= arg2, 5002);
        v0
    }

    // decompiled from Move bytecode v6
}

