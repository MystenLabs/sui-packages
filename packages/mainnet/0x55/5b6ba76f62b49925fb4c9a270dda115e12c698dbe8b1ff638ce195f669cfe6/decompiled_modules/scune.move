module 0x555b6ba76f62b49925fb4c9a270dda115e12c698dbe8b1ff638ce195f669cfe6::scune {
    struct SCUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCUNE>(arg0, 6, b"SCUNE", b"SUICUNE", x"506f6b656d6f6e2044657363726962656420617320626f746820612066656c696e652d6c696b6520616e6420646f672d6c696b6520506f6b6d6f6e2e0a2053756963756e652773206e616d6520636f6d65732066726f6d207375692c20746865204a6170616e65736520776f726420666f722077617465722c20616e64206b756e20666f72205072696e63", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008151_612664a42f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCUNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCUNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

