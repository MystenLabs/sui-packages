module 0x330c7034873f994f5e6459fce0daedafb61c8c0985765fd2bce2956bf646e664::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<USDC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<USDC>(arg0) + arg1 <= 1290000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(0x2::coin::mint<USDC>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 6, b"USDC", b"USDC", b"USDC Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.coinall.ltd/cdn/web3/currency/token/small/637-0xbae207659db88bea0cbead6da0ed00aac12edcdda169e591cd41c94180b46f3b-1?v=1742202380789&x-oss-process=image/resize,m_lfit,w_100,h_100/ignore-error,1")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(0x2::coin::mint<USDC>(&mut v2, 1290000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USDC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

