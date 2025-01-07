module 0xf6579cd8f1d305f47e4e7b30e9f787ee8e660cfe30d1e29d246f3a26d1ea296b::lord {
    struct LORD has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<LORD>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LORD>>(arg0, arg1);
    }

    fun init(arg0: LORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LORD>(arg0, 9, b"LORD", b"Lord SUI", b"Lord Sui is meme token on SUI network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/ZZcWIxw.jpg")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<LORD>(&mut v2, 100000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LORD>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LORD>>(v1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LORD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LORD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

