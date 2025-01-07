module 0xd2474e0743aaedce8fe8823f2375a2ff7219bc9aa5aac2eff820d45d15b3bdfd::sharky {
    struct SHARKY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHARKY>, arg1: 0x2::coin::Coin<SHARKY>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHARKY>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHARKY>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: SHARKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKY>(arg0, 6, b"Sui Sharky", b"SHARKY", b"This is a coin that I created along my journey to learn Sui Move!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0x1a033e52c3b72a4bebb34fee1b323a8dec0654e7efda00186659eece1f775574::sharky::sharky.png?size=xl&key=095715")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHARKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<SHARKY>, arg1: 0x2::coin::Coin<SHARKY>) : u64 {
        0x2::coin::burn<SHARKY>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<SHARKY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SHARKY> {
        0x2::coin::mint<SHARKY>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

