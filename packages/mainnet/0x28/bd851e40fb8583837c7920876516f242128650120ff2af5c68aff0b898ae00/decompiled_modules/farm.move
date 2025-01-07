module 0x28bd851e40fb8583837c7920876516f242128650120ff2af5c68aff0b898ae00::farm {
    struct FARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARM>(arg0, 9, b"FARM", b"FARM", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FARM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<FARM>>(0x2::coin::mint<FARM>(&mut v2, 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FARM>>(v2);
    }

    // decompiled from Move bytecode v6
}

