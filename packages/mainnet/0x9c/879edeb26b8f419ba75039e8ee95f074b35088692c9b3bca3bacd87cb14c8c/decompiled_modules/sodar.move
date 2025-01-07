module 0x9c879edeb26b8f419ba75039e8ee95f074b35088692c9b3bca3bacd87cb14c8c::sodar {
    struct SODAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SODAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SODAR>(arg0, 6, b"SODAR", b"SODARSUI", b"ZOBI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tardoeh_700dba1e98.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SODAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SODAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

