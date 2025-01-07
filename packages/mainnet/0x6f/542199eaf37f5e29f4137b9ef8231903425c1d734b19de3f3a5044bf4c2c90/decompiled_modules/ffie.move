module 0x6f542199eaf37f5e29f4137b9ef8231903425c1d734b19de3f3a5044bf4c2c90::ffie {
    struct FFIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFIE>(arg0, 6, b"FFIE", b"faraday future", b"faraday future intelligent electric inc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8849_7bf055e27d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

