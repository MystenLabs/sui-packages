module 0x45eda586dccce5f1e0775acde271f04be7fa89981c9c51237a350433a602b9b1::topus {
    struct TOPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOPUS>(arg0, 6, b"TOPUS", b"OCTOPUSonSUI", b"octopuss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WATER_e7d2404af4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOPUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOPUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

