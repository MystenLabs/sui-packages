module 0xcfdd630027e39d241f4755d89a7ff96ff483e265e7ac6d24b8e09239f1c5c0b7::sh {
    struct SH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SH>(arg0, 9, b"SH", b"Sha", b"O", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e19ae828-a132-4c86-a8f1-9be2b4a551be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SH>>(v1);
    }

    // decompiled from Move bytecode v6
}

