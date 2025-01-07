module 0xd5e7b5a3e2b35203af508655db2d42fe89e59b9b275d6554ed0a73534d19cd51::muradsdog {
    struct MURADSDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MURADSDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MURADSDOG>(arg0, 6, b"MuradsDog", b"Mdog", b"Murad's Real Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snipaste_2024_10_13_01_46_33_0844e4eca5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MURADSDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MURADSDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

