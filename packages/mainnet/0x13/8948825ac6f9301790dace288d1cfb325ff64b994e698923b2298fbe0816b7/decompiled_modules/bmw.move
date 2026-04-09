module 0x138948825ac6f9301790dace288d1cfb325ff64b994e698923b2298fbe0816b7::bmw {
    struct BMW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMW>(arg0, 6, b"BMW", b"BMW Coin", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BMW>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BMW>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BMW>>(v2);
    }

    // decompiled from Move bytecode v6
}

