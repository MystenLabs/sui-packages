module 0x97aef7f8ce5fa307ee72ec9c5ab3abe4d6dc0783ff1cb0d0b3b6893b812a1bce::catw {
    struct CATW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATW>(arg0, 6, b"CATW", b"CatWhale", b"In a coastal village, a legendary creature called Whale Cat symbolizes unity between land and sea. It is revered for its bravery in saving a sailor during a storm, embodying a prophecy as a guardian. Its mystical presence brings magic and wonder to the villagers, fostering a sense of harmony and awe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9f4c776b750153fdf0b7b9b826efb0c6_d627a93004.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATW>>(v1);
    }

    // decompiled from Move bytecode v6
}

