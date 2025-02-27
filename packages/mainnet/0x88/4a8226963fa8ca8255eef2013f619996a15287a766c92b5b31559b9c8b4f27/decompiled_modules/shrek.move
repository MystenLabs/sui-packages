module 0x884a8226963fa8ca8255eef2013f619996a15287a766c92b5b31559b9c8b4f27::shrek {
    struct SHREK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHREK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHREK>(arg0, 9, b"SHREK", b"SHREK On Sui", b"Shrek is love. Shrek is life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZAxih5sGZM4mvzf5UoZBH9b3yKNxwBpVtJbcSCaMbyfC")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHREK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHREK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHREK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

