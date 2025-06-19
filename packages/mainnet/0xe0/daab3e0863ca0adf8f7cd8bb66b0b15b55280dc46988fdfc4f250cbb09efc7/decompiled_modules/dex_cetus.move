module 0xdf13d86e66474b935fafec7d70ed3d32baf962087a94bb083ea71a1325982b1a::dex_cetus {
    struct CetusSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        dex: vector<u8>,
        security_warning: vector<u8>,
    }

    fun execute_cetus_swap(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
    }

    public fun get_cetus_clmm_config() : (u64, u64, bool) {
        (25, 1000, false)
    }

    public fun get_cetus_config() : address {
        @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f
    }

    public fun get_cetus_package() : address {
        0xdf13d86e66474b935fafec7d70ed3d32baf962087a94bb083ea71a1325982b1a::constants::cetus_package()
    }

    public fun get_cetus_pool() : address {
        @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630
    }

    public fun get_security_status() : (bool, vector<u8>) {
        (true, b"external_ptb_execution_security_handled_at_transaction_level")
    }

    public fun is_cetus_safe_to_use() : bool {
        true
    }

    public entry fun swap_sui_to_usdc_cetus(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 6001);
        assert!(arg1 > 0, 6001);
        assert!(is_cetus_safe_to_use(), 6004);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<0x2::sui::SUI>>();
        0x1::vector::push_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut v2, arg0);
        execute_cetus_swap(v2, v0, arg1, arg2, arg3);
        let v3 = CetusSwapExecuted{
            sender           : v1,
            amount_in        : v0,
            min_amount_out   : arg1,
            pool_id          : @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630,
            dex              : b"cetus_clmm",
            security_warning : b"verify_security_status_may_2025_exploit",
        };
        0x2::event::emit<CetusSwapExecuted>(v3);
    }

    // decompiled from Move bytecode v6
}

