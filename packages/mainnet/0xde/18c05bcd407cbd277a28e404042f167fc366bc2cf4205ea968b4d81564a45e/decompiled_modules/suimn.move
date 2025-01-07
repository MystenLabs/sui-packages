module 0xde18c05bcd407cbd277a28e404042f167fc366bc2cf4205ea968b4d81564a45e::suimn {
    struct SUIMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMN>(arg0, 6, b"SUIMN", b"auimarvin", b"marvin make sui rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/66e1aff95fb0f11c8c8aa6ab_1726067100_10752aba6c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

