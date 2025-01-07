module 0xc2093f040551ea3b09ac5f8d2cf0670ac11a28dcabad62943d5286a9cac4a6a1::yoyo {
    struct YOYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOYO>(arg0, 6, b"YOYO", b"YOYO CAT", x"546865206d6f737420706f70756c61722063617420696e204d616c61797369610a48652069732061206772756d70792073756c6b792063617420616e64206c6f76657320746f20686f6c6420746f797320736f206d756368", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yoyo_cat_8929c04d51.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOYO>>(v1);
    }

    // decompiled from Move bytecode v6
}

