module 0x3fdcb0ade234ac1e1f2d1b02ca390be3dd5828a238ff21ff74895c1c74afc914::dex_bluefin {
    struct BluefinSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        method: vector<u8>,
        package: address,
        timestamp: u64,
    }

    public fun calculate_bluefin_fee(arg0: u64) : u64 {
        arg0 * 100 / 1000000
    }

    public fun calculate_min_usdc_output(arg0: u64) : u64 {
        arg0 * 105 / 100 * 95 / 100 / 1000
    }

    public fun get_bluefin_package() : address {
        0x3fdcb0ade234ac1e1f2d1b02ca390be3dd5828a238ff21ff74895c1c74afc914::constants::bluefin_package()
    }

    public fun get_bluefin_sui_usdc_pool() : address {
        @0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312dd
    }

    public fun is_bluefin_operational() : bool {
        0x3fdcb0ade234ac1e1f2d1b02ca390be3dd5828a238ff21ff74895c1c74afc914::constants::bluefin_package() != @0x0
    }

    public entry fun prepare_sui_for_bluefin_ptb(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == arg1, 9001);
        0x2::tx_context::sender(arg2);
        0x2::balance::destroy_zero<0x2::sui::SUI>(0x2::coin::into_balance<0x2::sui::SUI>(arg0));
    }

    public entry fun swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 9001);
        assert!(arg2 > 0, 9004);
        assert!(arg1 != @0x0, 9003);
        let v1 = BluefinSwapExecuted{
            sender         : 0x2::tx_context::sender(arg4),
            amount_in      : v0,
            min_amount_out : arg2,
            pool_id        : arg1,
            method         : b"ptb_external_package_call",
            package        : 0x3fdcb0ade234ac1e1f2d1b02ca390be3dd5828a238ff21ff74895c1c74afc914::constants::bluefin_package(),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BluefinSwapExecuted>(v1);
        0x2::balance::destroy_zero<0x2::sui::SUI>(0x2::coin::into_balance<0x2::sui::SUI>(arg0));
    }

    public fun validate_bluefin_ptb_params(arg0: u64, arg1: u64, arg2: address) : bool {
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

