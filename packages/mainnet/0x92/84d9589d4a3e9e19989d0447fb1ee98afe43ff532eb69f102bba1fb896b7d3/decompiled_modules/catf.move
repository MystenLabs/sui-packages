module 0x9284d9589d4a3e9e19989d0447fb1ee98afe43ff532eb69f102bba1fb896b7d3::catf {
    struct CATF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATF>(arg0, 9, b"CATF", b"CatFight", b"CatFight Token (CATF) is a fun meme token inspired by the \"Woman Yelling at Cat\" meme. It embraces internet humor and fosters community engagement in crypto, bringing together meme lovers for playful interactions and trading!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f9c55fdd-7c18-4b1a-a6e6-9557a1def415.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATF>>(v1);
    }

    // decompiled from Move bytecode v6
}

