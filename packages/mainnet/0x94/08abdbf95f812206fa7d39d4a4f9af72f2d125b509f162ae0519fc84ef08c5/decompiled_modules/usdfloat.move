module 0x9408abdbf95f812206fa7d39d4a4f9af72f2d125b509f162ae0519fc84ef08c5::usdfloat {
    struct USDFLOAT has drop {
        dummy_field: bool,
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<USDFLOAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USDFLOAT>>(0x2::coin::mint<USDFLOAT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: USDFLOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDFLOAT>(arg0, 6, b"USDf", b"USD Float", b"Floating USD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreies7kwzfeaiflqfzrjhl4mgs7n3y76rpd4rgeit2v4n7nnkc4nxym")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USDFLOAT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDFLOAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

