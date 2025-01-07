module 0x190247a548120f8556d0e20bfa1fc8bab2d5af0ef3b8f590579bca6eec889e23::czai {
    struct CZAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CZAI>(arg0, 6, b"CZAI", b"CZAI", x"24435a41492077617320637265617465642062792074686520235375694149207465616d20746f2073686f776361736520686f772074686520706c6174666f726d20776f726b732e204974e2809973207375706572206561737920746f207573652c20616e642074686973206167656e742069732061206c6f74206f662066756e2e20456e6a6f7921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/CZ_5_f70a15209d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CZAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

