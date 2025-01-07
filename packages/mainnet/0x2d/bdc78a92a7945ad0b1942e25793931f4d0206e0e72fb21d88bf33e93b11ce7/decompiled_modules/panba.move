module 0x2dbdc78a92a7945ad0b1942e25793931f4d0206e0e72fb21d88bf33e93b11ce7::panba {
    struct PANBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANBA>(arg0, 6, b"PANBA", b"PanbaSui", b"Everyone calls $PANBA fat, he is just thick", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wl_VJ_kw_400x400_acb9afde5f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

