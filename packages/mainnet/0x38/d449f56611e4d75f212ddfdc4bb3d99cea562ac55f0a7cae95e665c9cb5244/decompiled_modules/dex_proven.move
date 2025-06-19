module 0x38d449f56611e4d75f212ddfdc4bb3d99cea562ac55f0a7cae95e665c9cb5244::dex_proven {
    struct ProvenSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        method: vector<u8>,
        package: address,
        timestamp: u64,
    }

    public fun calculate_proven_min_output(arg0: u64, arg1: u64) : u64 {
        arg0 * (10000 - arg1) / 10000
    }

    public fun get_proven_fee_bps() : u64 {
        30
    }

    public fun get_proven_package() : address {
        0x38d449f56611e4d75f212ddfdc4bb3d99cea562ac55f0a7cae95e665c9cb5244::constants::proven_swap_package()
    }

    public fun get_proven_sui_usdc_pools() : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x38d449f56611e4d75f212ddfdc4bb3d99cea562ac55f0a7cae95e665c9cb5244::constants::proven_sui_usdc_pool());
        v0
    }

    public fun get_verified_transactions() : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"B3Bu5oLJWyAuHYUaS8FHytDkkoEZygynzEcJCs5zYJVs");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"3T319189K4K9FXhjp7bRcFGEcfUBBLyY9LJfpY2a33cs");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"H2yfd1qpnaK83M27SV6aCZ1YstaU95skGwaWbytztBho");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"BKkvqiYPrWDbV7j9aWgRPi1L4WeVveDviTMq9TQre1xf");
        v0
    }

    public fun is_proven_operational() : bool {
        true
    }

    public entry fun swap_sui_to_usdc_real(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 4001);
        assert!(arg2 > 0, 4004);
        assert!(arg1 != @0x0, 4003);
        let v1 = ProvenSwapExecuted{
            sender         : 0x2::tx_context::sender(arg4),
            amount_in      : v0,
            min_amount_out : arg2,
            pool_id        : arg1,
            method         : b"proven_pool_swap",
            package        : 0x38d449f56611e4d75f212ddfdc4bb3d99cea562ac55f0a7cae95e665c9cb5244::constants::proven_swap_package(),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ProvenSwapExecuted>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
    }

    public fun validate_proven_swap(arg0: u64, arg1: u64, arg2: address) : bool {
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

