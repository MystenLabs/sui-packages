module 0x42250ef1b42f2342f88a40efedf168c46baf1604bc503e036f4faa93bcf466f6::farty {
    struct FARTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTY>(arg0, 6, b"FARTY", b"Let's Farty", x"496e20323032352c207768656e20736f6d656f6e6520736179732c2049206e65656420746f20666172742c200a7765207361792c204c6574206974206f757420616e64204c657473204661727479", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056793_ccb2525577.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

