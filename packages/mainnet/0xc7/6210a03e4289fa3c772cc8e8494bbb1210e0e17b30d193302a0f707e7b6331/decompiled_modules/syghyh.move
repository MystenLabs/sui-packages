module 0xc76210a03e4289fa3c772cc8e8494bbb1210e0e17b30d193302a0f707e7b6331::syghyh {
    struct SYGHYH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYGHYH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYGHYH>(arg0, 9, b"SYGHYH", b"rfr.sui", b"syhyh", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SYGHYH>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYGHYH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYGHYH>>(v1);
    }

    // decompiled from Move bytecode v6
}

