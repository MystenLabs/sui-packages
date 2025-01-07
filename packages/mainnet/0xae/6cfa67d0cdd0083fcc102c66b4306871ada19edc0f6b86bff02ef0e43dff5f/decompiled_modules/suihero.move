module 0xae6cfa67d0cdd0083fcc102c66b4306871ada19edc0f6b86bff02ef0e43dff5f::suihero {
    struct SUIHERO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIHERO>, arg1: 0x2::coin::Coin<SUIHERO>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIHERO>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIHERO>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: SUIHERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHERO>(arg0, 6, b"HERO", b"Sui Hero", b"The First on-chain Casino Gaming on Sui    https://suiheroes.com/ https://x.com/Suiheroes_io  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmRh4VTUarf9aE2JxKfbD3ZReeJGScw31yXac6t4x5v6HL")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIHERO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHERO>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<SUIHERO>, arg1: 0x2::coin::Coin<SUIHERO>) : u64 {
        0x2::coin::burn<SUIHERO>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<SUIHERO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUIHERO> {
        0x2::coin::mint<SUIHERO>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

