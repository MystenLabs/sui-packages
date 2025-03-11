module 0x2cdd0f210857f04e0928dab95e7ba6a932f9e2433ef958cb7f64ebe3182cbebb::MOXO {
    struct MOXO has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOXO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<MOXO>(arg0) + arg1 <= 10000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<MOXO>>(0x2::coin::mint<MOXO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOXO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOXO>(arg0, 6, b"MOXO", b"MOXO", b"MOXO Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/mxc")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MOXO>>(0x2::coin::mint<MOXO>(&mut v2, 10000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOXO>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOXO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

