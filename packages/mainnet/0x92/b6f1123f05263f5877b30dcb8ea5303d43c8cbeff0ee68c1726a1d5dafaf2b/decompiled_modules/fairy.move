module 0x92b6f1123f05263f5877b30dcb8ea5303d43c8cbeff0ee68c1726a1d5dafaf2b::fairy {
    struct FAIRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAIRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAIRY>(arg0, 6, b"Fairy", b"Anime Fairy", b"Just Beautiful Girl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731093976913.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAIRY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAIRY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

