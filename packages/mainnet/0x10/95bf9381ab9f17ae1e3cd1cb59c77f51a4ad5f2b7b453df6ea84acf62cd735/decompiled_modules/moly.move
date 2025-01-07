module 0x1095bf9381ab9f17ae1e3cd1cb59c77f51a4ad5f2b7b453df6ea84acf62cd735::moly {
    struct MOLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOLY>(arg0, 6, b"MOLY", b"Sui Moly", b"Moly is a lil monster who loves to play with his meat. Hes been doing it since he was 5 even though back then it was only 2 inches.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_08_T190740_609_8f344df3e2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

