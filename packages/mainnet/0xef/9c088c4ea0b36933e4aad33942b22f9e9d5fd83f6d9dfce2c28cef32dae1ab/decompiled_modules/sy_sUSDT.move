module 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::sy_sUSDT {
    struct SY_SUSDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SY_SUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SY_SUSDT>(arg0, 9, b"SY-sUSDT", b"SY scallop sUSDT", b"SY scallop sUSDT", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SY_SUSDT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SY_SUSDT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

