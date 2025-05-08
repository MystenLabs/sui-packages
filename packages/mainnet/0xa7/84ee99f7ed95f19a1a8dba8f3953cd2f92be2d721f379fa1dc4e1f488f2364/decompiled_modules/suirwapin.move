module 0xa784ee99f7ed95f19a1a8dba8f3953cd2f92be2d721f379fa1dc4e1f488f2364::suirwapin {
    struct SUIRWAPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRWAPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRWAPIN>(arg0, 9, b"SUIRWAPIN", b"SUIRWAPIN", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIRWAPIN>(&mut v2, 540050000 * 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIRWAPIN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIRWAPIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

