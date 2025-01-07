module 0x620ccf7fdfcff7b8cbc136097552bd76aa12d09d1d2d4dd98d3633af990dc3::movefaucetcoin {
    struct MOVEFAUCETCOIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOVEFAUCETCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOVEFAUCETCOIN>>(0x2::coin::mint<MOVEFAUCETCOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOVEFAUCETCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEFAUCETCOIN>(arg0, 6, b"yuancehngjiayuFaucet", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOVEFAUCETCOIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MOVEFAUCETCOIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

