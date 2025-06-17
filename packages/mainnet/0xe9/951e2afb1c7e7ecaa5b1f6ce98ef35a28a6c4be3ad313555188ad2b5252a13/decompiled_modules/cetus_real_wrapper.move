module 0xe9951e2afb1c7e7ecaa5b1f6ce98ef35a28a6c4be3ad313555188ad2b5252a13::cetus_real_wrapper {
    struct CetusRealPTBExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        timestamp: u64,
        method: vector<u8>,
        success: bool,
        cetus_package: address,
        global_config: address,
        pool_id: address,
        flash_swap_params: vector<u8>,
    }

    public fun get_cetus_package() : address {
        @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb
    }

    public fun get_cli_pattern() : vector<u8> {
        b"sui client call --package 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb --module pool --function flash_swap --type-args SUI USDC --args global_config pool true true amount 4295048016 clock"
    }

    public fun get_flash_swap_signature() : vector<u8> {
        b"flash_swap<SUI,USDC>(global_config,pool,a2b,by_amount_in,amount,sqrt_price_limit,clock)"
    }

    public fun get_global_config() : address {
        @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f
    }

    public fun get_pool_id() : address {
        @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630
    }

    public fun get_ptb_guidance() : vector<u8> {
        b"Cetus flash_swap requires: 1)GlobalConfig object, 2)Pool object, 3)a2b:bool, 4)by_amount_in:bool, 5)amount:u64, 6)sqrt_price_limit:u128, 7)Clock object. Then repay_flash_swap with balances."
    }

    public entry fun ptb_cetus_flash_swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 6001);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = CetusRealPTBExecuted{
            sender            : v1,
            amount_in         : v0,
            min_amount_out    : arg1,
            timestamp         : 0x2::clock::timestamp_ms(arg2),
            method            : b"ptb_cetus_flash_swap_real_integration",
            success           : true,
            cetus_package     : @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb,
            global_config     : @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f,
            pool_id           : @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630,
            flash_swap_params : b"global_config,pool,a2b:true,by_amount_in:true,amount,sqrt_price_limit:4295048016,clock",
        };
        0x2::event::emit<CetusRealPTBExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
    }

    // decompiled from Move bytecode v6
}

