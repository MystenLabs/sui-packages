module 0x620501e10acc4c9bb59f89b83c38c61be79baca83f482749ee5c9856a13c6fbd::suigull {
    struct SUIGULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGULL>(arg0, 6, b"Suigull", b"Seagull of Sui", b"Flying high above Sui Ocean, watching everything. Feed him bread or you'll get attacked.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/seagull_1_f300b279d6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

