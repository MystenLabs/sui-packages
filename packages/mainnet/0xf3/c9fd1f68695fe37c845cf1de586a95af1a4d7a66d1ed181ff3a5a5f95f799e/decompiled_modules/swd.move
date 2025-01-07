module 0xf3c9fd1f68695fe37c845cf1de586a95af1a4d7a66d1ed181ff3a5a5f95f799e::swd {
    struct SWD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWD>(arg0, 9, b"SWD", b"SWAGDOGS", b"SWAGDOGS is a community driven meme coin that explores the depths of blockchain innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6bd31b3d-5de9-4e88-a7a5-481b3e5bcf6c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWD>>(v1);
    }

    // decompiled from Move bytecode v6
}

