module 0xe07f92ee3eff05b22f7404d6293ddbc35b4c6bad5a7b28a0914f9990e21ce30a::g2 {
    struct G2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: G2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<G2>(arg0, 6, b"G2", b"crptogul2x", b"trader", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifpkyhupmtdfmhqiijc3earqg744fsu47b5o25izaicebfezldupe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<G2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<G2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

