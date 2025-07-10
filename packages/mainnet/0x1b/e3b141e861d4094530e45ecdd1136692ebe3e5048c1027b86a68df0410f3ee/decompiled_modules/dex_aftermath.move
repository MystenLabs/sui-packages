module 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::dex_aftermath {
    public fun get_aftermath_config() : (address, address, address) {
        (@0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6, @0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6, @0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6)
    }

    public fun is_aftermath_available() : bool {
        true
    }

    public fun swap_sui_to_wusdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::wusdc::WUSDC> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) > 0, 1);
        abort 99
    }

    public fun swap_wusdc_to_sui(arg0: 0x2::coin::Coin<0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::wusdc::WUSDC>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::wusdc::WUSDC>(&arg0) > 0, 1);
        abort 99
    }

    // decompiled from Move bytecode v6
}

