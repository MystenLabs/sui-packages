module 0x9de3fc37e764acd59205609b3bfca3396522a16e6e0e24132f2cfa2cd0a48d29::flap {
    struct FLAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAP>(arg0, 6, b"FLAP", b"Flappy Bird", b"Flappy Bird Gameplay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731655348296.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLAP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

