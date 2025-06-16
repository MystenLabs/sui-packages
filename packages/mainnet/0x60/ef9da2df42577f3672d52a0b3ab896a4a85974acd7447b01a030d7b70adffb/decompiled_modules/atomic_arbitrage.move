module 0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::atomic_arbitrage {
    public entry fun demo_bluefin_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 700);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::dex_bluefin::validate_swap_params(v0, arg1, v1 + 300000, v1), 702);
        0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::dex_bluefin::swap_sui_to_usdc(arg0, arg1, arg2, arg3);
    }

    public entry fun demo_cetus_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 700);
        assert!(0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::dex_cetus::validate_cetus_swap(v0, 0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::dex_cetus::get_sqrt_price_limit()), 701);
        0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::dex_cetus::swap_sui_to_usdc(arg0, arg1, arg2);
    }

    public fun get_bluefin_package() : address {
        0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::dex_bluefin::get_bluefin_package()
    }

    public fun get_cetus_package() : address {
        0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::dex_cetus::get_cetus_package()
    }

    public fun get_sqrt_price_limit() : u128 {
        0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::dex_cetus::get_sqrt_price_limit()
    }

    public entry fun swap_tokens_aftermath(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 700);
        assert!(0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::dex_aftermath::validate_aftermath_swap(v0, arg1), 701);
        0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::dex_aftermath::swap_sui_to_usdc(arg0, arg1, arg2);
    }

    public entry fun swap_tokens_deepbook(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 700);
        assert!(0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::dex_deepbook::validate_deepbook_swap(v0, arg1), 701);
        0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::dex_deepbook::swap_sui_to_usdc(arg0, arg1, arg2);
    }

    public entry fun swap_tokens_kriya(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 700);
        assert!(0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::dex_kriya::validate_kriya_swap(v0, arg1), 701);
        0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::dex_kriya::swap_sui_to_usdc(arg0, arg1, arg2);
    }

    public entry fun swap_tokens_turbos(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 700);
        assert!(0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::dex_turbos::validate_turbos_swap(v0, arg1), 701);
        0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::dex_turbos::swap_sui_to_usdc(arg0, arg1, arg2);
    }

    public entry fun test_contract_deployment(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) > 0, 700);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun validate_bluefin_arbitrage(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        if (arg0 > 0) {
            if (arg3 <= arg2) {
                if (arg1 > 0) {
                    0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::dex_bluefin::validate_swap_params(arg0, arg1, arg2, arg3)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun validate_cetus_arbitrage(arg0: u64, arg1: u128) : bool {
        0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::dex_cetus::validate_cetus_swap(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

