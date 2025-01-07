module 0x4e93295112b21bf1da0f1f2076e6e71c217b4ed43296e3513b4fbe21c807b752::trump_sui {
    struct TRUMP_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP_SUI>(arg0, 9, b"TRUMP_SUI", b"TRUMP", x"496e74726f647563696e6720746865205472756d70436f696e3a204d616b652043727970746f20477265617420416761696e2120f09f92b0f09f9a80205768657468657220796f7527726520612066616e206f72206a757374206c6f7665206120676f6f64206d656d652c205472756d70436f696e206973206865726520746f207368616b65207570207468652063727970746f20776f726c642077697468206120746f756368206f662068756d6f7220616e6420612077686f6c65206c6f74206f66206368617261637465722e20427579206e6f7720616e64206a6f696e20746865206d6f76656d656e7421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/617a57f1359e0c1ca7c53cd3123b4472blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

