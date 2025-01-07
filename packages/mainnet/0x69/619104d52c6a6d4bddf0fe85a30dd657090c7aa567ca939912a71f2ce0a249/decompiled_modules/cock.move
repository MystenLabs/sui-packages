module 0x69619104d52c6a6d4bddf0fe85a30dd657090c7aa567ca939912a71f2ce0a249::cock {
    struct COCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCK>(arg0, 9, b"COCK", b"Cockcoin", x"596561682e204974e280997320636f696e207769746820636f636b21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5db55a30-ba20-445a-943c-61202f019a97.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

