module 0x51e3d038968f685e91d44c0ed9fe47881fb3c399952ab455daaea252a492027e::vraptor {
    struct VRAPTOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: VRAPTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VRAPTOR>(arg0, 6, b"VRAPTOR", b"VELOCIRAPTOR", b"THE TURBO DINOSAUUUURR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954386929.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VRAPTOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VRAPTOR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

