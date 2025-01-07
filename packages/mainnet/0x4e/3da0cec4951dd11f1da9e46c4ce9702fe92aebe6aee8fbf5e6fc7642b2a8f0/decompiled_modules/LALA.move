module 0x4e3da0cec4951dd11f1da9e46c4ce9702fe92aebe6aee8fbf5e6fc7642b2a8f0::LALA {
    struct LALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LALA>(arg0, 9, b"LOFA", b"Lofa Trump", b"Lofa Trump Boost", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LALA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LALA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LALA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

