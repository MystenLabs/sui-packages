module 0x6091c58bb85835fa4f6113d70590a830052f7724c5a5d5383b8938218fb3c6df::suicy {
    struct SUICY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICY>(arg0, 6, b"SUICY", b"SUICY", b"SUICY the Seal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.okx.com/cdn/web3/currency/token/784-0x8989c726bf1ea8736919e41938f3801e286bc71d9612bfe250703232a375eaab::suicy::SUICY-96.png/type=default_350_0?v=1735502689979&x-oss-process=image/format,webp/ignore-error,1"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICY>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICY>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

