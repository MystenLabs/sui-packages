module 0x6bf20b2f731c253d76d3345fb836710ec2ad91e3c8064d222f0b1e8b41a4e7cc::hopdog {
    struct HOPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPDOG>(arg0, 6, b"HOPDOG", b"hopdogsui", b"HOPDOG1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956289161.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

