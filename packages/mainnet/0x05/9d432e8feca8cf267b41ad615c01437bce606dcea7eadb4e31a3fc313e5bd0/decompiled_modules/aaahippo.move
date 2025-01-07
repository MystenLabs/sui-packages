module 0x59d432e8feca8cf267b41ad615c01437bce606dcea7eadb4e31a3fc313e5bd0::aaahippo {
    struct AAAHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAHIPPO>(arg0, 6, b"AAAHIPPO", b"aaadeng", b"AAAAAAAADENG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0313_c83a2c5af0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAHIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

