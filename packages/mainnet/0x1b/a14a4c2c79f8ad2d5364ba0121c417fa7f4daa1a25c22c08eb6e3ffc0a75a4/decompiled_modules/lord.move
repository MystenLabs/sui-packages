module 0x1ba14a4c2c79f8ad2d5364ba0121c417fa7f4daa1a25c22c08eb6e3ffc0a75a4::lord {
    struct LORD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LORD>, arg1: 0x2::coin::Coin<LORD>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LORD>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LORD>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: LORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LORD>(arg0, 6, b"Lord Sui", b"LORD", b"Join Lord Sui  https://x.com/lordsui_ ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmdPZxUpbEb4hSczTBvCXEXWPKq2qyWpKchhsGXSbVPfJr")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LORD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LORD>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<LORD>, arg1: 0x2::coin::Coin<LORD>) : u64 {
        0x2::coin::burn<LORD>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<LORD>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LORD> {
        0x2::coin::mint<LORD>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

