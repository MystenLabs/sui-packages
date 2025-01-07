module 0xb834c5d598dc55f42148191b30edff088ba8151a45d4fbbed39e51740eb75bf0::birds {
    struct BIRDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRDS>(arg0, 6, b"BIRDS", b"Birds Coin", b"A coin for bird lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/Sm7sjXw/birds.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BIRDS>>(0x2::coin::mint<BIRDS>(&mut v2, 210000000000000, arg1), @0x9fa3cd2e02e5fc926e43d385adb1c6635d5ef1351b0326374e3beafd1e46394a);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIRDS>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BIRDS>>(v2);
    }

    // decompiled from Move bytecode v6
}

