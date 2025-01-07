module 0xa685fa0a8284efc05064508172b17a990a299a1507d744de99a93dbda835a2e7::memek_ended1 {
    struct MEMEK_ENDED1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_ENDED1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_ENDED1>(arg0, 6, b"MEMEKENDED1", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_ENDED1>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_ENDED1>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_ENDED1>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

