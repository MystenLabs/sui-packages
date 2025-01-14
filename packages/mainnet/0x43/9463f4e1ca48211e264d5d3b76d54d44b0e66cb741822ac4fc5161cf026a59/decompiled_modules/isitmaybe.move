module 0x439463f4e1ca48211e264d5d3b76d54d44b0e66cb741822ac4fc5161cf026a59::isitmaybe {
    struct ISITMAYBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISITMAYBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISITMAYBE>(arg0, 6, b"IsItMaybe", b"The One", x"4973206974e280a6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736824723660.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ISITMAYBE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISITMAYBE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

