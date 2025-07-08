module 0xc13bdcd40efb1d4d3c82de1769c25e4fe1c716ae9b37291d5c85ba265af66469::New {
    struct NEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEW>(arg0, 9, b"NEW", b"New", b"new coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/5fa3f3c7-f755-49c2-99bc-e5d0f9468abc.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

