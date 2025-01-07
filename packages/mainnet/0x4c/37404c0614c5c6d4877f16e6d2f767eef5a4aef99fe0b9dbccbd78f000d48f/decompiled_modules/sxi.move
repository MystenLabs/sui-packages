module 0x4c37404c0614c5c6d4877f16e6d2f767eef5a4aef99fe0b9dbccbd78f000d48f::sxi {
    struct SXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SXI>(arg0, 9, b"SXI", b"Suixxx", b"Suit ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6a07804d-81c0-4682-bee8-d08e03e7fb9b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

