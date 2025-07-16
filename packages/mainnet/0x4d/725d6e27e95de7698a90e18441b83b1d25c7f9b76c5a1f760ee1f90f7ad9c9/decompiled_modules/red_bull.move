module 0x4d725d6e27e95de7698a90e18441b83b1d25c7f9b76c5a1f760ee1f90f7ad9c9::red_bull {
    struct RED_BULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RED_BULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RED_BULL>(arg0, 9, b"RB", b"red bull", b"bull i s here and its red", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa.fun/_next/image?url=https%3A%2F%2Fkappa-dev.sgp1.cdn.digitaloceanspaces.com%2Fkappa-dev%2Fcoins%2F6cad7bc4-7f5c-415e-af87-211ea592fa14.jpg&w=640&q=75")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RED_BULL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RED_BULL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

