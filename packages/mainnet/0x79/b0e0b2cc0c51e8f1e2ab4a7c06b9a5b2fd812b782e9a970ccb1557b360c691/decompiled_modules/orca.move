module 0x79b0e0b2cc0c51e8f1e2ab4a7c06b9a5b2fd812b782e9a970ccb1557b360c691::orca {
    struct ORCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCA>(arg0, 6, b"ORCA", b"The Whale Killer", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ORCA>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORCA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ORCA>>(v2);
    }

    // decompiled from Move bytecode v6
}

