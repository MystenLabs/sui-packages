module 0x5fb89c86c1852c5fc1cb3a5e2c75dbdda5ce6b0e87f55bfeb764517fa1c8dfa0::s18 {
    struct S18 has drop {
        dummy_field: bool,
    }

    fun init(arg0: S18, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S18>(arg0, 6, b"S18", b"Sui Glock 18", b"Locked, loaded, and ready for action on Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_50_acbc036346.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S18>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S18>>(v1);
    }

    // decompiled from Move bytecode v6
}

