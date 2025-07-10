module 0xfdf0f43203d265ac8a3db80e13c333307fdeca7533d814493f41b05a48577b73::dex_cetus {
    public fun calculate_cetus_output(arg0: u64, arg1: bool) : u64 {
        if (arg1) {
            arg0 * 2892 / 10000000
        } else {
            arg0 * 34580000 / 10000
        }
    }

    public fun get_cetus_config() : (address, address, address) {
        (@0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb, @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f, @0x2e041f3fd93646dcc877f783c1f2b7fa62d30271bdef1f21ef002cebf857bded)
    }

    public fun get_cetus_params() : (u128, u64) {
        (4295128739, 1000)
    }

    public fun is_cetus_available() : bool {
        true
    }

    public fun swap_sui_to_wusdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xfdf0f43203d265ac8a3db80e13c333307fdeca7533d814493f41b05a48577b73::wusdc::WUSDC> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        assert!(v0 >= 1000, 4);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        0x2::coin::zero<0xfdf0f43203d265ac8a3db80e13c333307fdeca7533d814493f41b05a48577b73::wusdc::WUSDC>(arg1)
    }

    public fun swap_wusdc_to_sui(arg0: 0x2::coin::Coin<0xfdf0f43203d265ac8a3db80e13c333307fdeca7533d814493f41b05a48577b73::wusdc::WUSDC>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0xfdf0f43203d265ac8a3db80e13c333307fdeca7533d814493f41b05a48577b73::wusdc::WUSDC>(&arg0);
        assert!(v0 > 0, 1);
        assert!(v0 >= 1000, 4);
        0x2::coin::destroy_zero<0xfdf0f43203d265ac8a3db80e13c333307fdeca7533d814493f41b05a48577b73::wusdc::WUSDC>(arg0);
        0x2::coin::zero<0x2::sui::SUI>(arg1)
    }

    // decompiled from Move bytecode v6
}

