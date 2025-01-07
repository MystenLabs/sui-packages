module 0x8b2e55d3b7b7be7c9a1791adada0919135d61034b26837dab14c3576e0b40bd2::iru {
    struct IRU has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRU>(arg0, 9, b"IRU", b"kapa iruko", b"Japanese dolphin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/01373ccb-f49e-4c25-83a4-9d5ec109d6d7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IRU>>(v1);
    }

    // decompiled from Move bytecode v6
}

