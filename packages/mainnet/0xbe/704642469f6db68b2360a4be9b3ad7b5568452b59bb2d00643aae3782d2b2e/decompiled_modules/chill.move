module 0xbe704642469f6db68b2360a4be9b3ad7b5568452b59bb2d00643aae3782d2b2e::chill {
    struct CHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILL>(arg0, 6, b"Chill", b"Chill Guy", b"wen sui price fall and you hodl cos you don't buy high and sell low", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chill_guy_a079c14b56.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

