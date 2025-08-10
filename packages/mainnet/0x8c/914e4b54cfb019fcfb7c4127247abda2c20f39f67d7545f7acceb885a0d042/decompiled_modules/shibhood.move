module 0x8c914e4b54cfb019fcfb7c4127247abda2c20f39f67d7545f7acceb885a0d042::shibhood {
    struct SHIBHOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBHOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBHOOD>(arg0, 6, b"SHIBHOOD", b"ShibaHood", b"The Shiba that steals from the rich, and gives to the memes. Relaunch on Moonbags.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigooch6nlrr2peocc3qtp73pfavisjfls32ab2o4rxkvkhqu2tvzq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBHOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHIBHOOD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

