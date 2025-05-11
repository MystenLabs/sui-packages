module 0x6a48ef21d6056c8aa4e695bb0c86d139bed984ec20ed2a084fe0d03f122986e::rob {
    struct ROB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROB>(arg0, 9, b"ROB", b"ROB", b"ROB", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<ROB>>(0x2::coin::mint<ROB>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

