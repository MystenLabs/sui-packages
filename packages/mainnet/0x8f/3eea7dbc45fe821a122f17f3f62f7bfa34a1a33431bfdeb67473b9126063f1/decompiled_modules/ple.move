module 0x8f3eea7dbc45fe821a122f17f3f62f7bfa34a1a33431bfdeb67473b9126063f1::ple {
    struct PLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLE>(arg0, 6, b"PLE", b"Welone", b"The Free Dome ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1755274207728.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

