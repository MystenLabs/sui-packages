module 0xec43d2f9282e3a443e4526132012496317d1146629d62693120d43d092acaa5c::suido {
    struct SUIDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDO>(arg0, 6, b"SUIDO", b"Suipurdo", x"537569707572646f20697320646120747275204f47206d656d6520616e642046696e616c6c7920726565647920746f205368616b6520537569205370616365210a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_Fix_8ec322deab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

