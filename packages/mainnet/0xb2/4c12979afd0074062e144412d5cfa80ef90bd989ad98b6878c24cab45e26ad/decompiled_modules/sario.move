module 0xb24c12979afd0074062e144412d5cfa80ef90bd989ad98b6878c24cab45e26ad::sario {
    struct SARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SARIO>(arg0, 6, b"SARIO", b"Suimario", b"mario", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_00_07_19_26d004b91c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SARIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SARIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

