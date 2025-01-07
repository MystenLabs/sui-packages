module 0x8aec8d2f9d21c6e9af0c5fc9868a5f620004a7d46d5c28fddb5ebdd28f52b3ab::kaorionsui {
    struct KAORIONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAORIONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAORIONSUI>(arg0, 6, b"Kaorionsui", b"Kaori", b"My name is Kaori, I am a friend of Kabosu, and it's nice to meet you!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kaori_64699d2ab1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAORIONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAORIONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

