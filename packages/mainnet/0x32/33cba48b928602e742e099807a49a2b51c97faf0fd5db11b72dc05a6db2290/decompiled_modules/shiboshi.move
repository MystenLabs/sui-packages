module 0x3233cba48b928602e742e099807a49a2b51c97faf0fd5db11b72dc05a6db2290::shiboshi {
    struct SHIBOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBOSHI>(arg0, 6, b"SHIBOSHI", b"Shiboshi Sui", x"456e6a6f7920746865206a6f75726e657920616e64206c657420796f757220536869626f73686920677569646520746865207761792c20666f73746572696e67206c6f79616c747920616e6420747275737420617420657665727920737465702e0a0a0a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_15_02_15_56_1704d1562e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

