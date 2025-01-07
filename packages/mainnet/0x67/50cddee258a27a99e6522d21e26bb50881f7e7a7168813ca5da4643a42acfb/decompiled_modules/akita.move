module 0x6750cddee258a27a99e6522d21e26bb50881f7e7a7168813ca5da4643a42acfb::akita {
    struct AKITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKITA>(arg0, 6, b"AKITA", b"AKITA on SUI", b"AKITA ON SUI | Launch on Turbos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731451387079.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AKITA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKITA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

