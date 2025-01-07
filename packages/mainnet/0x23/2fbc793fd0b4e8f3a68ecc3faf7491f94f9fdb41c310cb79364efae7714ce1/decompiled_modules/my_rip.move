module 0x232fbc793fd0b4e8f3a68ecc3faf7491f94f9fdb41c310cb79364efae7714ce1::my_rip {
    struct MY_RIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_RIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_RIP>(arg0, 6, b"RIP", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_RIP>>(v1);
        0x2::coin::mint_and_transfer<MY_RIP>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_RIP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

