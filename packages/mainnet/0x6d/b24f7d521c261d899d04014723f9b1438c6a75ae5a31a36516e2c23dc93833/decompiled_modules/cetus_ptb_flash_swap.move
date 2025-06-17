module 0x6db24f7d521c261d899d04014723f9b1438c6a75ae5a31a36516e2c23dc93833::cetus_ptb_flash_swap {
    struct CetusPTBFlashSwapExecuted has copy, drop {
        sender: address,
        pool_id: address,
        amount_in: u64,
        sqrt_price_limit: u128,
        swap_direction: bool,
        method: vector<u8>,
        success: bool,
    }

    fun execute_cetus_ptb_flash_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u128, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg5));
    }

    fun execute_cetus_ptb_flash_swap_reverse<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u128, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg5));
    }

    public fun get_cetus_config() : (address, address, address) {
        (@0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb, @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f, @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630)
    }

    public fun get_pool_info() : (address, vector<u8>, u64) {
        (@0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630, b"SUI-USDC CLMM Pool", 2500)
    }

    public fun is_valid_pool(arg0: address) : bool {
        arg0 == @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630
    }

    public entry fun ptb_flash_swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= arg1, 8001);
        execute_cetus_ptb_flash_swap(arg0, arg1, arg2, true, arg3, arg4);
        let v1 = CetusPTBFlashSwapExecuted{
            sender           : v0,
            pool_id          : @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630,
            amount_in        : arg1,
            sqrt_price_limit : arg2,
            swap_direction   : true,
            method           : b"cetus_ptb_flash_swap_sui_usdc",
            success          : true,
        };
        0x2::event::emit<CetusPTBFlashSwapExecuted>(v1);
    }

    public entry fun ptb_flash_swap_usdc_to_sui<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 8001);
        execute_cetus_ptb_flash_swap_reverse<T0>(arg0, arg1, arg2, false, arg3, arg4);
        let v1 = CetusPTBFlashSwapExecuted{
            sender           : v0,
            pool_id          : @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630,
            amount_in        : arg1,
            sqrt_price_limit : arg2,
            swap_direction   : false,
            method           : b"cetus_ptb_flash_swap_usdc_sui",
            success          : true,
        };
        0x2::event::emit<CetusPTBFlashSwapExecuted>(v1);
    }

    public fun validate_flash_swap_params(arg0: u64, arg1: u128) : bool {
        arg0 > 0 && arg1 > 0
    }

    // decompiled from Move bytecode v6
}

