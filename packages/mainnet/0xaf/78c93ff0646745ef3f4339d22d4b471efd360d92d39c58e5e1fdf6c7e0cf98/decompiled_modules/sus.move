module 0xaf78c93ff0646745ef3f4339d22d4b471efd360d92d39c58e5e1fdf6c7e0cf98::sus {
    struct SUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUS>(arg0, 6, b"SUS", b"SUIYAN SCAMMED US", b"SUIYAN scammed us all on launch. Let's send this further than their entire project. This is what a fair launch looks like. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731005327417.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

