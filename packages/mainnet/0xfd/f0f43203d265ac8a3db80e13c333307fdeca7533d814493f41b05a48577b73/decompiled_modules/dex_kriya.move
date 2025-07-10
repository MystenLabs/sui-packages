module 0xfdf0f43203d265ac8a3db80e13c333307fdeca7533d814493f41b05a48577b73::dex_kriya {
    public fun calculate_kriya_output(arg0: u64, arg1: bool) : u64 {
        if (arg1) {
            arg0 * 2890 / 10000000
        } else {
            arg0 * 34600000 / 10000
        }
    }

    public fun get_kriya_config() : (address, address, address) {
        (@0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66, @0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66, @0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66)
    }

    public fun is_kriya_available() : bool {
        true
    }

    public fun swap_sui_to_wusdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xfdf0f43203d265ac8a3db80e13c333307fdeca7533d814493f41b05a48577b73::wusdc::WUSDC> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) > 0, 1);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        0x2::coin::zero<0xfdf0f43203d265ac8a3db80e13c333307fdeca7533d814493f41b05a48577b73::wusdc::WUSDC>(arg1)
    }

    public fun swap_wusdc_to_sui(arg0: 0x2::coin::Coin<0xfdf0f43203d265ac8a3db80e13c333307fdeca7533d814493f41b05a48577b73::wusdc::WUSDC>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<0xfdf0f43203d265ac8a3db80e13c333307fdeca7533d814493f41b05a48577b73::wusdc::WUSDC>(&arg0) > 0, 1);
        0x2::coin::destroy_zero<0xfdf0f43203d265ac8a3db80e13c333307fdeca7533d814493f41b05a48577b73::wusdc::WUSDC>(arg0);
        0x2::coin::zero<0x2::sui::SUI>(arg1)
    }

    // decompiled from Move bytecode v6
}

