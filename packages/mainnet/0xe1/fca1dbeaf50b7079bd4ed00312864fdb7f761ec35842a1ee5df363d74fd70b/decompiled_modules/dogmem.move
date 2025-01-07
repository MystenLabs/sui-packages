module 0xe1fca1dbeaf50b7079bd4ed00312864fdb7f761ec35842a1ee5df363d74fd70b::dogmem {
    struct DOGMEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGMEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGMEM>(arg0, 9, b"DOGMEM", b"Dogmem", b"Dogmem most viral meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/815c6ffc-dfba-43bc-8b40-5d8d35558d2f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGMEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGMEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

