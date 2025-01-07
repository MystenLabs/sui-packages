module 0x2ab1c0ea1e6e3a386b4140cac7c0777c2e0c56c4bb24eb910264b1375660f6a::ebtc {
    struct EBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: EBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EBTC>(arg0, 6, b"EBTC", b"EBTC On SUI", b"Just BTC.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gmq_F7m_UH_400x400_f74b2467f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

