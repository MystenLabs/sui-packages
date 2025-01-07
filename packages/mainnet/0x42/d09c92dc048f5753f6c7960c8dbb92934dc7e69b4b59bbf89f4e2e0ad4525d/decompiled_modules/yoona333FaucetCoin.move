module 0x42d09c92dc048f5753f6c7960c8dbb92934dc7e69b4b59bbf89f4e2e0ad4525d::yoona333FaucetCoin {
    struct YOONA333FAUCETCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOONA333FAUCETCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOONA333FAUCETCOIN>(arg0, 8, b"YOONA333FAUCETCOIN", b"YOONA333FAUCETCOIN", b"This is YOONA333FAUCETCOIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/167958904?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOONA333FAUCETCOIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<YOONA333FAUCETCOIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

