module 0x4b99ed504b27f0105803c4fd4573af6014c150660f2cfa17bec8a575404104f3::dolf {
    struct DOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLF>(arg0, 6, b"Dolf", b"DOLF", b"$DOLF is a young and charming dolphin that confidently surfs through the chaos of #SUI meme coins! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xtuc_Tc_Dh_400x400_276af68277.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

