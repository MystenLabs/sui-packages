module 0xdfa5c2daf40d5395514531458b1636dbacd3711c13622ae221197ac655c4c2cf::ngwi {
    struct NGWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGWI>(arg0, 6, b"NGWI", b"AMBALABU", b"a mythical doll in ngawi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1471_df4179e576.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NGWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

