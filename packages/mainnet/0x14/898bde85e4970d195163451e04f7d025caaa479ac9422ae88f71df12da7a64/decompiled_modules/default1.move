module 0x14898bde85e4970d195163451e04f7d025caaa479ac9422ae88f71df12da7a64::default1 {
    struct DEFAULT1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEFAULT1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEFAULT1>(arg0, 9, b"D1", b"default1", b"Default ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/b196b533-2ba0-405d-b4a7-36233f623c25.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEFAULT1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEFAULT1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

