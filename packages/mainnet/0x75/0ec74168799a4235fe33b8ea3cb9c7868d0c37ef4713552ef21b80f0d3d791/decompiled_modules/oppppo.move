module 0x750ec74168799a4235fe33b8ea3cb9c7868d0c37ef4713552ef21b80f0d3d791::oppppo {
    struct OPPPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPPPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPPPPO>(arg0, 6, b"OPPPPO", b"oppppo", b"oppppo", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPPPPO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<OPPPPO>>(0x2::coin::mint<OPPPPO>(&mut v2, 210000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPPPPO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

