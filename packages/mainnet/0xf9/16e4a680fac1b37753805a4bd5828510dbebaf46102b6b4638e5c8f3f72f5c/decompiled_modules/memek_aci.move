module 0xf916e4a680fac1b37753805a4bd5828510dbebaf46102b6b4638e5c8f3f72f5c::memek_aci {
    struct MEMEK_ACI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_ACI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_ACI>(arg0, 6, b"MEMEKACI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_ACI>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_ACI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_ACI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

