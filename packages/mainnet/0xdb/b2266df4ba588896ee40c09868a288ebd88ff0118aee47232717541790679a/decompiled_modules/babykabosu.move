module 0xdbb2266df4ba588896ee40c09868a288ebd88ff0118aee47232717541790679a::babykabosu {
    struct BABYKABOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYKABOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYKABOSU>(arg0, 6, b"BabyKabosu", b"babykabosu", x"546865206d656d6520717565656e2c20746865206f672c20746865206661636520626568696e6420646f67652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000382_d2d893bb1f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYKABOSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYKABOSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

