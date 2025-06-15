module 0x26cd93f08734cb4b8e3465e97b6ee5e6cc62a6718729f79bb165bd0c60832c49::frer {
    struct FRER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRER>(arg0, 6, b"FRER", b"frrtsd", b"sd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihjfnaa4svy3tf4t3vizzrkzyvmjpzqbkejdqnz3ziy7dpiiag5qu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FRER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

