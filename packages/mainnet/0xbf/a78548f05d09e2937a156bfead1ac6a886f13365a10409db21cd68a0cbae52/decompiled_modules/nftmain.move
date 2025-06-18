module 0xbfa78548f05d09e2937a156bfead1ac6a886f13365a10409db21cd68a0cbae52::nftmain {
    struct NFTMAIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NFTMAIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NFTMAIN>>(0x2::coin::mint<NFTMAIN>(arg0, arg1 * 1000000000, arg3), arg2);
    }

    fun init(arg0: NFTMAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NFTMAIN>(arg0, 9, b"NFTMAIN", b"mainnet nft", x"6d79206d61696e6e6574206e667420676174650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://plz.money/coin-icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<NFTMAIN>>(0x2::coin::mint<NFTMAIN>(&mut v2, 1 * 1000000000 / 100 * 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NFTMAIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFTMAIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

