module 0x8afa2256c12b5466d23d79f068f65afd2151c1979a156209079bce221a1a4e0::suink {
    struct SUINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINK>(arg0, 6, b"SUINK", b"Suink The Hippo", b"This Hippo Has A Sink For A Mouth LOLOLOLOL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_03_at_10_15_09_AM_1_30ee84d4b1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

