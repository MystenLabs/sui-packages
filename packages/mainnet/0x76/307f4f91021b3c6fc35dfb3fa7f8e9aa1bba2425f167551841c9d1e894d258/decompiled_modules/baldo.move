module 0x76307f4f91021b3c6fc35dfb3fa7f8e9aa1bba2425f167551841c9d1e894d258::baldo {
    struct BALDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALDO>(arg0, 6, b"BALDO", b"Bald Dog", b"We believe Baldo is our god, ruling the worldwelcome to the dumbest cult on SUI chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_1_5f1d788683.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

