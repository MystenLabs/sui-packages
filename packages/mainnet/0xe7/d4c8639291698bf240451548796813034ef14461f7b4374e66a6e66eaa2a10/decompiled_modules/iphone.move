module 0xe7d4c8639291698bf240451548796813034ef14461f7b4374e66a6e66eaa2a10::iphone {
    struct IPHONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPHONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPHONE>(arg0, 1, b"IPHONE", b"APPLE", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IPHONE>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPHONE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IPHONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

