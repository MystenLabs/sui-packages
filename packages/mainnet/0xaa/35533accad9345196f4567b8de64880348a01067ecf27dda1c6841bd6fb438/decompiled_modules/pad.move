module 0xaa35533accad9345196f4567b8de64880348a01067ecf27dda1c6841bd6fb438::pad {
    struct PAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAD>(arg0, 6, b"PAD", b"Smart Pad", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PAD>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAD>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PAD>>(v2);
    }

    // decompiled from Move bytecode v6
}

