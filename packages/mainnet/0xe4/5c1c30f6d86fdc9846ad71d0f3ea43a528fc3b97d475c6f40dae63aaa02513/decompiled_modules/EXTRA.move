module 0xe45c1c30f6d86fdc9846ad71d0f3ea43a528fc3b97d475c6f40dae63aaa02513::EXTRA {
    struct EXTRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXTRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXTRA>(arg0, 9, b"DOG", b"Dog Elon", b"Dog Elon usa", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EXTRA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EXTRA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXTRA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

