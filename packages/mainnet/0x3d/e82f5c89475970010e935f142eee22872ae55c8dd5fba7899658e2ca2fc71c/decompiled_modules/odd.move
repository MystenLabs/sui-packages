module 0x3de82f5c89475970010e935f142eee22872ae55c8dd5fba7899658e2ca2fc71c::odd {
    struct ODD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODD>(arg0, 6, b"ODD", b"what an odd thing to say", b"Surely you know what we do $ODD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241223_033612_808_7044e4d06b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ODD>>(v1);
    }

    // decompiled from Move bytecode v6
}

