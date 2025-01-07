module 0x2cf4df955bb385e3e73ae667a31b4eb4ce3cb5745212ab1401e05705170f9462::kekkk {
    struct KEKKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKKK>(arg0, 6, b"KEKKK", b"kek", b"32", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/60ba45cdbfb8afc79aad40fb_L86xy_LF_4_400x400_de4eca3715.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKKK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEKKK>>(v1);
    }

    // decompiled from Move bytecode v6
}

