module 0xd985079a42aabd05887a7253313e32f567fc8a651ea4a46bb0bfa6bbe1eacc3c::aiora {
    struct AIORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIORA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIORA>(arg0, 6, b"AIORA", b"Aiora by SuiAI", b"Aiora is an AI agent built for intelligent questioning and answering", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2131_35d33425c7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIORA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIORA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

