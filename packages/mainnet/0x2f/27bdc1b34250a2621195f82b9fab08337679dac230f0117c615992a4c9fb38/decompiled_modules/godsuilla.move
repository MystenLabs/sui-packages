module 0x2f27bdc1b34250a2621195f82b9fab08337679dac230f0117c615992a4c9fb38::godsuilla {
    struct GODSUILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODSUILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODSUILLA>(arg0, 6, b"GODSUILLA", b"GOD-SUI-LLA", b"$godSUIllais a prehistoric reptilian or dinosaurian monster that is amphibious or resides partially in the SUI, awakened and empowered after many years.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_22_20_01_d88be49547.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODSUILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GODSUILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

