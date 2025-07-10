module 0xfdf0f43203d265ac8a3db80e13c333307fdeca7533d814493f41b05a48577b73::dex_bluefin {
    public fun calculate_bluefin_output(arg0: u64, arg1: bool) : u64 {
        if (arg1) {
            arg0 * 2885 / 10000000
        } else {
            arg0 * 34650000 / 10000
        }
    }

    public fun get_bluefin_config() : (address, address, address) {
        (@0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267, @0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267, @0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267)
    }

    public fun is_bluefin_available() : bool {
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

