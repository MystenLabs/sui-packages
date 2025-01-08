module 0x7034bcbd33a71cc669ea08d2d7c06289309e9dd71afb0785b5876e95f9d1454c::daos {
    struct DAOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAOS>(arg0, 6, b"DAOS", b"SUI DAO", b"daos.sui shapes a new era of investing in AI, DeSci, and meme coins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/y_R0_Rf_F_Yk_400x400_4fe8994545.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

