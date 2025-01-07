module 0x4ba0a1a80b5acc9bd9009cf8aa60871f93fc73272b84e15e240a91e779a2e090::hapika {
    struct HAPIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAPIKA>(arg0, 6, b"HAPIKA", b"HAPIKA 5:00PM", b"No mint function. Join: https://t.me/HalfPikachu.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/EJ3mLKs.png"))), arg1);
        let v2 = v0;
        let v3 = @0x9214786164f3f501784b79ac345a8f7da448c9f83f88c915e4e0293c61cfff43;
        0x2::coin::mint_and_transfer<HAPIKA>(&mut v2, 1000000000000000, v3, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAPIKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPIKA>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

