module 0x90d6fadaec7ed34c3e69cabfe2de3c77fb9ca834eb79dd948e9f891a6464ffaf::BWSR {
    struct BWSR has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BWSR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<BWSR>(arg0) + arg1 <= 10000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<BWSR>>(0x2::coin::mint<BWSR>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BWSR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWSR>(arg0, 6, b"BWSR", b"BWSR", b"BWSR Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/thumbs/bread.png?v=040")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BWSR>>(0x2::coin::mint<BWSR>(&mut v2, 10000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWSR>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BWSR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

