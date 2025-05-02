module 0x5287e02c10f7bd180d8fdb938e6f90c3af0d48a32fbf216d66e1c1db0ba34de9::jjj {
    struct JJJ has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<JJJ>, arg1: 0x2::coin::Coin<JJJ>) {
        0x2::coin::burn<JJJ>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JJJ>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<JJJ>>(0x2::coin::mint<JJJ>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: JJJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JJJ>(arg0, 9, b"JJJ", b"JJJ", b"hello world", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JJJ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JJJ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

