module 0x6c19fb6a670532da1ff9bbc40cf7867c09b7056c86711eaa98c46c922c75719b::chillguy {
    struct CHILLGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLGUY>(arg0, 6, b"ChillGuy", b"Just a Chill Guy", b"Im just a chill Guy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4405_c1b3171823.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

