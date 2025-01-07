module 0x44c56023a7ec626fd4fa586c2aaaf4aefbd993688626f621cf3a139708132f4e::droper {
    struct DROPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROPER>(arg0, 6, b"Droper", b"Blue Droper", b"Blue driper on sui, next big meme coin coming.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/123_c887571cc5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

