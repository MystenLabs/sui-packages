module 0xdb7b066ed42b5dbe30e22bba39f0f66f7175a8a96573e78969ccafaf0a943be5::lab {
    struct LAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAB>(arg0, 9, b"LAB", b"Lab proto", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c20b456d-f91d-4f5c-927e-4e91e5cc0c82.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

