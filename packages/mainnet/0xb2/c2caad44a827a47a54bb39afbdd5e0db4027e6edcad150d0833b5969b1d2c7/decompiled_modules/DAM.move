module 0xb2c2caad44a827a47a54bb39afbdd5e0db4027e6edcad150d0833b5969b1d2c7::DAM {
    struct DAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAM>(arg0, 9, b"DAM", b"DAM", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suibeaver.xyz/images/logo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAM>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DAM>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<DAM>>(0x2::coin::mint<DAM>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

