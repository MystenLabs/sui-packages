module 0x2d8c1edbd946c063603cd98a454ae5407174191c178462420f0a5c113bccbedc::vncc {
    struct VNCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: VNCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VNCC>(arg0, 6, b"VNCC", b"Vietnam Crypto Community Coin On SUI", x"57656c636f6d6520746f20566965746e616d2043727970746f20436f6d6d756e697479210a4c65742773206275696c6420746865207374726f6e676573742063727970746f20636f6d6d756e69747920746f676574686572210a547769747465723a2068747470733a2f2f782e636f6d2f766e63636f6e7375690a54473a2068747470733a2f2f742e6d652f766e63636f6e7375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/co_f8f983cb16.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VNCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VNCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

