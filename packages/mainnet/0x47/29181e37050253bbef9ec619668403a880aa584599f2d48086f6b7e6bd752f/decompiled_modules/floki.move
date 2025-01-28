module 0x4729181e37050253bbef9ec619668403a880aa584599f2d48086f6b7e6bd752f::floki {
    struct FLOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKI>(arg0, 9, b"FLOKI", b"FLOKI On SOL", b"floki on sol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTrqUHwhEep7otevBviS2VcWYVSoMLWZ8Xo7q1kC2hsEF")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FLOKI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOKI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

