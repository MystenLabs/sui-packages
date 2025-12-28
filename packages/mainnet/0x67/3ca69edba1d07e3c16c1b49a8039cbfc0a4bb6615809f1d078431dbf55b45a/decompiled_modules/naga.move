module 0x673ca69edba1d07e3c16c1b49a8039cbfc0a4bb6615809f1d078431dbf55b45a::naga {
    struct NAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAGA>(arg0, 6, b"NAGA", b"SUI NAGA", x"535549204e4147410a4372656174757265206f6620746865205365612021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1766900574948.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

