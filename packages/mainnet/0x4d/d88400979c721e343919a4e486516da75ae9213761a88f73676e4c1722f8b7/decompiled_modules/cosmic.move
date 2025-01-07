module 0x4dd88400979c721e343919a4e486516da75ae9213761a88f73676e4c1722f8b7::cosmic {
    struct COSMIC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<COSMIC>, arg1: 0x2::coin::Coin<COSMIC>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<COSMIC>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COSMIC>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: COSMIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COSMIC>(arg0, 6, b"$COSMIC", b"COSMIC ON SUI", b"    https://www.cosmicsui.com/   https://x.com/cosmicsui_   https://t.me/duckjokerportal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmT4p4z9w9PgymER5UddXVFwiQaLiyjw9TB6c2tMhN8nVJ")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COSMIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COSMIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<COSMIC>, arg1: 0x2::coin::Coin<COSMIC>) : u64 {
        0x2::coin::burn<COSMIC>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<COSMIC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<COSMIC> {
        0x2::coin::mint<COSMIC>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

