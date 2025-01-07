module 0xb068f6abb2150057cba1737d41a4ee3b631c6b5e5f1f437354423f3c25f3642::af {
    struct AF has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AF>(arg0, 9, b"AF", b"RTG", b"AFSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5da2b4c8-35b7-4354-b07d-538c8222bcc1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AF>>(v1);
    }

    // decompiled from Move bytecode v6
}

