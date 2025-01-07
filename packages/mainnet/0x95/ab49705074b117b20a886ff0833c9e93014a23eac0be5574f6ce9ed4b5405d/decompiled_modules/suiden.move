module 0x95ab49705074b117b20a886ff0833c9e93014a23eac0be5574f6ce9ed4b5405d::suiden {
    struct SUIDEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDEN>(arg0, 6, b"SUIDEN", b"SUICOWDEN", b"role-playing game derivative @suikoden", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suicowden_2_0dbf1503c1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

