module 0x4e88a052a91369d6bb7013e61c81462b571e7dc80de19048380ae148d07a42ac::owne {
    struct OWNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWNE>(arg0, 9, b"OWNE", b"jdnd", b"brbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/79ef58d3-6e29-40ea-a66c-8509ec6d1761.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

