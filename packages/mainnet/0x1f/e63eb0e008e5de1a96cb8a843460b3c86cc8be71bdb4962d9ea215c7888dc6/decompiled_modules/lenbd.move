module 0x1fe63eb0e008e5de1a96cb8a843460b3c86cc8be71bdb4962d9ea215c7888dc6::lenbd {
    struct LENBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LENBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LENBD>(arg0, 9, b"LENBD", b"jene", b"bebe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d9c6fbc3-1bbe-4aaf-8a9f-13dd4a5b67d2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LENBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LENBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

