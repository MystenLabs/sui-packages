module 0xa3bbcfba59d423f27603c63d6c865d3d83e6ca8256a69639f8802385d7b086cd::usdt {
    struct USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT>(arg0, 6, b"USDT", b"Tether USD", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDT>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<USDT>>(v2);
    }

    // decompiled from Move bytecode v6
}

