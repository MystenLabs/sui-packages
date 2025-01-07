module 0x3b8a65521d7b7a8fadc8f61ec0ed1bf6ecad3830f6005ef8bcabe3cbf07e4512::smoke {
    struct SMOKE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SMOKE>, arg1: 0x2::coin::Coin<SMOKE>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SMOKE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SMOKE>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: SMOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOKE>(arg0, 6, b"SMOKE", b"SMOKE", b"wssshhh  https://x.com/smokepurpp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://harlequin-payable-basilisk-127.mypinata.cloud/ipfs/Qmc9QozJD6YyWSEWkt2bdeqdX35W2SzwrjXisLKbjFxePd")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMOKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<SMOKE>, arg1: 0x2::coin::Coin<SMOKE>) : u64 {
        0x2::coin::burn<SMOKE>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<SMOKE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SMOKE> {
        0x2::coin::mint<SMOKE>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

