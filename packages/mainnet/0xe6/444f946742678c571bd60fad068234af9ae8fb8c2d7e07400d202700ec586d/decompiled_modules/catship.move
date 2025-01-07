module 0xe6444f946742678c571bd60fad068234af9ae8fb8c2d7e07400d202700ec586d::catship {
    struct CATSHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSHIP>(arg0, 6, b"CATSHIP", b"Cat on ship", b"sailing far away on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1124_3b63c3fed0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

