module 0x82e098155b29637e88a640f5b55c1d3bfabda57973cb2ccd2aed21b67b6a4448::hopeless {
    struct HOPELESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPELESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPELESS>(arg0, 6, b"Hopeless", b"HOPELESS", b"Delayed delayed and delayed better Turbo hopfun fucking noob team", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953175602.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPELESS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPELESS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

