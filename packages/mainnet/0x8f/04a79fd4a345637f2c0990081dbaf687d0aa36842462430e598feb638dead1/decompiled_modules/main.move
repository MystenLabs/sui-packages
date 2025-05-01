module 0x8f04a79fd4a345637f2c0990081dbaf687d0aa36842462430e598feb638dead1::main {
    struct MAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAIN>(arg0, 6, b"MAIN", b"Mainstream", b"For creators to define their own terms, turning digital rights into mainstream tokens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000086663_2cf8c6e0f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

