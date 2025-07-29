module 0xa66a415a734df5a02cbd7ac04f3a7662f3fe4491eec5b807592916d1085e3682::summon {
    struct SUMMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMMON>(arg0, 6, b"SUMMON", b"Summon.Fun", b"Just Summon It", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiggylrj67sxuz7dnde3htq4vffcy6tmx2z6f5jeisoo5mjdzu2ety")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUMMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

