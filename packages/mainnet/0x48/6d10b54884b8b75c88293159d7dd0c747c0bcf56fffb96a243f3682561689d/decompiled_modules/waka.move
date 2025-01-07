module 0x486d10b54884b8b75c88293159d7dd0c747c0bcf56fffb96a243f3682561689d::waka {
    struct WAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAKA>(arg0, 9, b"WAKA", b"Waka", b"WAKA WAKA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/831d67ab-3206-438a-a9ff-145bd755cb06.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

