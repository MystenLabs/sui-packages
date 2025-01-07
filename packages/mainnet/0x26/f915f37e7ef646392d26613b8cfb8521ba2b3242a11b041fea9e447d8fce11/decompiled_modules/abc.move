module 0x26f915f37e7ef646392d26613b8cfb8521ba2b3242a11b041fea9e447d8fce11::abc {
    struct ABC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ABC>, arg1: 0x2::coin::Coin<ABC>) {
        0x2::coin::burn<ABC>(arg0, arg1);
    }

    fun init(arg0: ABC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABC>(arg0, 9, b"ABC", b"ABC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABC>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ABC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ABC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

