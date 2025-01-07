module 0x5c3c76f436149d72239ad87821f2af46b15b80c8bac80d76ebb5c4869ae6d126::uisiu {
    struct UISIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: UISIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UISIU>(arg0, 6, b"UISIU", b"uisiu", b"uisiu", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UISIU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<UISIU>>(0x2::coin::mint<UISIU>(&mut v2, 210000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UISIU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

