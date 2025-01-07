module 0xda0b30f155b98edd21b05d7c6b8271a2d04a996902331de057aeee80e23dd5a1::flipcoin {
    struct FLIPCOIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FLIPCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FLIPCOIN>>(0x2::coin::mint<FLIPCOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FLIPCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIPCOIN>(arg0, 2, b"FLIP", b"FlipCoin", b"Your fun flippy coin!", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLIPCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIPCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

