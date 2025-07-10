module 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::dex_kriya {
    public fun get_kriya_config() : (address, address, address) {
        (@0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66, @0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66, @0x5af4976b871fa1813362f352fa4cada3883a96191bb7212db1bd5d13685ae305)
    }

    public fun is_kriya_available() : bool {
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

