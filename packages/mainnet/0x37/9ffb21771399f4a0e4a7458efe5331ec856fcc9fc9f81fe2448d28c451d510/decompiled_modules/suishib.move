module 0x379ffb21771399f4a0e4a7458efe5331ec856fcc9fc9f81fe2448d28c451d510::suishib {
    struct SUISHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIB>(arg0, 6, b"SUISHIB", b"SUI SHIB", x"53756973686962206973206e6f74206a7573742061626f757420696e766573746d656e746974277320616e206570696320616476656e7475726520696e207468652073757065722d6661737420235375692065636f73797374656d2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_14_24_38_d284299328.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

