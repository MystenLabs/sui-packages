module 0x57dc329ea8631bb854c6c55820eabf3faf35c9239653b5e50280bbd8cbb6e960::suitar {
    struct SUITAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITAR>(arg0, 6, b"SUITAR", b"Sui Guitar", x"526f636b206f75742077697468202453554954415221205468697320746f6b656e20736872656473207468726f7567682074686520537569204e6574776f726b2c207269666620627920726966662e20506c756720696e2c207475726e2075702074686520766f6c756d652c20616e64206c657473206a616d2e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_3_e3a8faa3b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

