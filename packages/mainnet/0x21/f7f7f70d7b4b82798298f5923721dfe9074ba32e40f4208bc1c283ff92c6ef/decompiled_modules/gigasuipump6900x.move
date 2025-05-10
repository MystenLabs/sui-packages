module 0x21f7f7f70d7b4b82798298f5923721dfe9074ba32e40f4208bc1c283ff92c6ef::gigasuipump6900x {
    struct GIGASUIPUMP6900X has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGASUIPUMP6900X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGASUIPUMP6900X>(arg0, 6, b"GigaSuiPump6900x", b"Buy2StartSuiSeason", b"Sui season starts when we pump a shitcoin to 100s of millions. Buy this to initiate a sui season. Stop being 2x jeets", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5221_13c3f934f8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGASUIPUMP6900X>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIGASUIPUMP6900X>>(v1);
    }

    // decompiled from Move bytecode v6
}

