module 0xb72c5e21d62521692453860f556f09cf10e4434c9938d19ac59f3ed2d1117392::suiwomen {
    struct SUIWOMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWOMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWOMEN>(arg0, 6, b"SuiWomen", b"Suiwomen", x"446164647920746f6c64206d6520746f20747279206d6f766570756d700a536f204920646964210a0a2020202020204e6f7720796f752064696420697427732074727565", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000107015_0d112b3691.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWOMEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWOMEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

