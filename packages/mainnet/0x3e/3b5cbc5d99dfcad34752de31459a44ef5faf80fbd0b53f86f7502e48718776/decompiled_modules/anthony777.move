module 0x3e3b5cbc5d99dfcad34752de31459a44ef5faf80fbd0b53f86f7502e48718776::anthony777 {
    struct ANTHONY777 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ANTHONY777>, arg1: 0x2::coin::Coin<ANTHONY777>) {
        0x2::coin::burn<ANTHONY777>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ANTHONY777>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ANTHONY777>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: ANTHONY777, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANTHONY777>(arg0, 0, b"anthony777", b"{name}", b"Releap Profile Token: anthony777", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANTHONY777>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANTHONY777>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_only(arg0: &mut 0x2::coin::TreasuryCap<ANTHONY777>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ANTHONY777> {
        0x2::coin::mint<ANTHONY777>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

