module 0x319342ee1e531226ad2666f543188d59983ce91bf5bfe5d7c5f14537b0f9384c::rokect {
    struct ROKECT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROKECT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROKECT>(arg0, 9, b"Rokect", b"rocket ", b"basic meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0804dd44f24c19cb3302d873de86b18dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROKECT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROKECT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

