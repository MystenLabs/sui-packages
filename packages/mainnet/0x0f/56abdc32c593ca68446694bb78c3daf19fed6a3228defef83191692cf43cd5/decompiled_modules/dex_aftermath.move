module 0xf56abdc32c593ca68446694bb78c3daf19fed6a3228defef83191692cf43cd5::dex_aftermath {
    public fun get_aftermath_config() : (address, address, address) {
        (@0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6, @0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6, @0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6)
    }

    public fun is_aftermath_available() : bool {
        true
    }

    public fun swap_sui_to_wusdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf56abdc32c593ca68446694bb78c3daf19fed6a3228defef83191692cf43cd5::wusdc::WUSDC> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) > 0, 1);
        abort 99
    }

    public fun swap_wusdc_to_sui(arg0: 0x2::coin::Coin<0xf56abdc32c593ca68446694bb78c3daf19fed6a3228defef83191692cf43cd5::wusdc::WUSDC>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<0xf56abdc32c593ca68446694bb78c3daf19fed6a3228defef83191692cf43cd5::wusdc::WUSDC>(&arg0) > 0, 1);
        abort 99
    }

    // decompiled from Move bytecode v6
}

