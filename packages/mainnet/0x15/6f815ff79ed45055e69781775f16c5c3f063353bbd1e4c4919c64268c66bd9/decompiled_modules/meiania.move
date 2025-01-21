module 0x156f815ff79ed45055e69781775f16c5c3f063353bbd1e4c4919c64268c66bd9::meiania {
    struct MEIANIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEIANIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEIANIA>(arg0, 9, b"MEIANIA", b"Melania", b"Melania memes are digital collectibles intended to function as an expression of support for and engagement with the values embodied by the symbol MELANIA.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0636a7a5-7c8f-4511-8512-4a0dad641324.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEIANIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEIANIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

