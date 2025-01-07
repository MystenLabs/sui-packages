module 0xf315b17b4b593635d0b53f8087c3a10d5da338c40927585f48c5102b1567c658::apedisui {
    struct APEDISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEDISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APEDISUI>(arg0, 6, b"APEDISUI", b"APESUI DICE", x"4252494e47204954204f4e2043484144202121210a434f4d4d554e4954592044524956454e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241010_181534_538_ab50898b92.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEDISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APEDISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

