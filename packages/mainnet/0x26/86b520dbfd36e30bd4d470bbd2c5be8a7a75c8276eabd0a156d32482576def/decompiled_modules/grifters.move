module 0x2686b520dbfd36e30bd4d470bbd2c5be8a7a75c8276eabd0a156d32482576def::grifters {
    struct GRIFTERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRIFTERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRIFTERS>(arg0, 9, b"GRIFT", b"grifters", b"Keep grifting and grinding. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/887ccfeb-44a5-4882-b5e6-25ef1e2c9e4c.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRIFTERS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRIFTERS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

