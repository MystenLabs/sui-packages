module 0xd6064603ca353f05305fe1e0702e693314377143895d24f26d3b0557fab7fe39::suimooch {
    struct SUIMOOCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMOOCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMOOCH>(arg0, 6, b"SUIMOOCH", b"SuiMooch", x"5375694d6f6f6368202d20f09f989bf09f9882f09fa491204665656420746865205375694d6f6f636820e280932041204d656d6520546f6b656e2054686174e280997320466f7265766572204d6f6f6368696e6720f09fa4a320666f7220596f75722053756920f09f92b02c20f09f8c90207777772e7375696d6f6f63682e636f6d20f09f9882", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suimooch.com/coinlogo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIMOOCH>>(0x2::coin::mint<SUIMOOCH>(&mut v2, 2500000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMOOCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOOCH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

