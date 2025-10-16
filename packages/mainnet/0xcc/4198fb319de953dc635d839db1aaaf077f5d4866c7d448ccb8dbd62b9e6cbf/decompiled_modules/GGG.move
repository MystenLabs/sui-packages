module 0xcc4198fb319de953dc635d839db1aaaf077f5d4866c7d448ccb8dbd62b9e6cbf::GGG {
    struct GGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGG>(arg0, 9, b"GGG", b"GGG", b"GGG for test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GGG>>(v1);
        0x2::coin::mint_and_transfer<GGG>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

