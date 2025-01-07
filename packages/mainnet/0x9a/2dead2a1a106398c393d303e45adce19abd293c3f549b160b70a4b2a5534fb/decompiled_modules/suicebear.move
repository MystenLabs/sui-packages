module 0x9a2dead2a1a106398c393d303e45adce19abd293c3f549b160b70a4b2a5534fb::suicebear {
    struct SUICEBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICEBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICEBEAR>(arg0, 6, b"SUICEBEAR", b"SuiceBear", x"546865206375746573742062656172206f6e205355492c206272696e67696e67206265617220746f2074686520776f726c64206f66206d656d65732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038715_1c8a5b62a9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICEBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICEBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

