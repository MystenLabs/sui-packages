module 0x2621546364e2a7c92b970b2e2fbe0c0753fce52222d69de75e462d3993b9cba8::suimoodeng {
    struct SUIMOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMOODENG>(arg0, 6, b"SuiMooDeng", b"Sui Moo Deng", b"just a viral lil hippo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_ae_a_2024_09_25_142930_e3437b29c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

