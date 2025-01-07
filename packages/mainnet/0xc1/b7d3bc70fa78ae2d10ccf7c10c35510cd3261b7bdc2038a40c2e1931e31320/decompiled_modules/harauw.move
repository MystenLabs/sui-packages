module 0xc1b7d3bc70fa78ae2d10ccf7c10c35510cd3261b7bdc2038a40c2e1931e31320::harauw {
    struct HARAUW has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARAUW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARAUW>(arg0, 6, b"Harauw", b"asdasd", b"asdas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956261210.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HARAUW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARAUW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

