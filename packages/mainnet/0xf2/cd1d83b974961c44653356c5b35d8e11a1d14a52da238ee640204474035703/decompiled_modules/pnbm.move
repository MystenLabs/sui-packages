module 0xf2cd1d83b974961c44653356c5b35d8e11a1d14a52da238ee640204474035703::pnbm {
    struct PNBM has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PNBM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<PNBM>(arg0) + arg1 <= 10000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<PNBM>>(0x2::coin::mint<PNBM>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PNBM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNBM>(arg0, 6, b"PNBM", b"PNBM", b"PNBM Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://archive.cetus.zone/assets/image/sui/pyth.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PNBM>>(0x2::coin::mint<PNBM>(&mut v2, 10000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNBM>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PNBM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

