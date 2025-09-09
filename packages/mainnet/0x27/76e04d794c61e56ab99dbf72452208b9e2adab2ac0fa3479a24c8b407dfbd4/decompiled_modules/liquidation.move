module 0x2776e04d794c61e56ab99dbf72452208b9e2adab2ac0fa3479a24c8b407dfbd4::liquidation {
    struct LiquidationRule has drop {
        dummy_field: bool,
    }

    public fun liquidate<T0>(arg0: &mut 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &0x2::clock::Clock, arg3: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>, arg4: address, arg5: 0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, arg6: &mut 0x2::tx_context::TxContext) : 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::request::UpdateRequest<T0> {
        let v0 = LiquidationRule{dummy_field: false};
        0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::liquidate<T0, LiquidationRule>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6)
    }

    // decompiled from Move bytecode v6
}

