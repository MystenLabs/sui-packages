module 0xd8a5267dbaf4ed09ec64851942151fe91db90af85e22de065f2e31f10fef079e::hapika {
    struct HAPIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAPIKA>(arg0, 6, b"HAPIKA", b"Launch 5PM Today", b"No mint function. Join: https://t.me/HalfPikachu.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/EJ3mLKs.png"))), arg1);
        let v2 = v0;
        let v3 = @0x9214786164f3f501784b79ac345a8f7da448c9f83f88c915e4e0293c61cfff43;
        0x2::coin::mint_and_transfer<HAPIKA>(&mut v2, 100000000000000, v3, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAPIKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPIKA>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

