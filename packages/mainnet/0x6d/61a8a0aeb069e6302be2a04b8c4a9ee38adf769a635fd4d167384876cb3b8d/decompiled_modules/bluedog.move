module 0x6d61a8a0aeb069e6302be2a04b8c4a9ee38adf769a635fd4d167384876cb3b8d::bluedog {
    struct BLUEDOG has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BLUEDOG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BLUEDOG>>(0x2::coin::mint<BLUEDOG>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BLUEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEDOG>(arg0, 6, b"Sui Blue Dog", b"sBlueDog", b"Sui Blue Dog Meme Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUEDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

