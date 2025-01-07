module 0x23f085baa1ffc0727b63f267423a40b74ba9449f212c35a6d9c5382ef0d06b9b::zeus {
    struct ZEUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEUS>(arg0, 6, b"ZEUS", b"ZEUS by Matt Furie", x"5a65757320696c6c7573747261746573204d6174742046757269650a696e2074686520776f726c64206f662050657065207468652046726f672e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/copy_28987_A9_C_3_EEF_46_F4_9374_EF_7_EDB_5_BB_665_7f13771659.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZEUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

