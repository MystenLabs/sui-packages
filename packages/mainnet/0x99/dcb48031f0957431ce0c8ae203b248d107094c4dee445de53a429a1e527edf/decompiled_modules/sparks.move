module 0x99dcb48031f0957431ce0c8ae203b248d107094c4dee445de53a429a1e527edf::sparks {
    struct SPARKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPARKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPARKS>(arg0, 6, b"Sparks", b"SparksAI", b"Sparks is a cutting-edge cryptocurrency designed to empower individuals and businesses worldwide.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738006142153.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPARKS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPARKS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

