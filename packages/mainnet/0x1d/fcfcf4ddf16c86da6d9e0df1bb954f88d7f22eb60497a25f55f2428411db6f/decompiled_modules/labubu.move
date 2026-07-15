module 0x1dfcfcf4ddf16c86da6d9e0df1bb954f88d7f22eb60497a25f55f2428411db6f::labubu {
    struct LABUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABUBU>(arg0, 6, b"Labubu", b"labubu labubu ", b"HELLO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1784079184037.avif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LABUBU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABUBU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

