module 0xdb6c3adda62d26292058c5262ce60ff6bb4bfa5703ea6f987de938377a7a8117::kas {
    struct KAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAS>(arg0, 9, b"KAS", b"Kas Gouoa", b"Kas Coin Empire", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/25f6f4f3-df14-4187-8bcb-50e8dc8d2ca2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

