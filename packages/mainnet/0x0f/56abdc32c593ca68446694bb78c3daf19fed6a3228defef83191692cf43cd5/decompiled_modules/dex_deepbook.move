module 0xf56abdc32c593ca68446694bb78c3daf19fed6a3228defef83191692cf43cd5::dex_deepbook {
    public fun get_deepbook_config() : (address, address, address, address) {
        (@0xb29d83c26cdd2a64959263abbcfc4a6937f0c9fccaf98580ca56faded65be244, @0xaf16199a2dff736e9f07a845f23c5da6df6f756eddb631aed9d24a93efc4549d, @0x32abf8948dda67a271bcc18e776dbbcfb0d58c8d288a700ff0d5521e57a1ffe, @0xe05dafb5133bcffb8d59f4e12465dc0e9faeaa05e3e342a08fe135800e3e4407)
    }

    public fun get_deepbook_params() : (u64, u64, u64) {
        (1000, 1, 1000)
    }

    public fun is_deepbook_available() : bool {
        true
    }

    public fun swap_sui_to_wusdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf56abdc32c593ca68446694bb78c3daf19fed6a3228defef83191692cf43cd5::wusdc::WUSDC> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        assert!(v0 >= 1000, 3);
        abort 99
    }

    public fun swap_wusdc_to_sui(arg0: 0x2::coin::Coin<0xf56abdc32c593ca68446694bb78c3daf19fed6a3228defef83191692cf43cd5::wusdc::WUSDC>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0xf56abdc32c593ca68446694bb78c3daf19fed6a3228defef83191692cf43cd5::wusdc::WUSDC>(&arg0);
        assert!(v0 > 0, 1);
        assert!(v0 >= 1000, 3);
        abort 99
    }

    // decompiled from Move bytecode v6
}

