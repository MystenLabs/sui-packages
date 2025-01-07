module 0xcff7df687b92085f10e073a2c8c9c932406d285338efbddb20033d73bf7dd8b1::wally {
    struct WALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALLY>(arg0, 9, b"WALLY", b"Wally the Whale", b"Wally the Whale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmURYRSRppMwUBzjiArg1nYNoHU2tUdbTfzNw7KczLSXQA"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALLY>>(v1);
        0x2::coin::mint_and_transfer<WALLY>(&mut v2, 1000000000000000000, @0x30bded90ec8db063314ab82db4480c4c2e7363bc708ce37a24ec25ff99f40938, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WALLY>>(v2);
    }

    // decompiled from Move bytecode v6
}

