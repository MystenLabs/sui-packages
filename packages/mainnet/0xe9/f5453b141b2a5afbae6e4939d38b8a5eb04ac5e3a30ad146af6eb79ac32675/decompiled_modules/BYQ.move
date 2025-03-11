module 0xe9f5453b141b2a5afbae6e4939d38b8a5eb04ac5e3a30ad146af6eb79ac32675::BYQ {
    struct BYQ has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BYQ>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<BYQ>(arg0) + arg1 <= 10000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<BYQ>>(0x2::coin::mint<BYQ>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BYQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYQ>(arg0, 6, b"BYQ", b"BYQ", b"BYQ Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/thumbs/bitcoinz.png?v=040")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BYQ>>(0x2::coin::mint<BYQ>(&mut v2, 10000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYQ>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BYQ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

