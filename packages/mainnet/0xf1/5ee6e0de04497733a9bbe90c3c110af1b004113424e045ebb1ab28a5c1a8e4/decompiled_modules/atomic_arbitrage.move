module 0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::atomic_arbitrage {
    struct AtomicArbitrageExecuted has copy, drop {
        sender: address,
        input_amount: u64,
        output_amount: u64,
        profit: u64,
        dex_a: vector<u8>,
        dex_b: vector<u8>,
        timestamp: u64,
    }

    public entry fun arb_flowx_turbos(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: address, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v1 > 0, 1001);
        let v2 = 0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::dex_flowx::swap_sui_to_usdc_flowx(arg1, arg0, v1 * 2500 / 1000000000, arg5, arg6);
        let v3 = call_turbos_swap_usdc_to_sui_external(arg2, v2, 0x2::coin::value<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC>(&v2) * 385000000 / 1000000, arg4, arg6);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&v3);
        assert!(v4 > v1 + arg3, 1002);
        let v5 = AtomicArbitrageExecuted{
            sender        : v0,
            input_amount  : v1,
            output_amount : v4,
            profit        : v4 - v1,
            dex_a         : b"FLOWX",
            dex_b         : b"TURBOS",
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, v0);
    }

    public(friend) fun call_turbos_swap_usdc_to_sui_external(arg0: address, arg1: 0x2::coin::Coin<0xf15ee6e0de04497733a9bbe90c3c110af1b004113424e045ebb1ab28a5c1a8e4::usdc::USDC>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        abort 1003
    }

    // decompiled from Move bytecode v6
}

