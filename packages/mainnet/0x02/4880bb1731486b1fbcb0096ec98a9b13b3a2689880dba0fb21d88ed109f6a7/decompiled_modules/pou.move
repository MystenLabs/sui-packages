module 0x24880bb1731486b1fbcb0096ec98a9b13b3a2689880dba0fb21d88ed109f6a7::pou {
    struct POU has drop {
        dummy_field: bool,
    }

    fun init(arg0: POU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POU>(arg0, 9, b"POU", b"Pou On Sui", b"Pou has arrived on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739041897098.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<POU>>(0x2::coin::mint<POU>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<POU>>(v2);
    }

    // decompiled from Move bytecode v6
}

