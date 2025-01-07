module 0x4da2c53039e1bd110c73797813e00628105b3b9508620ac64d84e2728907dfa6::spons {
    struct SPONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPONS>(arg0, 6, b"SPONS", b"SPONSUI", b"Meet the spons who living in the sea of Sui, bring new waves and make big opportunities in the Sui world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_KH_k_B7_400x400_551dda7074.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

