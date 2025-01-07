module 0x66db369c8c5ac6bb29d2a6f7ca5dc3a7513d037279435335b145ec7a78e02963::slf {
    struct SLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLF>(arg0, 9, b"SLF", b"self", b"The introspective cryptocurrency that's reflecting your personal growth with solid profits, guiding your portfolio to self-sustained success.....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/25584ebc-846c-4b5b-bcd9-a9ccd246cd81.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

