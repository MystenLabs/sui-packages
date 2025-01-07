module 0xef7aac32aac265fd4ec73934633b72611acdc78362d317175c4b1fad3e1b3882::kleo {
    struct KLEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLEO>(arg0, 6, b"Kleo", b"SuCat", b"Project Goal: To create a unique cryptocurrency community centered around cat memes, bringing together blockchain enthusiasts and cat lovers while establishing Sucat as a symbol of fun yet promising crypto investments.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732199964501.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KLEO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLEO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

