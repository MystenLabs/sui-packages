module 0x91e92859fd0be47aa4682f3f0fa70239185005c6481d802800d8b031b873572d::cbtc {
    struct CBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBTC>(arg0, 6, b"CBTC", b"Canadian Bitcoin", x"43616e616469616e20426974636f696e2069736ee2809974206a7573742061206d656d6520636f696e3b206974e28099732061206d6f76656d656e742e204275696c74206f6e20746865207072696e6369706c6573206f6620706f6c6974656e6573732c20636f6c642073746f7261676520286c69746572616c6c79292c20616e642074686520706f776572206f66206d61706c652073797275702c20434254432069732074686520636f696e207468617420736179732022536f72727922207768696c6520697420736b79726f636b65747320696e2076616c75652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732160196173.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

