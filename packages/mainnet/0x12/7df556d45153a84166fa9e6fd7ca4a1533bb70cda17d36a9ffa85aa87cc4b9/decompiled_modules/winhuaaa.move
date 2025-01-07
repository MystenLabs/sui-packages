module 0x127df556d45153a84166fa9e6fd7ca4a1533bb70cda17d36a9ffa85aa87cc4b9::winhuaaa {
    struct WINHUAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINHUAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINHUAAA>(arg0, 9, b"WINHUAAA", b"WINHUA", b"asdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/104da7bc-e026-4ab4-8146-29cbc43a0af5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINHUAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WINHUAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

