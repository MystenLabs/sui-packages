module 0x72a9f77ab2f4006953d39b35641f560d21171f5761f5169471844f749638adb3::tbsg {
    struct TBSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBSG>(arg0, 9, b"TBSG", b"TBSG Token", b"This is my TBSG coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TBSG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBSG>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TBSG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TBSG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

