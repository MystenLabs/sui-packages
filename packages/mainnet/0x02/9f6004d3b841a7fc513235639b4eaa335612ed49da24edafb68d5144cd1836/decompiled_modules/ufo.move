module 0x29f6004d3b841a7fc513235639b4eaa335612ed49da24edafb68d5144cd1836::ufo {
    struct UFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: UFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UFO>(arg0, 6, b"UFO", b"UFOO", b"The little ufo invade the Sui to t5he moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731468320378.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UFO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UFO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

