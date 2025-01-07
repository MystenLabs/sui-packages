module 0x228b526530884dc3742acb33a91257aad29651b48c3641f7fe75bfc09bd98b0a::snowguy {
    struct SNOWGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOWGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOWGUY>(arg0, 6, b"SNOWGUY", b"just a snowguy", b"when she gets mad because Im playing with the snow, but Im a chillguy who likes snow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241214_103228_276_141a831863.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOWGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOWGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

