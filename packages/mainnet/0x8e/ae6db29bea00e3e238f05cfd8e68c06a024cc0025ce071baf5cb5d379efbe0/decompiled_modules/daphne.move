module 0x8eae6db29bea00e3e238f05cfd8e68c06a024cc0025ce071baf5cb5d379efbe0::daphne {
    struct DAPHNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAPHNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAPHNE>(arg0, 6, b"DAPHNE", b"DAPHNE on SUI", b"DaphneSol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yx_K_x_Fvm_400x400_114e3114eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAPHNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAPHNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

