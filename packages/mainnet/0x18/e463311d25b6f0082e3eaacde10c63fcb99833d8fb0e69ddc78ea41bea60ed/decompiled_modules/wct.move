module 0x18e463311d25b6f0082e3eaacde10c63fcb99833d8fb0e69ddc78ea41bea60ed::wct {
    struct WCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCT>(arg0, 6, b"WCT", b"WalletConnect", x"57616c6c6574436f6e6e656374204e6574776f726b2069732065766f6c76696e6720696e746f2061207065726d697373696f6e6c6573732065636f73797374656d20706f77657265642062792057616c6c6574436f6e6e65637420546f6b656e20285743542920616e64206120636f6d6d756e697479206f66203335206d696c6c696f6e2075736572732e204261636b6564206279206d616a6f7220676c6f62616c206e6f6465206f70657261746f7273207375636820617320436f6e73656e7379732c2052656f776e2c204c65646765722c204b696c6e2c204669676d656e742c20457665727374616b652c204172632c20616e64204e61c3a16e656e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/47d7187f-a7ce-481e-a9cc-f29883a7a404.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

