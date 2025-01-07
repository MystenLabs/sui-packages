module 0x7d2fc4343911e7f0e3ed44f399c9e173f401dcece8312a15aab2e779032d33ab::TEST {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 6, b"TEST", b"TEST!", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST>>(0x2::coin::mint<TEST>(&mut v2, 1000000000000000, arg1), @0x76edc19d7cb696bb26c5a7c5f1a131bc4b4bb9010e7bbc1e0907d7bf0bc193b3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v2, @0x76edc19d7cb696bb26c5a7c5f1a131bc4b4bb9010e7bbc1e0907d7bf0bc193b3);
    }

    // decompiled from Move bytecode v6
}

