module 0x88a1731357aa18800ce0a20ece2cb7d6af5709309a692decfbdf2e2d0e41637b::testtt {
    struct TESTTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTTT>(arg0, 9, b"TESTTT", b"TESTTT", b"TESTTT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6TrakUcDrsHf-41q2AsXH6ifQrgV76oIGCw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTTT>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTTT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTTT>>(v2);
    }

    // decompiled from Move bytecode v6
}

