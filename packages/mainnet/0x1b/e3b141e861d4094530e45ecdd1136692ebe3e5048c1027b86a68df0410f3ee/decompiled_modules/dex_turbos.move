module 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::dex_turbos {
    public fun get_turbos_config() : (address, address, address) {
        (@0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1, @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1, @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78)
    }

    public fun is_turbos_available() : bool {
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

