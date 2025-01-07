module 0x3e59ebf12a07054cfa1bb913e9b9aaaee0462e3ee9f7a73e3e51d91b3aec066c::gseal {
    struct GSEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSEAL>(arg0, 6, b"GSeal", b"GigaSeal", b"This is seal Seal Henry Olusegun Olumide Adeola Samuel aka GigaSeal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1751_1a6886318d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GSEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

