module 0x3edd29f415e6732538589a7b851fc1832e7d45d42ee7c481819ccce7d4d0775f::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MEME>, arg1: 0x2::coin::Coin<MEME>) {
        0x2::coin::burn<MEME>(arg0, arg1);
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME>(arg0, 9, b"MEME", b"MEME BRC-20 TOKEN on SUI", b"MEME BRC-20 TOKEN on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s1.coincarp.com/logo/1/meme-brc20.png?style=72&v=1683011319")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEME>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MEME>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

