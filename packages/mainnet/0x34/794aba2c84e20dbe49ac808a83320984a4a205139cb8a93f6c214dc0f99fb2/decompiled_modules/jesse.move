module 0x34794aba2c84e20dbe49ac808a83320984a4a205139cb8a93f6c214dc0f99fb2::jesse {
    struct JESSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESSE>(arg0, 6, b"JESSE", b"asgasgas", b"ahgashgas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731011161766.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JESSE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESSE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

