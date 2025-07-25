module 0xafec07ab7f5295b54f6670acd6212fcdd38b528e7aa5adcd05819fbb1ef9e1d9::dex_turbos {
    struct TurbosSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        fee_tier: u64,
        method: vector<u8>,
        package: address,
        timestamp: u64,
    }

    public entry fun arb_sui_usdc_turbos(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 8001);
        assert!(arg2 > 0, 8004);
        let v1 = TurbosSwapExecuted{
            sender         : 0x2::tx_context::sender(arg4),
            amount_in      : v0,
            min_amount_out : arg2,
            pool_id        : arg1,
            fee_tier       : 3000,
            method         : b"turbos_clmm_arb",
            package        : 0xafec07ab7f5295b54f6670acd6212fcdd38b528e7aa5adcd05819fbb1ef9e1d9::constants::turbos_package(),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TurbosSwapExecuted>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
    }

    public fun calculate_sui_usdc_min_output(arg0: u64, arg1: u64) : u64 {
        arg0 * (10000 - arg1) / 10000
    }

    public fun get_turbos_fee_bps() : u64 {
        30
    }

    public fun get_turbos_package() : address {
        0xafec07ab7f5295b54f6670acd6212fcdd38b528e7aa5adcd05819fbb1ef9e1d9::constants::turbos_package()
    }

    public fun get_turbos_sui_usdc_pools() : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78);
        0x1::vector::push_back<address>(&mut v0, @0x87c47f06b3fee0aaa1e6217ea5b935caf2721763d91ac49bb04b04bb69c4d41a);
        v0
    }

    public entry fun swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 8001);
        assert!(arg2 > 0, 8004);
        assert!(arg1 != @0x0, 8003);
        let v1 = TurbosSwapExecuted{
            sender         : 0x2::tx_context::sender(arg4),
            amount_in      : v0,
            min_amount_out : arg2,
            pool_id        : arg1,
            fee_tier       : 3000,
            method         : b"turbos_clmm_swap",
            package        : 0xafec07ab7f5295b54f6670acd6212fcdd38b528e7aa5adcd05819fbb1ef9e1d9::constants::turbos_package(),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TurbosSwapExecuted>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
    }

    public fun validate_sui_usdc_turbos_swap(arg0: u64, arg1: u64, arg2: address) : bool {
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

