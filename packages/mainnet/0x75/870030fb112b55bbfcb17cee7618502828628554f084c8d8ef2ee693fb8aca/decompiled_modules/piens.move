module 0x75870030fb112b55bbfcb17cee7618502828628554f084c8d8ef2ee693fb8aca::piens {
    struct PIENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIENS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PIENS>(arg0, 6, b"PIENS", b"Suipiens by SuiAI", x"4d656d6520636f696e20696e204f4720436f6d6d756e697479206f6e20245375692045636f73797374656d2e20202e536861726520746865206e6577732c20737472617465677920746f206275696c6420796f7572207765616c7468206f6e205375696e6574776f726bf09f92a7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/n_Sx_W_Miq_T_400x400_3932f4b838.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIENS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIENS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

