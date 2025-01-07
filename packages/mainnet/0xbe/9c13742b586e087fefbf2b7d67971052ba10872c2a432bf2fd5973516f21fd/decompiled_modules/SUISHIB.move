module 0xbe9c13742b586e087fefbf2b7d67971052ba10872c2a432bf2fd5973516f21fd::SUISHIB {
    struct SUISHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIB>(arg0, 6, b"SUISHIB", b"SSHIB", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISHIB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISHIB>>(0x2::coin::mint<SUISHIB>(&mut v2, 1000000000000000, arg1), @0x76edc19d7cb696bb26c5a7c5f1a131bc4b4bb9010e7bbc1e0907d7bf0bc193b3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIB>>(v2, @0x76edc19d7cb696bb26c5a7c5f1a131bc4b4bb9010e7bbc1e0907d7bf0bc193b3);
    }

    // decompiled from Move bytecode v6
}

