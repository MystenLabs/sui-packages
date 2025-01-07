module 0x86c8b1cf9556d2e1206bcc73df342eb6eaaf7f51e5a4a5e4c98c7f3af824ff16::musk {
    struct MUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSK>(arg0, 9, b"MUSK", b"ELON MUSK", b"this coin is created by elon musk", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MUSK>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

