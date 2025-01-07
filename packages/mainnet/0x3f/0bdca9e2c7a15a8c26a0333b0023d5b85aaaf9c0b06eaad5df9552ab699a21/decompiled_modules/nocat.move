module 0x3f0bdca9e2c7a15a8c26a0333b0023d5b85aaaf9c0b06eaad5df9552ab699a21::nocat {
    struct NOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOCAT>(arg0, 6, b"NOCAT", b"DONT EAT MY CAT", x"50656f706c65206f6620537072696e676669656c642c20706c6561736520646f6e277420656174206d7920636174210a0a57656c636f6d6520746f20244e4f4341542120496e737069726564206279207468652062697a617272652079657420766972616c20696e636964656e747320696e20537072696e676669656c642028616e642061206365727461696e20507265736964656e742773206d656d6f7261626c6520636f6d6d656e74617279292c20244e4f434154206973206a7573742061206d656d6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732723689708.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

