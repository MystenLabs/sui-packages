module 0xac8be466c44fe9b977d8b5a67a7b9e1d638b7395eca3ebbcc4019ce878272336::KYOSHI {
    struct KYOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KYOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KYOSHI>(arg0, 8, b"KYOSHI", b"Sui Kyoshi", b"Kyoshi The Cat Avatar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmThMkMp2Tz88xVw1mxU2Tv3pZY7iojKnFoJxCjsMggh6D?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KYOSHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<KYOSHI>>(0x2::coin::mint<KYOSHI>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KYOSHI>>(v2);
    }

    // decompiled from Move bytecode v6
}

