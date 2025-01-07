module 0x9c14ce5572ee66723ceb7100112c7070cce658b9315588e6bac773197aaaeee5::sutomb {
    struct SUTOMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUTOMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUTOMB>(arg0, 6, b"SUTOMB", b"SUITOMB", b"Tomb token is a foundation that the ecosystem by tomb.finance is going to be build around.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/w_GNE_5_Yd_W_400x400_779a5d1403.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUTOMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUTOMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

