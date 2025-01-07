module 0x1962773fd499826f2dff853a39a5773e9eae5f940f955e483877bb662651b33b::nino {
    struct NINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NINO>(arg0, 6, b"NINO", b"Nino", b"Nino is a community-driven memecoin that brings a cheerful and fun spirit to the crypto world. With its iconic, cute fish character, Nino is designed to attract meme enthusiasts and provide a lighthearted yet memorable experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730995376668.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NINO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

