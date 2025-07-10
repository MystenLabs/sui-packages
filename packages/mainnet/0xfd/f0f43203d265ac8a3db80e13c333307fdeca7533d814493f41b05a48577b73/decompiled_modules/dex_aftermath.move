module 0xfdf0f43203d265ac8a3db80e13c333307fdeca7533d814493f41b05a48577b73::dex_aftermath {
    public fun calculate_aftermath_output(arg0: u64, arg1: bool) : u64 {
        if (arg1) {
            arg0 * 2888 / 10000000
        } else {
            arg0 * 34620000 / 10000
        }
    }

    public fun get_aftermath_config() : (address, address, address) {
        (@0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6, @0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6, @0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6)
    }

    public fun is_aftermath_available() : bool {
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

