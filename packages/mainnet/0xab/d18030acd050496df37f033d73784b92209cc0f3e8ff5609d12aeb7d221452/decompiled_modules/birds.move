module 0xabd18030acd050496df37f033d73784b92209cc0f3e8ff5609d12aeb7d221452::birds {
    struct BIRDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRDS>(arg0, 6, b"Birds", b"Birds", b"Birds", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BIRDS>>(0x2::coin::mint<BIRDS>(&mut v2, 210000000000000, arg1), @0x9fa3cd2e02e5fc926e43d385adb1c6635d5ef1351b0326374e3beafd1e46394a);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIRDS>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BIRDS>>(v2);
    }

    // decompiled from Move bytecode v6
}

