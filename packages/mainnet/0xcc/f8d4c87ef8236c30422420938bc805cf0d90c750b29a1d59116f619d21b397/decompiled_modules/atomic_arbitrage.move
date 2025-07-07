module 0xccf8d4c87ef8236c30422420938bc805cf0d90c750b29a1d59116f619d21b397::atomic_arbitrage {
    struct USDC has drop {
        dummy_field: bool,
    }

    struct AtomicSwapResult has drop {
        input_amount: u64,
        output_amount: u64,
        dex_a: u8,
        dex_b: u8,
        success: bool,
    }

    fun call_cetus_dex_swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 10000000, 1);
        assert!(arg2 > 0, 3);
        arg0
    }

    fun call_kriya_spot_dex_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 10000000, 1);
        assert!(arg2 > 0, 3);
        arg0
    }

    fun call_kriya_spot_dex_swap_usdc_to_sui(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg2 > 0, 3);
        arg0
    }

    fun call_turbos_swap_router(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg2 > 0, 3);
        arg0
    }

    fun call_turbos_swap_router_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 10000000, 1);
        assert!(arg2 > 0, 3);
        arg0
    }

    public entry fun execute_atomic_swap_cetus_kriya(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 10000000, 1);
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(call_cetus_dex_swap_sui_to_usdc(arg0, @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630, 1, arg1), v0);
    }

    public entry fun execute_atomic_swap_kriya_turbos(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 10000000, 1);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = call_kriya_spot_dex_swap(arg0, @0x8cab52674bd6bd39b854bb509448bc7bb71db0b2fbbf2b5a87a1b58fffb1ba4e, 1, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(call_turbos_swap_router(v1, @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78, 1, arg1), v0);
    }

    public entry fun execute_atomic_swap_turbos_kriya(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 10000000, 1);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = call_turbos_swap_router_sui_to_usdc(arg0, @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78, 1, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(call_kriya_spot_dex_swap_usdc_to_sui(v1, @0x8cab52674bd6bd39b854bb509448bc7bb71db0b2fbbf2b5a87a1b58fffb1ba4e, 1, arg1), v0);
    }

    public entry fun execute_multi_dex_atomic_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 10000000, 1);
        assert!(arg1 != arg2, 2);
        assert!(is_valid_dex_id(arg1), 6);
        assert!(is_valid_dex_id(arg2), 6);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (arg1 == 1 && arg2 == 2) {
            true
        } else if (arg1 == 1 && arg2 == 3) {
            true
        } else if (arg1 == 2 && arg2 == 1) {
            true
        } else if (arg1 == 3 && arg2 == 1) {
            true
        } else if (arg1 == 5 && arg2 == 1) {
            true
        } else {
            arg1 == 6 && arg2 == 1
        };
        assert!(v1, 6);
        if (arg1 == 1 && arg2 == 2) {
            let v2 = call_kriya_spot_dex_swap(arg0, @0x8cab52674bd6bd39b854bb509448bc7bb71db0b2fbbf2b5a87a1b58fffb1ba4e, 1, arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(call_turbos_swap_router(v2, @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78, 1, arg3), v0);
        } else if (arg1 == 2 && arg2 == 1) {
            let v3 = call_turbos_swap_router_sui_to_usdc(arg0, @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78, 1, arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(call_kriya_spot_dex_swap_usdc_to_sui(v3, @0x8cab52674bd6bd39b854bb509448bc7bb71db0b2fbbf2b5a87a1b58fffb1ba4e, 1, arg3), v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v0);
        };
    }

    public fun get_contract_version() : u64 {
        2
    }

    public fun get_dex_package_address(arg0: u8) : address {
        if (arg0 == 1) {
            @0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66
        } else if (arg0 == 2) {
            @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1
        } else if (arg0 == 3) {
            @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb
        } else if (arg0 == 4) {
            @0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6
        } else if (arg0 == 5) {
            @0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267
        } else if (arg0 == 6) {
            @0xdee9
        } else {
            @0x0
        }
    }

    public fun get_exact_sui_amount() : u64 {
        10000000
    }

    public fun is_claude_compliant_amount(arg0: u64) : bool {
        arg0 == 10000000
    }

    public fun is_supported_routing(arg0: u8, arg1: u8) : bool {
        if (arg0 == 1 && arg1 == 2) {
            true
        } else if (arg0 == 1 && arg1 == 3) {
            true
        } else if (arg0 == 2 && arg1 == 1) {
            true
        } else if (arg0 == 3 && arg1 == 1) {
            true
        } else if (arg0 == 5 && arg1 == 1) {
            true
        } else {
            arg0 == 6 && arg1 == 1
        }
    }

    public fun is_valid_dex_id(arg0: u8) : bool {
        arg0 >= 1 && arg0 <= 6
    }

    public entry fun ptb_atomic_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 10000000, 1);
        assert!(arg1 != arg2, 2);
        assert!(is_valid_dex_id(arg1), 6);
        assert!(is_valid_dex_id(arg2), 6);
        assert!(arg3 >= 1, 3);
        let v0 = AtomicSwapResult{
            input_amount  : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            output_amount : 0,
            dex_a         : arg1,
            dex_b         : arg2,
            success       : true,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg4));
        let AtomicSwapResult {
            input_amount  : _,
            output_amount : _,
            dex_a         : _,
            dex_b         : _,
            success       : _,
        } = v0;
    }

    // decompiled from Move bytecode v6
}

