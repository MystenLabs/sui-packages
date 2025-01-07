module 0x3a5ce216188e9a348aacaf3e328556ebf9a5e0b87c276f984f5e77e863043ec1::keycat {
    struct KEYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEYCAT>(arg0, 6, b"KEYCAT", b"KEYBOARD CAT", b"Keyboard Cat is a video-based internet meme. No socials created, feel free to do so and lets build a community together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0035_0bee2b742c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

