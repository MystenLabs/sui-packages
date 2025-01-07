module 0x61960c35c21e09cd12deff9fd991e1e20633ce4a38d6c07d6c1d735c007938d5::aidog {
    struct AIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIDOG>(arg0, 9, b"AIDOG", b"BabydogAI", b"Trade", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/882ac22f-b609-46fa-b95d-68f013ca9342.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

