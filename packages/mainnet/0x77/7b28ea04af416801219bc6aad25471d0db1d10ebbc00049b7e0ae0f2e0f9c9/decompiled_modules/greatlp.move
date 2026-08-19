module 0x777b28ea04af416801219bc6aad25471d0db1d10ebbc00049b7e0ae0f2e0f9c9::greatlp {
    struct GREATLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREATLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREATLP>(arg0, 6, b"GREATLP", b"make lp great again", b"great lp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREATLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREATLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

