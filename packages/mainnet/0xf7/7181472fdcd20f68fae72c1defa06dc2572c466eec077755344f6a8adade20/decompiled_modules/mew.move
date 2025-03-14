module 0xf77181472fdcd20f68fae72c1defa06dc2572c466eec077755344f6a8adade20::mew {
    struct MEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEW>(arg0, 9, b"MEW", b"MEW MEW", b"CaT MEW AuTiSm !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNwet99TxCPr1NFsg7o6JuzZUrCti3p1f3k5q4E43mdUk")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEW>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEW>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

