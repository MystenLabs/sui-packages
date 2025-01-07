module 0x39baba1515937439a41a49f6b30f6cec0a2879bddf3a04bd46cc94b7cdf00433::sharky {
    struct SHARKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKY>(arg0, 9, b"SHARKY", b"Sharky on SUI", b"Sharky on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmNWmUyKs2V4FXJX6YV9zUkjCHrtC7mQLQQeW4kbP52quh"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHARKY>>(v1);
        0x2::coin::mint_and_transfer<SHARKY>(&mut v2, 1000000000000000000, @0x643d0251673c9c3b4c3c0996f825a2ada36913965dda7ee1907b1c87706fc1c5, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SHARKY>>(v2);
    }

    // decompiled from Move bytecode v6
}

