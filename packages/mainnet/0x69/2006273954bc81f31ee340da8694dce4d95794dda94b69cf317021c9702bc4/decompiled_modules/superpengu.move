module 0x692006273954bc81f31ee340da8694dce4d95794dda94b69cf317021c9702bc4::superpengu {
    struct SUPERPENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERPENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERPENGU>(arg0, 6, b"SUPERPENGU", b"SUPERSONIC PENGUIN", b"$SUPERPENGU is an innovative cryptocurrency inspired by the speed and ingenuity of a supersonic penguin. Designed to power technological, creative and entertainment projects, $SUPERPENGU combines a futuristic style with the fun of animated universes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736080143920.09")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPERPENGU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERPENGU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

