module 0xf03d70b8c37326289213f3b64f2ee82e6046dffca3ed26ed057c7ce8fd556565::A1LinLin1_coin {
    struct A1LINLIN1_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<A1LINLIN1_COIN>, arg1: 0x2::coin::Coin<A1LINLIN1_COIN>) {
        0x2::coin::burn<A1LINLIN1_COIN>(arg0, arg1);
    }

    fun init(arg0: A1LINLIN1_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A1LINLIN1_COIN>(arg0, 6, b"A1LinLin1_coin", b"A1LinLin1_coin", b"I love A1LinLin1_coin. I love blockchains.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A1LINLIN1_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A1LINLIN1_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<A1LINLIN1_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<A1LINLIN1_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

