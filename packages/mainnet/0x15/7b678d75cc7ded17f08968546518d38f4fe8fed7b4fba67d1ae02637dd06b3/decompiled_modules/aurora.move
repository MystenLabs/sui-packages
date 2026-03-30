module 0x157b678d75cc7ded17f08968546518d38f4fe8fed7b4fba67d1ae02637dd06b3::aurora {
    struct AURORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURORA>(arg0, 6, b"AURORA", b"Aurora Meme", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AURORA>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AURORA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AURORA>>(v2);
    }

    // decompiled from Move bytecode v6
}

