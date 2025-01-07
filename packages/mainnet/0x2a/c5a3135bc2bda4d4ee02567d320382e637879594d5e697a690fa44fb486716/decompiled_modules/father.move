module 0x2ac5a3135bc2bda4d4ee02567d320382e637879594d5e697a690fa44fb486716::father {
    struct FATHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATHER>(arg0, 6, b"Father", b"Father sui", x"53756920666174686572200a0a4e6f20736f6369616c200a4e6f2077656273697465200a436f6d6d756e6974792068616e646c6520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029059_50eb9a2084.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FATHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

