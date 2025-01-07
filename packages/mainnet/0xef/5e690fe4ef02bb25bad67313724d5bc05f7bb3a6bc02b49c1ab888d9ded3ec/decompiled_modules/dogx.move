module 0xef5e690fe4ef02bb25bad67313724d5bc05f7bb3a6bc02b49c1ab888d9ded3ec::dogx {
    struct DOGX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGX>(arg0, 6, b"DOGX", b"DogX", x"45766572796f6e65206c6f766520444f47580a546865206e61746976652058206d656d6520636f696e0a41697264726f7020666f72207468652058204f4721", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9741_f742c37bf5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGX>>(v1);
    }

    // decompiled from Move bytecode v6
}

