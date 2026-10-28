module 0x8d6d65e2abd9ca7d7aba11689e8b17d8b2b20625ea44dead5b3b68a35724e74e::agla_merkl {
    struct AGLA_MERKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGLA_MERKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<AGLA_MERKL>(arg0, 6, 0x1::string::utf8(b"aglaMerkl"), 0x1::string::utf8(b"Angle Merkl"), 0x1::string::utf8(b"Merkl test token, no value"), 0x1::string::utf8(b"https://raw.githubusercontent.com/AngleProtocol/angle-token-list/main/src/assets/tokens/angle-icon-colorback-black500.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGLA_MERKL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<AGLA_MERKL>>(0x2::coin_registry::finalize<AGLA_MERKL>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

