module 0x231c20d69f17ea7cf4385b19343f5aab3ab22bbcbe104e4925324bd08d759f6d::ekko {
    struct EKKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: EKKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EKKO>(arg0, 9, b"EKKO", b"EKKO-Platform", b"EKKO is built for the Solana memecoin ecosystem, designed as a hub rather than just a trading platform, offering cutting-edge tools, real-time insights and extremely valuable AI/Automation trading features that are currently in development. EKKO empowers users to explore and invest in new and trending tokens with confidence. Our mission is to provide the ultimate resource for discovering, tracking, and engaging with the most exciting projects in the Solana space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUmBdJqmFDwfGfPYHLuw7J323DiGFyxLLPVbVmSWjvK3d")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EKKO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EKKO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EKKO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

