module 0x1f75c0b62f756c2b2f28f3ca173403f94827bc1ac52d7b3f079cbebe32566077::shremp {
    struct SHREMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHREMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHREMP>(arg0, 6, b"SHREMP", b"Shrempin", b"Introducing $SHREMP, your next meme obsession", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/snow_47b8a71ce8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHREMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHREMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

