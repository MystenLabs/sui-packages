module 0x42e10f89b474b995b73f06456ccde5c21bb04d52f9526064e37bdd3f5f599328::another_test {
    struct ANOTHER_TEST has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ANOTHER_TEST>, arg1: 0x2::coin::Coin<ANOTHER_TEST>) {
        0x2::coin::burn<ANOTHER_TEST>(arg0, arg1);
    }

    fun init(arg0: ANOTHER_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANOTHER_TEST>(arg0, 9, b"NOTHER", b"Another Test", b"https://api.movepump.com/uploads/Sui_Bull2_6602ec4f67.jpg", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANOTHER_TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANOTHER_TEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ANOTHER_TEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ANOTHER_TEST>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

