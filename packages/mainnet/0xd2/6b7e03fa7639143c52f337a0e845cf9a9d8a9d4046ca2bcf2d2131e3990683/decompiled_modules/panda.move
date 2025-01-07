module 0xd26b7e03fa7639143c52f337a0e845cf9a9d8a9d4046ca2bcf2d2131e3990683::panda {
    struct PANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDA>(arg0, 6, b"Panda", b"SuiPanda", b"**SuiPanda**  the cuddliest meme coin on the blockchain!  Powered by bamboo and good vibes, SuiPanda is here to roll through the crypto jungle with its unstoppable fluffiness. Forget going \"to the moon\"  were napping in the treetops! Whether you're a serious investor or just here for the memes, SuiPanda is your bamboo-powered ticket to a world of panda-monium.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0398_8fff84f216.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

