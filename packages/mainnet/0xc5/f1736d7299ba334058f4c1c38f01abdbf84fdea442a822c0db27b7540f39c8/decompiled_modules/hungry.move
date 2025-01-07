module 0xc5f1736d7299ba334058f4c1c38f01abdbf84fdea442a822c0db27b7540f39c8::hungry {
    struct HUNGRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUNGRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUNGRY>(arg0, 6, b"Hungry", b"Hungry Whale", b"He wants to consume everything!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/beluga_nom_b53255fd92.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUNGRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUNGRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

