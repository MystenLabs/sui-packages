module 0x2fffa2792c8419a9ece4cbcdd87ca78392356b30930e367f1442390aa7d754ba::lumo {
    struct LUMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LUMO>(arg0, 6, b"LUMO", b"SUI MASCOT ", x"4c756d6f20697320616e20696e74656c6c6967656e7420616e6420757365722d667269656e646c79204149206d6173636f74206372656174656420746f206f6e626f617264207820757365727320746f20537569204e6574776f726b2e2057697468206120667269656e646c792064656d65616e6f7220616e6420657870657274206b6e6f776c65646765206f6620626c6f636b636861696e20746563686e6f6c6f67792c204c756d6f2073696d706c6966696573207468652073686966742066726f6d20736f6369616c206d6564696120746f20626c6f636b636861696e2c206d616b696e6720697420616e20656e6a6f7961626c6520616e64206566666f72746c65737320657870657269656e63652ee2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/SUI_MASCOT_3d8ce7b22d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUMO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUMO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

