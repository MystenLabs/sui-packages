module 0x5a10f17ea6d7c7e2da1de5c858b9443bbdfaf300214790bbb8ad9ec967ba223b::uopt {
    struct UOPT has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<UOPT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<UOPT>(arg0) + arg1 <= 100290000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<UOPT>>(0x2::coin::mint<UOPT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: UOPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UOPT>(arg0, 6, b"UOPT", b"UOPT", b"UOPT Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.coinall.ltd/cdn/wallet/logo/UOPT-20220308.png?x-oss-process=image/format,webp/ignore-error,1")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<UOPT>>(0x2::coin::mint<UOPT>(&mut v2, 100290000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UOPT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UOPT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

