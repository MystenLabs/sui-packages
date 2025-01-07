module 0x21774b095553e160e313abaf3a7efb7aa6fef96b7ea8ac3be308398a4cb80492::seal {
    struct SEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAL>(arg0, 6, b"SEAL", b"Sui Seal", x"4d65657420537569205365616c2c20476c6964696e67207468726f75676820746865206465657020776174657273206f662074686520537569206e6574776f726b2c2074686973207365616c20697320736c65656b2c2073776966742c20616e6420726561647920746f206d616b652077617665732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiseal_1_7ac7b448ac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

