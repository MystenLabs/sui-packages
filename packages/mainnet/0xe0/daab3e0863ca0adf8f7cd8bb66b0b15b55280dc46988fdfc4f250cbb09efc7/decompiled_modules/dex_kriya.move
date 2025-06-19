module 0xdf13d86e66474b935fafec7d70ed3d32baf962087a94bb083ea71a1325982b1a::dex_kriya {
    struct KriyaSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        method: vector<u8>,
        package: address,
        timestamp: u64,
    }

    public fun calculate_min_output(arg0: u64, arg1: u64) : u64 {
        arg0 * (10000 - arg1) / 10000
    }

    fun execute_kriya_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg4));
    }

    public fun get_kriya_amm_contract() : address {
        0xdf13d86e66474b935fafec7d70ed3d32baf962087a94bb083ea71a1325982b1a::constants::kriya_amm_contract()
    }

    public fun get_kriya_fee_bps() : u64 {
        30
    }

    public fun get_kriya_package() : address {
        0xdf13d86e66474b935fafec7d70ed3d32baf962087a94bb083ea71a1325982b1a::constants::kriya_package()
    }

    public entry fun swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 5001);
        assert!(arg2 > 0, 5004);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(arg1 != @0x0, 5003);
        execute_kriya_swap(arg0, arg1, v0, arg2, arg4);
        let v2 = KriyaSwapExecuted{
            sender         : v1,
            amount_in      : v0,
            min_amount_out : arg2,
            pool_id        : arg1,
            method         : b"kriya_amm_swap",
            package        : 0xdf13d86e66474b935fafec7d70ed3d32baf962087a94bb083ea71a1325982b1a::constants::kriya_package(),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<KriyaSwapExecuted>(v2);
    }

    public fun validate_kriya_swap(arg0: u64, arg1: u64, arg2: address) : bool {
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

