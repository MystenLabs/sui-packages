module 0x7b6a12cb9b6faa706d01bd4e741539b0f88fadc693f2bb352d122df33cea1178::mifu {
    struct MIFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIFU>(arg0, 9, b"MIFU", b"MIFU", b"MIFU", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MIFU>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIFU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

