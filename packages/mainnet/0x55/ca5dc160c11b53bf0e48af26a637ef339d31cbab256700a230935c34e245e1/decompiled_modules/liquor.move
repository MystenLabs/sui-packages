module 0x55ca5dc160c11b53bf0e48af26a637ef339d31cbab256700a230935c34e245e1::liquor {
    struct LIQUOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIQUOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIQUOR>(arg0, 9, b"LIQUOR", b"LIQ", b"Be liquor, my friend.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LIQUOR>(&mut v2, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIQUOR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIQUOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

