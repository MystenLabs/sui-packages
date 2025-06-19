module 0xdf13d86e66474b935fafec7d70ed3d32baf962087a94bb083ea71a1325982b1a::dex_proven {
    struct RealSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        method: vector<u8>,
        package: address,
    }

    fun execute_proven_swap(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun get_proven_package() : address {
        0xdf13d86e66474b935fafec7d70ed3d32baf962087a94bb083ea71a1325982b1a::constants::proven_swap_package()
    }

    public fun get_verified_transactions() : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"B3Bu5oLJWyAuHYUaS8FHytDkkoEZygynzEcJCs5zYJVs");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"3T319189K4K9FXhjp7bRcFGEcfUBBLyY9LJfpY2a33cs");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"H2yfd1qpnaK83M27SV6aCZ1YstaU95skGwaWbytztBpo");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"BKkvqiYPrWDbV7j9aWgRPi1L4WeVveDviTMq9TQre1xf");
        v0
    }

    public entry fun swap_sui_to_usdc_real(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 4001);
        assert!(arg2 > 0, 4001);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<0x2::sui::SUI>>();
        0x1::vector::push_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut v2, arg0);
        execute_proven_swap(v2, v0, arg2, arg3, arg4);
        let v3 = RealSwapExecuted{
            sender         : v1,
            amount_in      : v0,
            min_amount_out : arg2,
            pool_id        : 0xdf13d86e66474b935fafec7d70ed3d32baf962087a94bb083ea71a1325982b1a::constants::proven_sui_usdc_pool(),
            method         : b"real_swap_x_to_y",
            package        : 0xdf13d86e66474b935fafec7d70ed3d32baf962087a94bb083ea71a1325982b1a::constants::proven_swap_package(),
        };
        0x2::event::emit<RealSwapExecuted>(v3);
    }

    // decompiled from Move bytecode v6
}

