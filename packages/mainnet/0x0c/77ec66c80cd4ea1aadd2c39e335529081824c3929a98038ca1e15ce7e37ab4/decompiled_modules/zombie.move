module 0xc77ec66c80cd4ea1aadd2c39e335529081824c3929a98038ca1e15ce7e37ab4::zombie {
    struct ZOMBIE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZOMBIE>, arg1: 0x2::coin::Coin<ZOMBIE>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZOMBIE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ZOMBIE>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: ZOMBIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOMBIE>(arg0, 6, b"ZOMBIE", x"5a6f6d62696520537569f09fa79fe2808de29982", x"412067726f7570206f6620696e746572657374696e67205a6f6d626965732061726520747279696e6720746f2072756c65207468652063727970746f20776f726c642e2e2e205a6f6d626965e280997320747269626520697320687567652e20202068747470733a2f2f7777772e7a6f6d6269657375692e66756e2f2020202068747470733a2f2f782e636f6d2f7a6f6d62696573756920202068747470733a2f2f742e6d652f7a6f6d626965737569706f7274616c2020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmVjMyp6dgeJZTgxKJ5WR889uAwumsK27zSV31iG28cfqi")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZOMBIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOMBIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<ZOMBIE>, arg1: 0x2::coin::Coin<ZOMBIE>) : u64 {
        0x2::coin::burn<ZOMBIE>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<ZOMBIE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ZOMBIE> {
        0x2::coin::mint<ZOMBIE>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

