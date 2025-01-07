module 0x353a02c9088d57120c79d5a684e1b75bad6e637a52094e727cf428466211b960::hff {
    struct HFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFF>(arg0, 9, b"HFF", b"FEW", b"Goku is a good ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/10cd9b9f-1704-483f-a181-001e43bad622.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

