module 0x88892a81866f61b9f65b227ed61768a8543ef3853657ed2904c1600064f4dbe4::pol {
    struct POL has drop {
        dummy_field: bool,
    }

    fun init(arg0: POL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POL>(arg0, 9, b"POL", b"pol", b"Polly ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/8eca3567-8da7-4fbb-9eae-d004310a3898.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

