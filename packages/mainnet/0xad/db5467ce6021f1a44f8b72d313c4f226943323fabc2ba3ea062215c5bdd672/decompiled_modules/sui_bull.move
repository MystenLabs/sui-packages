module 0xaddb5467ce6021f1a44f8b72d313c4f226943323fabc2ba3ea062215c5bdd672::sui_bull {
    struct SUI_BULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_BULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_BULL>(arg0, 9, b"SUI BULL", x"f09f90825375692042756c6c", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_BULL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_BULL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_BULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

