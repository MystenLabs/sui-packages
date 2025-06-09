module 0x1ab2f5d29ca71d2d2ee6bfd22c68c71e9f41572307d890bd87d62798ca35022d::babypengu {
    struct BABYPENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYPENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYPENGU>(arg0, 6, b"BABYPENGU", b"Baby Penguin Sui", b"Baby Penguin is going to be the best and the biggest meme on Sui, Dont fade the hype", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif2k77jikutpdcx2ngj4i3f3ig7fn2koq76e3mzjjcyvq6q27ohiy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYPENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BABYPENGU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

