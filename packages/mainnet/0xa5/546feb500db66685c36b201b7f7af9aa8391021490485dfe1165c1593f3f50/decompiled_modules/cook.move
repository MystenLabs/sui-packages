module 0xa5546feb500db66685c36b201b7f7af9aa8391021490485dfe1165c1593f3f50::cook {
    struct COOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOK>(arg0, 6, b"COOK", b"Cook On Sui", x"2053746f7279206f662024434f4f4b0a0a4f6e63652c20696e20746865206275737920776f726c64206f662063727970746f2c2074686572652077617320612066616d6f75732063686566206e616d656420436f6f6b69652e20436f6f6b6965206c6f76656420636f6f6b696e6720616e642077616e74656420746f206272696e672070656f706c6520746f676574686572207769746820686973206661766f7269746520726563697065732e20536f2c2068652068616420612062696720696465613a206372656174652061206e6577206d656d65636f696e206e616d65642024434f4f4b210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731526110977.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COOK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

