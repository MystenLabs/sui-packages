module 0xd5c679f03e7a1e67b08ef76e024de9f3fa29d2d91e21fd661027ebcd822b9c00::funtom {
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
        let (v0, v1) = 0x2::coin::create_currency<FUNTOM>(arg0, 6, b"FUNTOM", b"FUNTOM", x"4465782061676772656761746f722c537761702c4661726d2026204c61756e6368706164206d656d65636f696e207375692046726f6d204d656d657320746f204d696c6c696f6e733a2046756e746f6de280997320416c6c2d696e2d4f6e652043727970746f20487562204f6e202353554920202068747470733a2f2f7777772e66756e746f6d2e66756e2f2068747470733a2f2f782e636f6d2f66756e746f6d737761702068747470733a2f2f742e6d652f66756e746f6d737761702020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-shocked-dinosaur-182.mypinata.cloud/ipfs/QmfV7Rg8eX25F1gACNa3z14c4T3ipc15eDo7qpMsruZpnd")), arg1);
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

