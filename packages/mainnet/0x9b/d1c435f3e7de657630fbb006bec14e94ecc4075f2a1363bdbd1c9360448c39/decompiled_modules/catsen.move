module 0x9bd1c435f3e7de657630fbb006bec14e94ecc4075f2a1363bdbd1c9360448c39::catsen {
    struct CATSEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSEN>(arg0, 6, b"CATSEN", b"Catsen", b"Just a Cat memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000011170_e8d4463aa4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

