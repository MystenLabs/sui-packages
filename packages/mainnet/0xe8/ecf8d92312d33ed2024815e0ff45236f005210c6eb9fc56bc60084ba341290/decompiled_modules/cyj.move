module 0xe8ecf8d92312d33ed2024815e0ff45236f005210c6eb9fc56bc60084ba341290::cyj {
    struct CYJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYJ>(arg0, 9, b"CYJ", b"Common", b"common is a bull run coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2b673b92-1a60-4bfe-ba9b-e01af6f2c42f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CYJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

