module 0x659749066aea37878dfe405be30e73a71f09dc794186aae127b395d8c1870425::lcat {
    struct LCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LCAT>(arg0, 6, b"LCAT", b"Liquid Cat ", b"The first unique Liquid Cat on Turbos.fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730989282770.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

