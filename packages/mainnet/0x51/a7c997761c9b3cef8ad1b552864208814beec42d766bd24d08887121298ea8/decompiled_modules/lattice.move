module 0x51a7c997761c9b3cef8ad1b552864208814beec42d766bd24d08887121298ea8::lattice {
    struct LATTICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LATTICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LATTICE>(arg0, 6, b"LATTICE", b"AGENT LATTICE", b"Agent Lattice: Revolutionizing AI Assistance with Blockchain Technology", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dorcelle_b0f1d63582.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LATTICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LATTICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

