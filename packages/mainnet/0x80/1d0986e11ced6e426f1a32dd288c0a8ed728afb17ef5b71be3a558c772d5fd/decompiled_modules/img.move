module 0x801d0986e11ced6e426f1a32dd288c0a8ed728afb17ef5b71be3a558c772d5fd::img {
    struct IMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IMG>(arg0, 6, b"IMG", b"Test img", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IMG>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IMG>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<IMG>>(v2);
    }

    // decompiled from Move bytecode v6
}

