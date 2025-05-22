module 0x59fd8cdd800a1d66ba7ceaab0ff609fd54d4fcd15dff4226bb609d22b9ab88b8::toli {
    struct TOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOLI>(arg0, 6, b"TOLI", b"Toli", b"The government may lie to you, Toli won't", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747929225630.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOLI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOLI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

