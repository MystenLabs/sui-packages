module 0xbc03c9556f6a07ed5e98a86f8e136a4679c203e4f794f59beb3d25120603e79e::gamestop {
    struct GAMESTOP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GAMESTOP>, arg1: 0x2::coin::Coin<GAMESTOP>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GAMESTOP>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GAMESTOP>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: GAMESTOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAMESTOP>(arg0, 6, b"GameStop ", b"GME", b"#1 Token on the #1 Blockchain on #SUI https://t.me/+YX0owz3qvsk3NWI1  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmXHniFT4cKmCLo9S2wmhTd34hePo4LhXs6itcW2vUWb8F")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAMESTOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAMESTOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<GAMESTOP>, arg1: 0x2::coin::Coin<GAMESTOP>) : u64 {
        0x2::coin::burn<GAMESTOP>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<GAMESTOP>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<GAMESTOP> {
        0x2::coin::mint<GAMESTOP>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

