module 0xfdf0f43203d265ac8a3db80e13c333307fdeca7533d814493f41b05a48577b73::dex_deepbook {
    public fun calculate_deepbook_output(arg0: u64, arg1: bool) : u64 {
        if (arg1) {
            arg0 * 2890 / 10000000
        } else {
            arg0 * 34580000 / 10000
        }
    }

    public fun get_deepbook_config() : (address, address, address, address) {
        (@0xb29d83c26cdd2a64959263abbcfc4a6937f0c9fccaf98580ca56faded65be244, @0xaf16199a2dff736e9f07a845f23c5da6df6f756eddb631aed9d24a93efc4549d, @0x32abf8948dda67a271bcc18e776dbbcfb0d58c8d288a700ff0d5521e57a1ffe, @0x4406c9bfb1f3a8b1b8c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6)
    }

    public fun get_deepbook_params() : (u64, u64, u64) {
        (1000, 1, 1000)
    }

    public fun is_deepbook_available() : bool {
        true
    }

    public fun swap_sui_to_wusdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xfdf0f43203d265ac8a3db80e13c333307fdeca7533d814493f41b05a48577b73::wusdc::WUSDC> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        assert!(v0 >= 1000, 2);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        0x2::coin::zero<0xfdf0f43203d265ac8a3db80e13c333307fdeca7533d814493f41b05a48577b73::wusdc::WUSDC>(arg1)
    }

    public fun swap_wusdc_to_sui(arg0: 0x2::coin::Coin<0xfdf0f43203d265ac8a3db80e13c333307fdeca7533d814493f41b05a48577b73::wusdc::WUSDC>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0xfdf0f43203d265ac8a3db80e13c333307fdeca7533d814493f41b05a48577b73::wusdc::WUSDC>(&arg0);
        assert!(v0 > 0, 1);
        assert!(v0 >= 1000, 2);
        0x2::coin::destroy_zero<0xfdf0f43203d265ac8a3db80e13c333307fdeca7533d814493f41b05a48577b73::wusdc::WUSDC>(arg0);
        0x2::coin::zero<0x2::sui::SUI>(arg1)
    }

    // decompiled from Move bytecode v6
}

