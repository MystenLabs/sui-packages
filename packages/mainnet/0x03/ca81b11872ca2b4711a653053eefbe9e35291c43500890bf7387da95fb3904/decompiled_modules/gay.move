module 0x3ca81b11872ca2b4711a653053eefbe9e35291c43500890bf7387da95fb3904::gay {
    struct GAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAY>(arg0, 9, b"GAY", b"gay", b"why are you gay?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/30633152-9a83-43db-81b2-15b5d6ced0f5.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

