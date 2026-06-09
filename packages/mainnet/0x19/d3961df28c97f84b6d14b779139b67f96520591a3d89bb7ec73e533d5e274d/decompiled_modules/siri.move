module 0x19d3961df28c97f84b6d14b779139b67f96520591a3d89bb7ec73e533d5e274d::siri {
    struct SIRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIRI>(arg0, 6, b"SIRI", b"SiriAI", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIRI>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIRI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SIRI>>(v2);
    }

    // decompiled from Move bytecode v6
}

