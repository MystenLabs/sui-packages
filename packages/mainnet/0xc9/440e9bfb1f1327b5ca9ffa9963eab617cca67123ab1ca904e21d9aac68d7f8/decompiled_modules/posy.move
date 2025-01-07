module 0xc9440e9bfb1f1327b5ca9ffa9963eab617cca67123ab1ca904e21d9aac68d7f8::posy {
    struct POSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSY>(arg0, 9, b"POSY", b"Positive ", b"Nya ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e77ef359-7d89-4fa4-b798-4d8277921202.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

