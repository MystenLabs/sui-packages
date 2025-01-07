module 0x815e2a7b81250fcc456cf42beed87454fda7e5033ecbf9b721b2673fcc23d51b::solanasui {
    struct SOLANASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLANASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLANASUI>(arg0, 6, b"SOLANASUI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOLANASUI>>(v1);
        0x2::coin::mint_and_transfer<SOLANASUI>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLANASUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

