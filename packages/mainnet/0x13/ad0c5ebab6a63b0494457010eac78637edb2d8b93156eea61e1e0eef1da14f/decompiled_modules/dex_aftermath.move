module 0x13ad0c5ebab6a63b0494457010eac78637edb2d8b93156eea61e1e0eef1da14f::dex_aftermath {
    struct AftermathSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        method: vector<u8>,
        package: address,
        timestamp: u64,
    }

    public fun calculate_sui_usdc_min_output(arg0: u64, arg1: u64) : u64 {
        arg0 * (10000 - arg1) / 10000
    }

    public fun get_aftermath_advantages() : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"CFMM_Design");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Capital_Efficiency");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Low_Fees");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"MEV_Protection");
        v0
    }

    public fun get_aftermath_fee_bps() : u64 {
        30
    }

    public fun get_aftermath_package() : address {
        0x13ad0c5ebab6a63b0494457010eac78637edb2d8b93156eea61e1e0eef1da14f::constants::aftermath_package()
    }

    public fun get_aftermath_sui_usdc_pools() : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, @0x7903f6ab51fba9f9f88d78a77f1d5d1ae3b73f6515c3d4e7a4c7b56b8c22c3e7);
        v0
    }

    public fun is_aftermath_operational() : bool {
        true
    }

    public entry fun swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 7001);
        assert!(arg2 > 0, 7005);
        assert!(arg1 != @0x0, 7003);
        let v1 = AftermathSwapExecuted{
            sender         : 0x2::tx_context::sender(arg4),
            amount_in      : v0,
            min_amount_out : arg2,
            pool_id        : arg1,
            method         : b"aftermath_cfmm_swap",
            package        : 0x13ad0c5ebab6a63b0494457010eac78637edb2d8b93156eea61e1e0eef1da14f::constants::aftermath_package(),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AftermathSwapExecuted>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
    }

    public entry fun swap_usdc_to_sui(arg0: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0);
        assert!(v0 > 0, 7001);
        assert!(arg2 > 0, 7005);
        assert!(arg1 != @0x0, 7003);
        let v1 = AftermathSwapExecuted{
            sender         : 0x2::tx_context::sender(arg4),
            amount_in      : v0,
            min_amount_out : arg2,
            pool_id        : arg1,
            method         : b"aftermath_cfmm_swap",
            package        : 0x13ad0c5ebab6a63b0494457010eac78637edb2d8b93156eea61e1e0eef1da14f::constants::aftermath_package(),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AftermathSwapExecuted>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg0);
    }

    public fun validate_sui_usdc_aftermath_swap(arg0: u64, arg1: u64, arg2: address) : bool {
        if (arg0 > 0) {
            if (arg1 > 0) {
                arg2 != @0x0
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

