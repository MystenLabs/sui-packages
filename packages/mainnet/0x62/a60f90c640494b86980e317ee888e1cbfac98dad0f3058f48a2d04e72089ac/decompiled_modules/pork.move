module 0x62a60f90c640494b86980e317ee888e1cbfac98dad0f3058f48a2d04e72089ac::pork {
    struct PORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORK>(arg0, 9, b"PORK", b"PepeFork", b"PepeFork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JlnJrEg.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PORK>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

