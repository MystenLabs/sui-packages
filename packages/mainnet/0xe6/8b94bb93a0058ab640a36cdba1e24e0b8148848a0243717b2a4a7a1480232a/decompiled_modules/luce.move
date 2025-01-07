module 0xe68b94bb93a0058ab640a36cdba1e24e0b8148848a0243717b2a4a7a1480232a::luce {
    struct LUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCE>(arg0, 6, b"LUCE", b"Luce", b"The Vatican unveils Luce (Italian for Light), the mascot for the Holy Year 2025. Dressed as a pilgrim with a yellow raincoat, worn boots, a missionary cross, and a pilgrim's staff, Luces eyes are filled with scallop shellsa symbol of hope.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_58_7fc7199e02.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

