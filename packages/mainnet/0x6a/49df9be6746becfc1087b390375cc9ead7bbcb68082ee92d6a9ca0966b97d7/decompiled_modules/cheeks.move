module 0x6a49df9be6746becfc1087b390375cc9ead7bbcb68082ee92d6a9ca0966b97d7::cheeks {
    struct CHEEKS has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHEEKS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CHEEKS>>(0x2::coin::mint<CHEEKS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CHEEKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEEKS>(arg0, 9, b"CHEEKS", b"SUIEET CHEEKS", b"Living the SUIEET Life Under the Sea", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEEKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEEKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

