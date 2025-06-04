module 0x146e853b3a3ce8481a3b4c22cb74a145b526f4b9d6ba0ae8f0685a160a1338a8::flub {
    struct FLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUB>(arg0, 6, b"Flub", b"Flubcoin", b"Flub is the Blub Littlebro!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihgddlfy3dc4kfn5edgxjmilau6ebfi3ontywhal67gzrapdxyipu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLUB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

