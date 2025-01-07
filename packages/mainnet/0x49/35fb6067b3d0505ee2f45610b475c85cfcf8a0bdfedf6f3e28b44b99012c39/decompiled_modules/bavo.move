module 0x4935fb6067b3d0505ee2f45610b475c85cfcf8a0bdfedf6f3e28b44b99012c39::bavo {
    struct BAVO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAVO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAVO>(arg0, 9, b"BAVO", b"Son", b"To the mon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/20217092-aaec-463d-8795-695824d5343c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAVO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAVO>>(v1);
    }

    // decompiled from Move bytecode v6
}

