module 0x7c4c4d2dad5e4cf5cd8cc9688d2ffec80d1c85681319e260540b88f2da7430b9::duck {
    struct DUCK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DUCK>, arg1: 0x2::coin::Coin<DUCK>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DUCK>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DUCK>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: DUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCK>(arg0, 6, b"DUCK DUMP", b"DUCK", b"$DUCK DUMP on $SUI!  https://x.com/DuckCoop_", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://harlequin-payable-basilisk-127.mypinata.cloud/ipfs/QmR6Cb1fgSDN6aZ6yuXKoPGoj8kM7xXLfauEj5AskWcFhs")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<DUCK>, arg1: 0x2::coin::Coin<DUCK>) : u64 {
        0x2::coin::burn<DUCK>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<DUCK>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DUCK> {
        0x2::coin::mint<DUCK>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

