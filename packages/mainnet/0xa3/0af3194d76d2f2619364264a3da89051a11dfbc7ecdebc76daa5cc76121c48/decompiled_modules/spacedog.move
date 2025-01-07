module 0xa30af3194d76d2f2619364264a3da89051a11dfbc7ecdebc76daa5cc76121c48::spacedog {
    struct SPACEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPACEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPACEDOG>(arg0, 6, b"Spacedog", b"Space dog", b"Space iclude moon and sun and earth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000046536_e53dd82345.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPACEDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPACEDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

