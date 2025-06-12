module 0x2d9e5a29e3d1250b366ab4c7cd66cbe6af52cd4473437a93d761a57b536144ce::rabbit_mod {
    struct RABBIT_MOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RABBIT_MOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RABBIT_MOD>(arg0, 9, b"rabbit", b"rabbit mod", b"rabbit disguised as a duck ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/b5816171-7b0c-4b70-a2c3-c0d25a7e673b.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RABBIT_MOD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RABBIT_MOD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

