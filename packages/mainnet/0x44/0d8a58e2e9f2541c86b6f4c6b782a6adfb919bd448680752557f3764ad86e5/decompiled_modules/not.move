module 0x440d8a58e2e9f2541c86b6f4c6b782a6adfb919bd448680752557f3764ad86e5::not {
    struct NOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOT>(arg0, 9, b"NOT", b"Not coin", b"Not meme token.buy this token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/991236bb-36b6-498f-8300-733ad38e9f54.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

