module 0xfc68478dd1e1a257aeb2f7a788855ba82390db29ee5518878f710b3ad5aef0d9::roaster {
    struct ROASTER has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ROASTER>, arg1: 0x2::coin::Coin<ROASTER>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ROASTER>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ROASTER>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: ROASTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROASTER>(arg0, 6, b"ROASTER", b"ROAST", x"4c6574e28099732024524f415354207468657365206d6665727321204c697665206f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmTHxkUsDjKiS2P3hTKgutvYYovUL6y6HhwmsVWUU6GZgu")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROASTER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROASTER>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<ROASTER>, arg1: 0x2::coin::Coin<ROASTER>) : u64 {
        0x2::coin::burn<ROASTER>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<ROASTER>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ROASTER> {
        0x2::coin::mint<ROASTER>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

