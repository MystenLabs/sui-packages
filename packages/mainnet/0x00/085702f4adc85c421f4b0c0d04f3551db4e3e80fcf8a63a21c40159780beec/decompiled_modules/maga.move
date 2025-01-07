module 0x85702f4adc85c421f4b0c0d04f3551db4e3e80fcf8a63a21c40159780beec::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGA>(arg0, 6, b"MAGA", b"SUI MAGA", x"234d4147415f6f6e5f535549200a426f726e20746f20224d616b65204d656d65636f696e20477265617420416761696e220a4465762069732066616d6f757320696e20746869732073706163652c20617468313330782070726576696f75732070726f6a6563740a7831303020796f75722053554920696e206d696e75746573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012612_036e24b46e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

