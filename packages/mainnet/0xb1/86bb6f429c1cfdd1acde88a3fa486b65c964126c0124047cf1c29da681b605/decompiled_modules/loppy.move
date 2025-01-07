module 0xb186bb6f429c1cfdd1acde88a3fa486b65c964126c0124047cf1c29da681b605::loppy {
    struct LOPPY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LOPPY>, arg1: 0x2::coin::Coin<LOPPY>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LOPPY>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LOPPY>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: LOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOPPY>(arg0, 6, b"LOPPY", b"White Cat Wizard", x"24575a415244205768697465204361742077697468204d61676963616c20506f77657273206f6e20535549f09f9299202020202068747470733a2f2f782e636f6d2f77686c746563617457697a617264202068747470733a2f2f742e6d652f77686c746563617457697a617264", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmPPR59Npj4DYoq6K5zozqKY8MjVsDP6qFHSdbCMBrxkWX")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOPPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOPPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<LOPPY>, arg1: 0x2::coin::Coin<LOPPY>) : u64 {
        0x2::coin::burn<LOPPY>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<LOPPY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LOPPY> {
        0x2::coin::mint<LOPPY>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

