module 0x896d1544a9203c389b61685e845e0c7b42e63b346675bab9e7ffebb95f8e008f::suirtle {
    struct SUIRTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRTLE>(arg0, 6, b"SUIRTLE", b"SUIRTLE THE TURTLE", b"Suirtle the Turtle can attack you when u are relaxing on the beach. Be carful with his Water gun!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sgo_UYFCM_400x400_705f8b36f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

