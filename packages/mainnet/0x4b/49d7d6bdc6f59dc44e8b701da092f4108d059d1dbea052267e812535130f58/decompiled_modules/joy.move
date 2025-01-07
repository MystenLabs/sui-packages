module 0x4b49d7d6bdc6f59dc44e8b701da092f4108d059d1dbea052267e812535130f58::joy {
    struct JOY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<JOY>, arg1: 0x2::coin::Coin<JOY>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JOY>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<JOY>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: JOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOY>(arg0, 6, b"JOY SUI", b"JOY", b"$JOY on $SUI!  https://x.com/joyonsui https://t.me/joyonsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://harlequin-payable-basilisk-127.mypinata.cloud/ipfs/QmSo64UajcKbuR2c9Toe8t5EJPrNqayTZypvfoaG5L8Ejg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOY>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<JOY>, arg1: 0x2::coin::Coin<JOY>) : u64 {
        0x2::coin::burn<JOY>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<JOY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JOY> {
        0x2::coin::mint<JOY>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

