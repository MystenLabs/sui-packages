module 0x729d2139f9a89135a0758a097e3849f90e25a3d2cd7288af162090a5ab74969e::real {
    struct REAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: REAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REAL>(arg0, 9, b"REAL", b"REAL", b"Some description about my awesome coin", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<REAL>(&mut v2, 1000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REAL>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

