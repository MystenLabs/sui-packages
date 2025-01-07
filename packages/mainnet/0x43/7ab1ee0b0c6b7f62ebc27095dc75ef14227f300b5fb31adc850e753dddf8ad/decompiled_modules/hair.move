module 0x437ab1ee0b0c6b7f62ebc27095dc75ef14227f300b5fb31adc850e753dddf8ad::hair {
    struct HAIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAIR>(arg0, 6, b"HAIR", b"Hair of Dog", b"ntroducing Hare of Dog Coin (HARE)  the ultimate meme coin that brings together the best of both worlds! This isnt just a token; its a celebration of laughter, loyalty, and the joy of good times with friends (furry and otherwise)!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3050_9c21efc5b4.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

