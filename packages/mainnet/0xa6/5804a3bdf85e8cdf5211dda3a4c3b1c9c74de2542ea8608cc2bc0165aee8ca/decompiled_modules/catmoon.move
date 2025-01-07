module 0xa65804a3bdf85e8cdf5211dda3a4c3b1c9c74de2542ea8608cc2bc0165aee8ca::catmoon {
    struct CATMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATMOON>(arg0, 6, b"CATMOON", b"CAT MOON SUI", b"Immortalizing the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GX_7_Yca6_Ws_A_Ai_Utn_78b568792a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

