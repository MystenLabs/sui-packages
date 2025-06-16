module 0x52eb9f3e3482357e4adcabd6fbe74004bf111a3d711c6319bf3b64206cefee6d::ememm {
    struct EMEMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMEMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMEMM>(arg0, 9, b"EMEMM", b"emmem", b"emm memm emm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/430f658c805b78baae8c6b0e13d23d01blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EMEMM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMEMM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

