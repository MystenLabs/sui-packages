module 0xd5435547a1d2cc358ad0cc8c537f0a76df20c54b45242ef60637b4dfd92ae9e6::uswt {
    struct USWT has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<USWT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<USWT>(arg0) + arg1 <= 100290000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<USWT>>(0x2::coin::mint<USWT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: USWT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USWT>(arg0, 6, b"USWT", b"USWT", b"USWT Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.coinall.ltd/cdn/wallet/logo/USWT-20220308.png?x-oss-process=image/format,webp/ignore-error,1")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<USWT>>(0x2::coin::mint<USWT>(&mut v2, 100290000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USWT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USWT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

