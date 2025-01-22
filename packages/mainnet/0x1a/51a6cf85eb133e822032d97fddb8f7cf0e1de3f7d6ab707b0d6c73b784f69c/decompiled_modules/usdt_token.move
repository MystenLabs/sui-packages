module 0x1a51a6cf85eb133e822032d97fddb8f7cf0e1de3f7d6ab707b0d6c73b784f69c::usdt_token {
    struct USDT_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<USDT_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<USDT_TOKEN>(arg0) + arg1 <= 1000000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT_TOKEN>>(0x2::coin::mint<USDT_TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: USDT_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT_TOKEN>(arg0, 6, b"USDT", b"Tether USD", b"A stablecoin designed to maintain a 1:1 peg with the US Dollar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.okx.com/cdn/web3/currency/token/137-0x1e4a5963abfd975d8c9021ce480b42188849d41d-1.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT_TOKEN>>(0x2::coin::mint<USDT_TOKEN>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT_TOKEN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USDT_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

