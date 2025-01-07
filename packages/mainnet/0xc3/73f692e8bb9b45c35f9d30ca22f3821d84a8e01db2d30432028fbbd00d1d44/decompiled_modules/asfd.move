module 0xc373f692e8bb9b45c35f9d30ca22f3821d84a8e01db2d30432028fbbd00d1d44::asfd {
    struct ASFD has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ASFD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ASFD>>(0x2::coin::mint<ASFD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ASFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASFD>(arg0, 4, b"ASFD", b"fsa", b"fsa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"fa"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASFD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ASFD>>(0x2::coin::mint<ASFD>(&mut v2, 100000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASFD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

