module 0x6e8c8562888d6b5ab12eed77593d4bbdbe1840c04f6b87129d6a6dedc671d36e::zombiesui {
    struct ZOMBIESUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZOMBIESUI>, arg1: 0x2::coin::Coin<ZOMBIESUI>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZOMBIESUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ZOMBIESUI>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: ZOMBIESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOMBIESUI>(arg0, 6, b"ZOMBIE", b"ZombieSui", x"412067726f7570206f6620696e746572657374696e67205a6f6d626965732061726520747279696e6720746f2072756c65207468652063727970746f20776f726c642e2e2e205a6f6d626965e280997320747269626520697320687567652e2041726520796f752072656164793f20202068747470733a2f2f7777772e7a6f6d6269657375692e66756e2f202068747470733a2f2f782e636f6d2f7a6f6d626965737569202020202068747470733a2f2f742e6d652f7a6f6d626965737569706f7274616c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmVjMyp6dgeJZTgxKJ5WR889uAwumsK27zSV31iG28cfqi")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZOMBIESUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOMBIESUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<ZOMBIESUI>, arg1: 0x2::coin::Coin<ZOMBIESUI>) : u64 {
        0x2::coin::burn<ZOMBIESUI>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<ZOMBIESUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ZOMBIESUI> {
        0x2::coin::mint<ZOMBIESUI>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

