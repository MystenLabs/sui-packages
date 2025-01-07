module 0x770f410972ebe6e0fc075f9a0aa6d8ef84f3d947699aa634e64aa36f645b35a::ottie {
    struct OTTIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTIE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<OTTIE>(arg0, 1271573993652980238, b"OTTIE", b"OTTIE", b"Don't ask , Just Chillin' and Moonin' ...!", b"https://images.hop.ag/ipfs/QmeAJZU57UKM7V1AvSoqbahADVSkeT73A8mSLLKxJLhbWs", 0x1::string::utf8(b"https://x.com/ottiesui"), 0x1::string::utf8(b"https://ottieonsui.xyz/"), 0x1::string::utf8(b"https://t.me/ottiesui"), arg1);
    }

    // decompiled from Move bytecode v6
}

