module 0x34732358cebfdf4ee29534f906cbb36a78dfaaa256e7d9ddb7e789e2dd878eb::padu {
    struct PADU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PADU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PADU>(arg0, 9, b"PADU", b"PADU Token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PADU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PADU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

