module 0x3f17d52aa515ed7f110a3f62ed24004761c7a60ca00f0ce6fb533029ee048bd1::menguin {
    struct MENGUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MENGUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MENGUIN>(arg0, 9, b"MENGUIN", b"Meow Pengu", b"Does he look like a Meow or a Penguin? let's call it a penguin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/64f58701-9bc5-43e9-b03d-56bf75aabcbc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MENGUIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MENGUIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

