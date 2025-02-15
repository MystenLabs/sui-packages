module 0x5eb52589ae7216a75543911208f49106797a913454e9025ca410e9920f8e6a3c::cina {
    struct CINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CINA>(arg0, 9, b"CINA", b"Cinamoroll", b"J4fun <3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8719b56c-008b-47aa-92b3-b794caa8699e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CINA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CINA>>(v1);
    }

    // decompiled from Move bytecode v6
}

