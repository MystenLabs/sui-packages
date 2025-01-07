module 0x98bf7ded21cffbf86a49476c53d7c7b6dd2486b30f41bdcab25aa9e44f509c15::muradsui {
    struct MURADSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MURADSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MURADSUI>(arg0, 6, b"MURADSUI", b"MURAD", x"4920616d20426974636f696e204d41787920746f204b696e67204f66204d656d65202d20546869732054696d6520666f72204d454d45205355504552204359434c452121210a446f6e74204d495353204954", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_08_at_15_41_54_a9e51fb70f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MURADSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MURADSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

