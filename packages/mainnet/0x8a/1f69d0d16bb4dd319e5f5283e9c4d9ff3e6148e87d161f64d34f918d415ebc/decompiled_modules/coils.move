module 0x8a1f69d0d16bb4dd319e5f5283e9c4d9ff3e6148e87d161f64d34f918d415ebc::coils {
    struct COILS has drop {
        dummy_field: bool,
    }

    fun init(arg0: COILS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COILS>(arg0, 6, b"COILS", b"COIL", b"Best dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/coil_bdfe96c0c4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COILS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COILS>>(v1);
    }

    // decompiled from Move bytecode v6
}

