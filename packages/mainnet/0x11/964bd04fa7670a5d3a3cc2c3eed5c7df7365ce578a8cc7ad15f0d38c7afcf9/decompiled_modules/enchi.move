module 0x11964bd04fa7670a5d3a3cc2c3eed5c7df7365ce578a8cc7ad15f0d38c7afcf9::enchi {
    struct ENCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENCHI>(arg0, 6, b"ENCHI", b"ENCHIMAKI", b"Nine years ago, En, a Shiba Inu, found a small kitten in the park where he always goes for a walk. The kitten, whose face was crumpled up with cat flu, was named \"Chimaki\" and came to live with SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/U_Dh_E_Qzi_400x400_808854ccb9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ENCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

