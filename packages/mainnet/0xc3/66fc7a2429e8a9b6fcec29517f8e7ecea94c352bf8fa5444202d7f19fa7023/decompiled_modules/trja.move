module 0xc366fc7a2429e8a9b6fcec29517f8e7ecea94c352bf8fa5444202d7f19fa7023::trja {
    struct TRJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRJA>(arg0, 9, b"TRJA", b"Toraja", b"this token meme for unite all toraja tribe all over the world. the utility of this token is to build existensi of toraja tribe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe92ae3f-c6da-4cf7-a531-52b2aeb61325.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRJA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRJA>>(v1);
    }

    // decompiled from Move bytecode v6
}

