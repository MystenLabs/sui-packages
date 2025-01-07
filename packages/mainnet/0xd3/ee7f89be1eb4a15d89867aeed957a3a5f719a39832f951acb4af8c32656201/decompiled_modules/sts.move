module 0xd3ee7f89be1eb4a15d89867aeed957a3a5f719a39832f951acb4af8c32656201::sts {
    struct STS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STS>(arg0, 6, b"STS", b"Satoshi's Shadow", x"57656c636f6d6520746f2074686520776f726c64206f66205361746f736869277320536861646f772120466f6c6c6f772074686520736861646f772e20457665727920707572636861736520616e642073616c65206272696e677320796f7520636c6f73657220746f207468652074727574682e204b656570206d6f76696e6774686520736861646f7720776f6e27742066696e6420697473656c662e2e2e2e2e2e2e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_6_9b70a94033.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STS>>(v1);
    }

    // decompiled from Move bytecode v6
}

