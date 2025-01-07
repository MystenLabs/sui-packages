module 0x82e13c78f5d45be40ad4deb97fb5175a20b804152d3e66ee392a9c5ade244b4d::blimp {
    struct BLIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLIMP>(arg0, 6, b"BLIMP", b"BLUE CHIMP", b"Meet Blimp, the chimpanzee with a flair for finance! Sporting a stylish blue hue, he's not your average primatehe's a meme-loving money mogul. Watch out Wall Street, because Blu's launching his own memetoken, proving that even chimps know how to go bananas for blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_28_02_16_12_f3fe598ed6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLIMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLIMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

