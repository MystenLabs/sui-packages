module 0x66a7406e42d53b5d1579ab6f5f1971b7299042b34411f21bd6288adab8b25d99::fruitsui {
    struct FRUITSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FRUITSUI>, arg1: 0x2::coin::Coin<FRUITSUI>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FRUITSUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FRUITSUI>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: FRUITSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRUITSUI>(arg0, 6, b"FRUIT", b"FruitSui", b"$Fruits is a perfect example of how a meme-based project can evolve into a complex and highly valuable ecosystem.   https://www.fruitsui.fun/    https://x.com/fruit_sui   https://t.me/fruitsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmNsrPrPf1amVpUwzW71FhQBWMGm2TybrYEEDhTiijPmo5")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRUITSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRUITSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<FRUITSUI>, arg1: 0x2::coin::Coin<FRUITSUI>) : u64 {
        0x2::coin::burn<FRUITSUI>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<FRUITSUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<FRUITSUI> {
        0x2::coin::mint<FRUITSUI>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

