module 0x1f6f829c5b317f26ecf541bee4214e99c4a63fc1d7749c7ea304936f30d4adfd::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TEST>(arg0, 6, 0x1::string::utf8(b"TEST"), 0x1::string::utf8(b"test"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://pub-205602358a68450eb9bf79d0af983032.r2.dev/icons/61efc0e155f45c5695e7f36a60b6acee.jpg"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TEST>>(0x2::coin_registry::finalize<TEST>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

