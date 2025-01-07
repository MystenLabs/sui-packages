module 0xb9bed85f94fb9e16c187b17f49733b5573579373d5547d17f344c9ea58d0924::puffi {
    struct PUFFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFI>(arg0, 6, b"PUFFI", b"Puffi On Sui", b"$PUFFI is the life of the crypto party! With his leopard-print hat and cool shades, he brings a laid-back vibe full of swagger. Always sporting a huge smile, he invites you to join the fun on the SUI network, proudly holding his sign. $PUFFI isn't just a token, it's a symbol of carefree fun, easy laughs, and a community that loves memes but is serious when it comes to innovation!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_05_17_11_db44f0c86c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

