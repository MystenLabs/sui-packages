module 0x4afc61ffc850f5dffcf9838b3f7d91f2335a346debbe2b207a36332502657df::hawktuah {
    struct HAWKTUAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAWKTUAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAWKTUAH>(arg0, 6, b"HAWKTUAH", b"HAWK TUAH", x"4841574b205455414820686173206a6f696e20746865206d656d65636f696e20726163652c20486f6c6465727320676574e2809973206578636c7573697665204841574b20545541482073747261696768742066726f6d206d652c204861696c65792057656c63682c206a6f696e2074686520636f6f6c2063726f77642c20666c61756e7420796f7572204841574b20545541482c20616e64206c6574e280997320686561742075702074686520626c6f636b636861696e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731012597464.JPG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAWKTUAH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAWKTUAH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

