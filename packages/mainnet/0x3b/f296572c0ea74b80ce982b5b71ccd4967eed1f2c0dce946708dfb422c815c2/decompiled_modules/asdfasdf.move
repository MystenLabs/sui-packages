module 0x3bf296572c0ea74b80ce982b5b71ccd4967eed1f2c0dce946708dfb422c815c2::asdfasdf {
    struct ASDFASDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDFASDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDFASDF>(arg0, 9, b"asdfasdfasdfasdf", b"asdfasdf", b"asdfasdfasdfasdfasdfasdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinhublogos.9inch.io/1724653538838-chum.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASDFASDF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDFASDF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

