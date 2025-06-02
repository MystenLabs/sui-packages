module 0x5426cf459cc94efdad6bbdadbdd8d449f34db62650dbe0f377a3c43f0a9517b5::camel2 {
    struct CAMEL2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAMEL2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAMEL2>(arg0, 6, b"Camel2", b"Camel", b"has a distinctive mound on its back.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748900465313.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAMEL2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAMEL2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

