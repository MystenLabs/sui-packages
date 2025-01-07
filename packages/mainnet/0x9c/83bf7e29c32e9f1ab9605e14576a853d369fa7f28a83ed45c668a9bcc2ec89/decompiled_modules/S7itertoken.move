module 0x9c83bf7e29c32e9f1ab9605e14576a853d369fa7f28a83ed45c668a9bcc2ec89::S7itertoken {
    struct S7ITERTOKEN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<S7ITERTOKEN>, arg1: 0x2::coin::Coin<S7ITERTOKEN>) {
        0x2::coin::burn<S7ITERTOKEN>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<S7ITERTOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<S7ITERTOKEN>>(0x2::coin::mint<S7ITERTOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: S7ITERTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S7ITERTOKEN>(arg0, 18, b"S7ITERTOKEN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<S7ITERTOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S7ITERTOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

