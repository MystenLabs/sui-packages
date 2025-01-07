module 0x3302c23966f8b99a4c16e83a1fb187522e0d69e749eef8ff4723ddd3f86c8f9::babyfun {
    struct BABYFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYFUN>(arg0, 9, b"BABYFUN", b"BabyFun", b"The meme coin for a dog in my house", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/80e2f059-e931-4b1f-949a-c192146dc010.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

