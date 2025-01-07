module 0x994340b4949be10d17296005b46298e750add6305f009c21c2a278e0be2d1f1e::token_factory {
    struct TOKEN_FACTORY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_FACTORY>(arg0, 6, b"FACT", b"FACT", b"JUST for test", 0x1::option::some<0x2::url::Url>(0x994340b4949be10d17296005b46298e750add6305f009c21c2a278e0be2d1f1e::icon::get_icon_url()), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_FACTORY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN_FACTORY>>(0x2::coin::mint<TOKEN_FACTORY>(&mut v2, 10000000000 * 0x994340b4949be10d17296005b46298e750add6305f009c21c2a278e0be2d1f1e::tools::pow(10, 6), arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN_FACTORY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

