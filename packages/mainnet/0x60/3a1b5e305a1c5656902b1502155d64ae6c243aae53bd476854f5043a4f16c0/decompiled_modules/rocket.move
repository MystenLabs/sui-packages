module 0x603a1b5e305a1c5656902b1502155d64ae6c243aae53bd476854f5043a4f16c0::rocket {
    struct ROCKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ROCKET>(arg0, 6, b"ROCKET", b"AI Rocket by SuiAI", x"5573686572696e6720696e2061206e65772077617665206f66206469676974616c20636f6d6d6572636520f09f8c8a207c20506f776572656420627920414920696e6e6f766174696f6e20f09fa7a0207c204c6f79616c20746f206f757220636f6d6d756e69747920f09f90be205768656e206974e28099732064696e6e65722074696d652c207468652077686f6c65207061636b20656174732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/oo9on_Rf_L_400x400_abffa75dcd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROCKET>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKET>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

