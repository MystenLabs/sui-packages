module 0xcfb4bacacad070cef48e89be8524615ecf63273b3ef4261f26feb8dfa680d706::brun {
    struct BRUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUN>(arg0, 6, b"BRUN", b"Bull Run", x"4974e28099732064726976656e20627920686569676874656e656420696e766573746f7220636f6e666964656e63652c20706f736974697665206d61726b65742073656e74696d656e742c20616e64206f6674656e206675656c6564206279206d616a6f722061646f7074696f6e206e6577732c20696e737469747574696f6e616c20696e766573746d656e742c206f7220746563686e6f6c6f676963616c20616476616e63656d656e74732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731946067549.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

