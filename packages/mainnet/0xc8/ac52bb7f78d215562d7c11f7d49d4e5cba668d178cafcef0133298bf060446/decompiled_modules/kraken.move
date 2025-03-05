module 0xc8ac52bb7f78d215562d7c11f7d49d4e5cba668d178cafcef0133298bf060446::kraken {
    struct KRAKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRAKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRAKEN>(arg0, 6, b"KRAKEN", b"Kraken Meme", b"KRAKEN meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/6a07491d-5afc-4e9b-9f49-95e186e0e4d3.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRAKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRAKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

