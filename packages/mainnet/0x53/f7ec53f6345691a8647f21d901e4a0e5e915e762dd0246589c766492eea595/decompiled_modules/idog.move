module 0x53f7ec53f6345691a8647f21d901e4a0e5e915e762dd0246589c766492eea595::idog {
    struct IDOG has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<IDOG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<IDOG>>(0x2::coin::mint<IDOG>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: IDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDOG>(arg0, 6, b"IDOG", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

