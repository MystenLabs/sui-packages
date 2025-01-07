module 0xbb417ef284a7b41e73cc3f26fea464ed7ca881a8e60bc75cb1d13bd786de1bd5::dogai {
    struct DOGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGAI>(arg0, 6, b"DogAI", b"dog ai memecoin", b"First AI-driven memecoin dog on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ga_ALI_4_Q_Wc_A_Ajnjd_ba58e26371.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

