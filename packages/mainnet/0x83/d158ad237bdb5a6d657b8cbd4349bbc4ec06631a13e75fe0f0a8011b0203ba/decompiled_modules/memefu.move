module 0x83d158ad237bdb5a6d657b8cbd4349bbc4ec06631a13e75fe0f0a8011b0203ba::memefu {
    struct MEMEFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEFU>(arg0, 9, b"MEMEFU", b"meme", b"meme fu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d01b853f-5029-47cd-9a2d-10a4eb3a08a1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

