module 0x6140b65c15099a37f9f7adc32d16d606c4a90680841cbcb034a5257c091f88c7::lil {
    struct LIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIL>(arg0, 6, b"LIL", b"lilcat", b"Lil is the littlest/ cutest cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734259951332.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

