module 0xb74d6946c25b1c9e3a45ad8092a063a526507a468279d0d33b8714b0ce413581::izumi {
    struct IZUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IZUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IZUMI>(arg0, 6, b"IZUMI", b"SuiIzumiInu", b"Izumi is a symbol of the \"legend\" of savior dogs in Japan ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000753_cc08996275.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IZUMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IZUMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

