module 0xca9c7bb11711716be7c7fd5ab6bfc1f07da94f5585a636b07c018cace18ec56f::xu8117faucetcoin {
    struct XU8117FAUCETCOIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<XU8117FAUCETCOIN>, arg1: 0x2::coin::Coin<XU8117FAUCETCOIN>) {
        0x2::coin::burn<XU8117FAUCETCOIN>(arg0, arg1);
    }

    fun init(arg0: XU8117FAUCETCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XU8117FAUCETCOIN>(arg0, 8, b"XU8117XU8117FAUCETCOIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XU8117FAUCETCOIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<XU8117FAUCETCOIN>>(v0);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<XU8117FAUCETCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<XU8117FAUCETCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

