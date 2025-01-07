module 0x542045a0eda63b80f09e4a18dddf888c77fe272ae5d656a50b88c3f8ae8166ee::laika {
    struct LAIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAIKA>(arg0, 6, b"LAIKA", b"Dog goes to moon", b"The first hero to enter space, November 3, 1957", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731325764288.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAIKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAIKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

