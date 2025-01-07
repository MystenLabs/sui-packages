module 0xe864b3ef8aa33013715bf3ec23c4f296d75be72f9a00ab426619340dafd65d30::djytwy {
    struct DJYTWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJYTWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJYTWY>(arg0, 6, b"FTWY", b"FaucetDJYTWY", b"lets move task2 faucet token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/28933.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DJYTWY>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<DJYTWY>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DJYTWY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DJYTWY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

