module 0x85f2657f1b487bdc5bba8048d1cfb64f7a65ffb132347ded3f94adbe7e0ed969::nino {
    struct NINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NINO>(arg0, 6, b"NINO", b"Nino", b"Nino is a community-driven memecoin that brings a cheerful and fun spirit to the crypto world. With its iconic, cute fish character, Nino is designed to attract meme enthusiasts and provide a lighthearted yet memorable experience. We believe that crypto should be enjoyable, and Nino is a place where fun and creativity unite!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241105_212557_9ed768b68a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

