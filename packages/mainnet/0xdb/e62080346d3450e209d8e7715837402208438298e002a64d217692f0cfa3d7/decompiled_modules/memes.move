module 0xdbe62080346d3450e209d8e7715837402208438298e002a64d217692f0cfa3d7::memes {
    struct MEMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMES>(arg0, 6, b"MEMES", b"Memeland on sui", x"0a4d656d656c616e64206d616b696e67207761766573206f6e207375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241008_001111_0d8f616efb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMES>>(v1);
    }

    // decompiled from Move bytecode v6
}

