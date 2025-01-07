module 0x1dd12a25f886d44ae4cb76327ed7498f6c709aa224c2e9effe7ee976453e2470::swee_u {
    struct SWEE_U has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SWEE_U>, arg1: 0x2::coin::Coin<SWEE_U>) {
        0x2::coin::burn<SWEE_U>(arg0, arg1);
    }

    fun init(arg0: SWEE_U, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWEE_U>(arg0, 6, b"SWEE_USDT", b"SWEE_U USDT Coin", b"SWEE_U USDT by Test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWEE_U>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWEE_U>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SWEE_U>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SWEE_U>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

