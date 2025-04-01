module 0xacaf75ddb4cc9a514efcc8cfcf599aad689e21002edd597c4b19b844fdc749c9::flymod {
    struct FLYMOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLYMOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLYMOD>(arg0, 6, b"FLYMOD", b"FLYMOD Token", b"FlyMod prop token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1743541350693.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLYMOD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLYMOD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

