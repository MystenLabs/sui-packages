module 0xbf61c31f10a9948376d2c9bee97d24736b3b144f0e3cef480dc7f73c8030cc67::knight {
    struct KNIGHT has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<KNIGHT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KNIGHT>>(0x2::coin::mint<KNIGHT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: KNIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNIGHT>(arg0, 9, b"KNIGHT", b"knight", b"Dark knight", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KNIGHT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<KNIGHT>>(0x2::coin::mint<KNIGHT>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNIGHT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

