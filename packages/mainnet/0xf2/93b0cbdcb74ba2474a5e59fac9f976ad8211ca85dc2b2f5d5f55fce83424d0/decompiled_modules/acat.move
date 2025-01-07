module 0xf293b0cbdcb74ba2474a5e59fac9f976ad8211ca85dc2b2f5d5f55fce83424d0::acat {
    struct ACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACAT>(arg0, 6, b"ACAT", b"AAA CAT", b"AAA Cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7012_17597979bf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

