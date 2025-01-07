module 0x5e3c1378b1b064e117704366ad4968d0113a32c0e3553a9f3eaa328bfd545744::prl {
    struct PRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRL>(arg0, 9, b"PRL", b"Pearls ", b"For the love of pearls ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a655a5ac-90a9-4ea8-b4ae-b7b64ed278e3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

