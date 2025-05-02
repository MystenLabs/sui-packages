module 0x44c87bf6a681e8dfc09a114465569e266d7860df30d2b44b607f0af515df7b36::ika {
    struct IKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IKA>(arg0, 9, b"IKA", b"ikadotxyz", x"546865206661737465737420706172616c6c656c204d5043206e6574776f726b2c206c61756e6368696e67206f6e200a405375694e6574776f726b0a202028707265762e206457616c6c6574204e6574776f726b2920e3808cf09fa691e3808d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/309ecfbfbc44552159170957a394e80eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

