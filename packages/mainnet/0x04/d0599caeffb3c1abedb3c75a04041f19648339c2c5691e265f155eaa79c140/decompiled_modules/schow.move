module 0x4d0599caeffb3c1abedb3c75a04041f19648339c2c5691e265f155eaa79c140::schow {
    struct SCHOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHOW>(arg0, 6, b"sCHOW", b"SuiChow", b"Chinese dog on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000024481_abc10acbf3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCHOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

