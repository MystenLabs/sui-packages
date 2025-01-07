module 0xa3f2bca799bcb280eb10dbf887f3035163d93a2fc94f8885c20caaef150c40a::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPFROG>(arg0, 6, b"HOPFROG", b"Hoppy Frog", x"4f6e636520696e20612063727970746f207377616d702c2061206e696e6a612066726f67206e616d656420486f70707920646566656e646564206469676974616c20636f696e732066726f6d206861636b6572732e2057697468207377696674206d6f76657320616e6420636c6576657220746163746963732c20686520626563616d652061206c6567656e6421200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731234030466.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPFROG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPFROG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

