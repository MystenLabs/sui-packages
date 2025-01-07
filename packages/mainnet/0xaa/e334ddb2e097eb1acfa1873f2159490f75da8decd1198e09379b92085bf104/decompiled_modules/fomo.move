module 0xaae334ddb2e097eb1acfa1873f2159490f75da8decd1198e09379b92085bf104::fomo {
    struct FOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMO>(arg0, 6, b"FOMO", b"fear of missing out sui", b"fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo fomo ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Votre_texte_de_paragraphe_17_1a6877d2e6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

