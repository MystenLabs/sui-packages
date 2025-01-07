module 0x4e1ebfaae565f70949a835e1ceec593d473bef7d1322a06d02699fa7663670f6::barrybunns {
    struct BARRYBUNNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARRYBUNNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARRYBUNNS>(arg0, 6, b"BARRYBUNNS", b"Barry Bunns ON SUI", b"Barry, Barrybunns.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/r_FZ_6xp_K5_400x400_1_03f043dc9c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARRYBUNNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARRYBUNNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

