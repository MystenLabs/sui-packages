module 0x91b6466da0e9682aa26bdb9f22b117e7cfa316fda75f44678ba316c03f72e89::blofi {
    struct BLOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOFI>(arg0, 6, b"BLOFI", b"Brother Lofi", b"Meet lofi Chad brother", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5870_13512657aa.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

