module 0x4d96e2fda712e98cca404a0322cad86510652735d9517b04a0a6348c594bc368::zesh {
    struct ZESH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZESH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZESH>(arg0, 6, b"ZAI", b"Zesh AI Layer", b"Zesh AI Layer is a revolutionary AI layer on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://zesh.ai/icon-logo.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<ZESH>>(0x2::coin::mint<ZESH>(&mut v2, 500000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZESH>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ZESH>>(v2);
    }

    // decompiled from Move bytecode v6
}

