module 0x86ee671e8a5f49d6faec9168457dbaae0403ed5f22cf2287e6162efc7fb2c8ee::green {
    struct GREEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREEN>(arg0, 9, b"GREEN", b"green", b"green frog alone frog. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/4c72fe56-e9ed-4b26-945c-738c47ebdc0a.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

