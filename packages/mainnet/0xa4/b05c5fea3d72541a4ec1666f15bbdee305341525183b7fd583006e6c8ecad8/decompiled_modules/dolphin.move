module 0xa4b05c5fea3d72541a4ec1666f15bbdee305341525183b7fd583006e6c8ecad8::dolphin {
    struct DOLPHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPHIN>(arg0, 6, b"DOLPHIN", b"STRIPED DOLPHIN", b"Welcome to the world of Kai and Lara, the Striped Dolphins of the Crypto Seas! As agile navigators of both the ocean and the blockchain, Kai and Lara are here to guide you through the depths of the digital world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3585_810c99286b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPHIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLPHIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

