module 0xf0824aa197cbb7f0858144ffec31873a5ad5ebf99119c24b497df64ee263d3cb::piipii {
    struct PIIPII has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIIPII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIIPII>(arg0, 6, b"PIIPII", b"Piipii Coin", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIIPII>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIIPII>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PIIPII>>(v2);
    }

    // decompiled from Move bytecode v6
}

