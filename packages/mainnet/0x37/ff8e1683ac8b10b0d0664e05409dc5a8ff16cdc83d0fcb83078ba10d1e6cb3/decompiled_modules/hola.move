module 0x37ff8e1683ac8b10b0d0664e05409dc5a8ff16cdc83d0fcb83078ba10d1e6cb3::hola {
    struct HOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLA>(arg0, 9, b"HOLA", b"Hola Coin", b"Hola, brother!", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<HOLA>(&mut v2, 1000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLA>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

