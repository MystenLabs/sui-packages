module 0xd91bb5e6a2202f3b214f087a3089526ff7dfd9b11e3cd2c85d3c0fc5748d0220::turbos_uni {
    struct TURBOS_UNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOS_UNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOS_UNI>(arg0, 6, b"Turbos_uni", b"Uni", b"The dog of SUI co-founder", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953347870.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOS_UNI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOS_UNI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

