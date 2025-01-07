module 0xb459a80e35e2437410368991a140cd59b79373641b9a8176297ac064da4d41af::froggy {
    struct FROGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGY>(arg0, 6, b"FROGGY", b"Froggy CTO", b"This is a cto for $FROGGY because dev was dumb and dumped", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_09_25_T181843_639_b1a54bbee3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

