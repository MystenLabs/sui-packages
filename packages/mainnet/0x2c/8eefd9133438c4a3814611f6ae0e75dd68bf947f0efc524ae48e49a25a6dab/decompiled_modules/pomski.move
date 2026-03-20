module 0x2c8eefd9133438c4a3814611f6ae0e75dd68bf947f0efc524ae48e49a25a6dab::pomski {
    struct POMSKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POMSKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POMSKI>(arg0, 6, b"Pomski", b"Pom-ski", b"Chain of dogs going for a ski - check back in for all different breads to come!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1773983756972.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POMSKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POMSKI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

