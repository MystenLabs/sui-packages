module 0x46e92fdbbaecbf5e3514335368f9ad34c36e8a812f0f3db6b6170406ac1fc26::SOLAR {
    struct SOLAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLAR>(arg0, 9, b"SOLAR", b"SOLAR", b"SOLAR", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOLAR>>(v1);
        0x2::coin::mint_and_transfer<SOLAR>(&mut v2, 226600000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SOLAR>>(v2);
    }

    // decompiled from Move bytecode v6
}

