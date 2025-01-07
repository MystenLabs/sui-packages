module 0xb58e1f67e1da4741c98c5ee966f566225d4182670f1142ab7e52f64b68519d71::hodor {
    struct HODOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HODOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HODOR>(arg0, 6, b"HODOR", b"HODOR SUI", b"We're now LIVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/09738758d800a4469e62872dc5450bfe_698x966_fit_8be9523f71.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HODOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HODOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

