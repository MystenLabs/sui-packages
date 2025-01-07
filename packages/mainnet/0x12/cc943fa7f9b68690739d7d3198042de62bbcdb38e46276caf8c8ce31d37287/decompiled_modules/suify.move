module 0x12cc943fa7f9b68690739d7d3198042de62bbcdb38e46276caf8c8ce31d37287::suify {
    struct SUIFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFY>(arg0, 6, b"SUIFY", b"SUIFFY", b"suify", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_03_15_03_6ef2cf7683.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

