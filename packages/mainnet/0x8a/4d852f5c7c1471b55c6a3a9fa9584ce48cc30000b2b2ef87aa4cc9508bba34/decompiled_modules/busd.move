module 0x8a4d852f5c7c1471b55c6a3a9fa9584ce48cc30000b2b2ef87aa4cc9508bba34::busd {
    struct BUSD has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BUSD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<BUSD>(arg0) + arg1 <= 100290000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<BUSD>>(0x2::coin::mint<BUSD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUSD>(arg0, 6, b"BUSD", b"BUSD", b"BUSD Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.okx.com/cdn/wallet/logo/BUSD-20220308.png?x-oss-process=image/format,webp/ignore-error,1")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BUSD>>(0x2::coin::mint<BUSD>(&mut v2, 100290000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUSD>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUSD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

