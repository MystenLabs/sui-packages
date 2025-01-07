module 0x70d37d32341bd13ff628a6f521190bd0b1ed0912c958a489c400fd434d2e71b::btk {
    struct BTK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTK>(arg0, 9, b"BTK", b"Batokare ", b"Gaming platform ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b5ffe7c-8310-4ea9-a0bd-c6085b50d7d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTK>>(v1);
    }

    // decompiled from Move bytecode v6
}

