module 0xf56abdc32c593ca68446694bb78c3daf19fed6a3228defef83191692cf43cd5::dex_cetus {
    public fun get_cetus_config() : (address, address, address) {
        (@0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb, @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f, @0x2e041f3fd93646dcc877f783c1f2b7fa62d30271bdef1f21ef002cebf857bded)
    }

    public fun get_cetus_params() : (u128, u64) {
        (4295128739, 1000)
    }

    public fun is_cetus_available() : bool {
        true
    }

    public fun swap_sui_to_wusdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf56abdc32c593ca68446694bb78c3daf19fed6a3228defef83191692cf43cd5::wusdc::WUSDC> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        assert!(v0 >= 1000, 4);
        abort 99
    }

    public fun swap_wusdc_to_sui(arg0: 0x2::coin::Coin<0xf56abdc32c593ca68446694bb78c3daf19fed6a3228defef83191692cf43cd5::wusdc::WUSDC>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0xf56abdc32c593ca68446694bb78c3daf19fed6a3228defef83191692cf43cd5::wusdc::WUSDC>(&arg0);
        assert!(v0 > 0, 1);
        assert!(v0 >= 1000, 4);
        abort 99
    }

    // decompiled from Move bytecode v6
}

