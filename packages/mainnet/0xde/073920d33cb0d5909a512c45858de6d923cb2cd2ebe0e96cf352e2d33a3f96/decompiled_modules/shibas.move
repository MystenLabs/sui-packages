module 0xde073920d33cb0d5909a512c45858de6d923cb2cd2ebe0e96cf352e2d33a3f96::shibas {
    struct SHIBAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBAS>(arg0, 6, b"SHIBAS", b"SHIBAS SUI", b"There is only one Shiba breed found in the western world, and we know it as the Shiba Inu, but did you know that there are actually three other Shibas of Japan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_22_21_14_47_429345471f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

