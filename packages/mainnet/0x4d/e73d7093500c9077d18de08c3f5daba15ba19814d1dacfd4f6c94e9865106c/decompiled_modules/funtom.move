module 0x4de73d7093500c9077d18de08c3f5daba15ba19814d1dacfd4f6c94e9865106c::funtom {
    struct FUNTOM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FUNTOM>, arg1: 0x2::coin::Coin<FUNTOM>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FUNTOM>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FUNTOM>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: FUNTOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNTOM>(arg0, 6, b"FUNTOM", b"Funtom Swap", b"From Memes To millions. Funtom All in one Crypto Hub On Sui  https://www.funtom.fun/  https://x.com/funtomswap   https://t.me/funtomswap", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmU1L6zxptpFZJSvfGyyRhQtjiuPN4cXZi1UycCtq4cFbx")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUNTOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNTOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<FUNTOM>, arg1: 0x2::coin::Coin<FUNTOM>) : u64 {
        0x2::coin::burn<FUNTOM>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<FUNTOM>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<FUNTOM> {
        0x2::coin::mint<FUNTOM>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

