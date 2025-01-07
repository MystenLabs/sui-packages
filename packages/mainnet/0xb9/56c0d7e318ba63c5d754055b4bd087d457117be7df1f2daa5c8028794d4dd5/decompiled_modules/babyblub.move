module 0xb956c0d7e318ba63c5d754055b4bd087d457117be7df1f2daa5c8028794d4dd5::babyblub {
    struct BABYBLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYBLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYBLUB>(arg0, 6, b"BabyBlub", b"BabyBabyBlub", b"Baby Blub son of a gun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BBAY_BLUB_41c1fd81e7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYBLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYBLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

