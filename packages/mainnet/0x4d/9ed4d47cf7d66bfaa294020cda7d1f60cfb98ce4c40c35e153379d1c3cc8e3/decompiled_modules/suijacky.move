module 0x4d9ed4d47cf7d66bfaa294020cda7d1f60cfb98ce4c40c35e153379d1c3cc8e3::suijacky {
    struct SUIJACKY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIJACKY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIJACKY>>(0x2::coin::mint<SUIJACKY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUIJACKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJACKY>(arg0, 6, b"Sui Jacky Cat", b"SuiJacky", b"Sui Jacky Cat Meme Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIJACKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJACKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

