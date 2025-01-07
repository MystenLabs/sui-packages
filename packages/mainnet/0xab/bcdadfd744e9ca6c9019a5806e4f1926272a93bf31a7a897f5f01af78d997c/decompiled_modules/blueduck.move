module 0xabbcdadfd744e9ca6c9019a5806e4f1926272a93bf31a7a897f5f01af78d997c::blueduck {
    struct BLUEDUCK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BLUEDUCK>, arg1: 0x2::coin::Coin<BLUEDUCK>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BLUEDUCK>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BLUEDUCK>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: BLUEDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEDUCK>(arg0, 6, b"BDUCK", b"Blue Duck", x"596f75206469646ee280997420617070726563696174652068696d20202068747470733a2f2f7777772e626c75656475636b2e746563682f202068747470733a2f2f782e636f6d2f626c75656475636b73756920202068747470733a2f2f742e6d652f626c75656475636b5f706f7274616c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmReUWGSCdYv1tvc8G9EvkeR7Rx5s7zP61GxHH92VtDGpD")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUEDUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEDUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<BLUEDUCK>, arg1: 0x2::coin::Coin<BLUEDUCK>) : u64 {
        0x2::coin::burn<BLUEDUCK>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<BLUEDUCK>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BLUEDUCK> {
        0x2::coin::mint<BLUEDUCK>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

