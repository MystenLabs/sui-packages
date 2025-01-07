module 0x9ab5386cc8590701bbbe277f52c90f753f515500a392190656a5f211dbb5d2b5::maki {
    struct MAKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAKI>(arg0, 9, b"MAKI", b"Makiyyu ", b"Use for trade ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c23957dc-dc33-4048-af89-849ac3eced05.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

