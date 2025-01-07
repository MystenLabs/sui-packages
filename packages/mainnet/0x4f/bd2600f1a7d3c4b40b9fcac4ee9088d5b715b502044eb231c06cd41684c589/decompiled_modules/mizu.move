module 0x4fbd2600f1a7d3c4b40b9fcac4ee9088d5b715b502044eb231c06cd41684c589::mizu {
    struct MIZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIZU>(arg0, 6, b"MIZU", b"MIZU IS SUI", b"Mizu is a Japanese word that means water", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9e_C_Ks6r_S_400x400_48e2732abb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIZU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIZU>>(v1);
    }

    // decompiled from Move bytecode v6
}

