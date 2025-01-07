module 0x5564548a90f9628a4d0f1a6cde393c2b9b8fed0d0ae3c623528dbae57d433fb0::funny {
    struct FUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNNY>(arg0, 6, b"FUNNY", b"FUNNY Bunny", b"The Bunny is setting up the stage..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731012922480.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUNNY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNNY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

