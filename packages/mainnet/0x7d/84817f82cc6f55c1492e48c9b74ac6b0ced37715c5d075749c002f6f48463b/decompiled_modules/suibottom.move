module 0x7d84817f82cc6f55c1492e48c9b74ac6b0ced37715c5d075749c002f6f48463b::suibottom {
    struct SUIBOTTOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOTTOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOTTOM>(arg0, 6, b"Suibottom", b"SUIBOTTOM", b"bottom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_2_97eeadb752.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOTTOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOTTOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

