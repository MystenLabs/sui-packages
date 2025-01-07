module 0x41eb65d1982837e3bfcaadabfe2ff4563c708431c38efae31a22f29137fb8ec6::pute {
    struct PUTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUTE>(arg0, 6, b"PUTE", b"Ma mere bouffes des bites tous les soirs", b".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture_da_A_cran_2024_10_09_140916_2dcfb2afd7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

