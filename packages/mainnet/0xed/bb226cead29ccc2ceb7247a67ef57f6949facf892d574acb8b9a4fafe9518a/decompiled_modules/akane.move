module 0xedbb226cead29ccc2ceb7247a67ef57f6949facf892d574acb8b9a4fafe9518a::akane {
    struct AKANE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKANE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKANE>(arg0, 9, b"AKANE", b"AKANE on SUI", x"74616c6b2077697468206d652c20667269656e6420cbb6e1b59420e1b59520e1b594cbb6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmX9g6UhkGQUS7WkMcxYjz4XTKQD7B29DYdNopJou4KLVA")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AKANE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AKANE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKANE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

