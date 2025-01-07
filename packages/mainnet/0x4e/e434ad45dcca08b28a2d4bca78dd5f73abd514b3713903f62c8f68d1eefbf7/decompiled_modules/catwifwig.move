module 0x4ee434ad45dcca08b28a2d4bca78dd5f73abd514b3713903f62c8f68d1eefbf7::catwifwig {
    struct CATWIFWIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATWIFWIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATWIFWIG>(arg0, 6, b"CATWIFWIG", b"CATWIFWIG  SUI", b"THE CAT BUDDY OF DOGE wearing a wig. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_22_14_43_fa4c07fa73.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATWIFWIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATWIFWIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

