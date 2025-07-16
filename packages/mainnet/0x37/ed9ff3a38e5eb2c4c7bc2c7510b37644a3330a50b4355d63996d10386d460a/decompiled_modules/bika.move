module 0x37ed9ff3a38e5eb2c4c7bc2c7510b37644a3330a50b4355d63996d10386d460a::bika {
    struct BIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIKA>(arg0, 6, b"BIKA", b"Baby Ika", b"BIKA the supernatural force that controls the memecoin market on Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeie5dv6a5jsumycc3o5yyagxfs2czgjymt5kqelbwkwdmczdgaqmhi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BIKA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

