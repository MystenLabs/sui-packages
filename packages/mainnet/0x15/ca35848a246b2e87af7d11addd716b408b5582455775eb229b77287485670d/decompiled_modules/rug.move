module 0x15ca35848a246b2e87af7d11addd716b408b5582455775eb229b77287485670d::rug {
    struct RUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUG>(arg0, 6, b"RUG", b"Rug Pull", b"You know you want to take the risk and ape in. Devs wouldn't dump on you. We promise. Send it! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732286318191.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

