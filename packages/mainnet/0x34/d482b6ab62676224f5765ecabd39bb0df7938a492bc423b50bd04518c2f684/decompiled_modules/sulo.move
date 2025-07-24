module 0x34d482b6ab62676224f5765ecabd39bb0df7938a492bc423b50bd04518c2f684::sulo {
    struct SULO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SULO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SULO>(arg0, 6, b"SULO", b"SULOSUI", b"SULO the curves of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiavaaisngj2whddjmg2hbmkunkdb7bzgh7gbcdvqu322s736wndwa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SULO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SULO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

