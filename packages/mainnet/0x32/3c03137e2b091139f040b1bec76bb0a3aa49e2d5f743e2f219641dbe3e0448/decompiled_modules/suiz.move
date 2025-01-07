module 0x323c03137e2b091139f040b1bec76bb0a3aa49e2d5f743e2f219641dbe3e0448::suiz {
    struct SUIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZ>(arg0, 9, b"SUIZ", b"Suiz Twitter: @suizzle_", b"Suiz", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIZ>(&mut v2, 77777777000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

